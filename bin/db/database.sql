# DB생성
DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog;
USE blog;

# 게시물 테이블 생성
CREATE TABLE article(
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	title CHAR(100) NOT NULL,
	`body` TEXT NOT NULL	
);


# 회원테이블 추가
CREATE TABLE `member` (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	loginId CHAR(20) NOT NULL,
	loginPw CHAR(40) NOT NULL,
	`name` CHAR(20) NOT NULL,
	nickname CHAR(20) NOT NULL,
	email CHAR(50) NOT NULL,
	phoneNumber CHAR(20) NOT NULL,
	authLevel SMALLINT(2) NOT NULL,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0:탈퇴전/1:탈퇴',
	delDate DATETIME COMMENT '탈퇴날짜'
);

# 암호화 - 비번 칼럼의 길이를 100으로 늘림
ALTER TABLE `member`
MODIFY COLUMN loginPw VARCHAR(100) NOT NULL;

# 암호화 - salt
ALTER TABLE `member`
ADD COLUMN salt VARCHAR(20) NULL AFTER loginPw;

# 관리자 회원 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`name` = '관리자',
nickname = '내가 관리자',
email = '관리자@naver.com',
phoneNumber = '010-1111-1111',
authLevel = 10;  

# 게시물 테이블에 회원정보 추가
ALTER TABLE article 
ADD COLUMN memberId INT UNSIGNED NOT NULL AFTER updateDate;

# 기존 게시물 데이터 회원정보 변경
UPDATE article;

# 게시판 만들기
CREATE TABLE board(
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT ,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	`code` CHAR(40) NOT NULL UNIQUE COMMENT 'notice:공지사항, free:자유게시판...',
	`name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0:삭제전, 1:삭제',
	delDate DATETIME COMMENT '삭제 날짜'
);

# 기본 게시판 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

# 게시물 테이블에 게시판id 추가하기
ALTER TABLE article ADD COLUMN boardId INT NOT NULL AFTER updateDate;

# 게시물 boardId 지정
UPDATE article
SET boardId = 1;

# 게시물에 조회수 칼럼 추가
ALTER TABLE `article`
ADD COLUMN hit INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 좋아요, 싫어요 리액션포인트 테이블 생성
CREATE TABLE reactionPoint (
	id INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	memberId INT(10) UNSIGNED NOT NULL,
	relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
	relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터코드',
	`point` SMALLINT(2)
);

# 리액션포인트 테스트 데이터 생성
INSERT INTO reactionPoint 
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# 게시물에 좋아요, 싫어요 칼럼 추가
ALTER TABLE article
ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
 
ALTER TABLE article
ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reactionPoint 테이블의 좋아요, 싫어요 카운트 세서 article테이블에 넣기 
UPDATE article AS a
INNER JOIN(
	SELECT rp.relId,
	SUM(IF(`point`>0, POINT, 0)) AS good,
	SUM(IF(`point`<0, POINT * -1, 0)) AS bad
	FROM reactionPoint AS rp
	WHERE relTypeCode = 'article'
	GROUP BY rp.relId, rp.relTypeCode
) AS rpsum
ON a.id = rpsum.relId 
SET a.goodReactionPoint = rpsum.good,
a.badReactionPoint = rpsum.bad;

# 댓글 테이블 생성
CREATE TABLE `reply`(
	id INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	memberId INT(10) UNSIGNED NOT NULL,
	relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
	relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터',
	`body` TEXT NOT NULL
);

# 테스트 댓글 생성
INSERT INTO `reply`
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`body` = '이것이 첫번째 댓글 입니다~';

# 댓글에 좋아요 수, 싫어요 수 칼럼 추가
ALTER TABLE reply
ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE reply
ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 댓글 테이블 인덱스 걸기
ALTER TABLE reply
ADD INDEX (relTypeCode, relId);

# 부가정보테이블
CREATE TABLE attr(
	id INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	relTypeCode CHAR(20) NOT NULL,
	relId INT(10) NOT NULL,
	typeCode CHAR(30) NOT NULL,
	type2Code CHAR(70) NOT NULL,
	`value` TEXT NOT NULL,
	expireDate DATETIME NULL
);

# attr 유니크 인덱스 걸기
# 중복변수 생성금지
# 변수찾는 속도 최적화
ALTER TABLE attr ADD UNIQUE INDEX (relTypeCode, relId, typeCode, type2Code);

# 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE attr ADD INDEX (relTypeCode,typeCode,type2Code);

# 회원 loginId 유니크 인덱스 추가
ALTER TABLE `member` ADD UNIQUE INDEX (`loginId`);
	
# 회원 삭제시 회원이 작성한 게시물 삭제
ALTER TABLE article 
ADD FOREIGN KEY (memberId)
REFERENCES `member` (id)
ON DELETE CASCADE;

# 회원 삭제시 회원이 작성한 댓글 삭제
ALTER TABLE article 
ADD FOREIGN KEY (memberId)
REFERENCES `member` (id)
ON DELETE CASCADE;

# 회원 회원 삭제시 회원 관련 리액션포인트 삭제
ALTER TABLE `reactionPoint`
ADD CONSTRAINT fk
FOREIGN KEY(memberId)
REFERENCES `member`(id) 
ON DELETE CASCADE;

# 게시판 id 와 게시글 boardId 데이터 타입 동일하게 만들어주기
ALTER TABLE article
MODIFY `boardId` INT UNSIGNED NOT NULL;

# 게시판 삭제시 게시글 삭제
ALTER TABLE article
ADD CONSTRAINT FOREIGN KEY (boardId)
REFERENCES board(id)
ON DELETE CASCADE;

# 게시판 댓글 사용여부 칼럼 추가
ALTER TABLE board
ADD COLUMN replyStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0:미사용, 1:사용' AFTER `name`; 

# 게시판 리액션포인트 사용여부 칼럼 추가
ALTER TABLE board
ADD COLUMN reactionPointStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0:미사용, 1:사용' AFTER `name`; 

# 암호화 - member loginPw 칼럼 길이 늘림
ALTER TABLE `member`
MODIFY COLUMN loginPw VARCHAR(100) NOT NULL;


# 방문자수 table 생성
CREATE TABLE visit(
id INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
articleId INT(10) UNSIGNED NOT NULL, 
regDate DATETIME NOT NULL
); 

# 게시판테이블 공개여부 칼럼 추가
ALTER TABLE board
ADD COLUMN publicStatus BOOLEAN NOT NULL DEFAULT 1 COMMENT '0:미사용, 1:사용' AFTER replyStatus;

ALTER TABLE board
MODIFY COLUMN replyStatus BOOLEAN NOT NULL DEFAULT 1 COMMENT '﻿0:미사용, 1:사용' ;

ALTER TABLE board
MODIFY COLUMN reactionPointStatus BOOLEAN NOT NULL DEFAULT 1 COMMENT '﻿0:미사용, 1:사용' ;
  
# 출석체크 테이블 생성
CREATE TABLE attendance(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, # 번호
	memberId INT(10) NOT NULL,
	title CHAR(30) NOT NULL,
	`start` CHAR(30) NOT NULL,
	`end` CHAR(30) NULL,
	allDay BOOLEAN NOT NULL DEFAULT 1,
	PRIMARY KEY (id)
);

# 댓글테이블 작성자이름, 비밀빈호, salt 컬럼 추가
ALTER TABLE reply
ADD writer VARCHAR(20) AFTER memberId;

ALTER TABLE reply
ADD pw VARCHAR(100) AFTER writer;

ALTER TABLE reply
ADD salt VARCHAR(100) AFTER pw;

# 댓글테이블 memberId 제약조건 변경 - null 허용
ALTER TABLE reply
MODIFY memberId INT(10) UNSIGNED NULL;

# 게시판에 링크컬럼 추가
ALTER TABLE board
ADD COLUMN link VARCHAR(100) NULL AFTER NAME;


# 파일 테이블 생성
CREATE TABLE genFile(
 id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 regDate DATETIME,
 updateDate DATETIME,
 delDate DATETIME DEFAULT NULL,
 delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT "삭제상태(0:미삭제,1:삭제)",
 relTypeCode VARCHAR(50) NOT NULL COMMENT '관련 데이터 타입(article, member)',
 relId INT(10) UNSIGNED NOT NULL,
 originFileName VARCHAR(100) NOT NULL COMMENT '업로드 당시의 파일이름',
 fileExt VARCHAR(10) NOT NULL COMMENT '확장자',
 typeCode VARCHAR(20) NOT NULL COMMENT '종류코드 (common)',
 type2Code VARCHAR(20) NOT NULL COMMENT '종류2코드 (attatchment)',
 fileSize INT(10) UNSIGNED NOT NULL,
 fileExtTypeCode VARCHAR(10) NOT NULL COMMENT '파일규격코드(img, video)	',
 fileExtType2Code VARCHAR(10) NOT NULL COMMENT '파일규격2코드(jpg, mp4)',
 fileNo SMALLINT(2) UNSIGNED NOT NULL COMMENT' 파일번호 (1)',
 fileDir CHAR(20) NOT NULL,
 PRIMARY KEY(id),
 KEY relId(relTypeCode, relId, typeCode, type2Code, fileNo)
);
