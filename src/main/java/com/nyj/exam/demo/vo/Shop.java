package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Shop {
	/** pk */
	int id;
	/** 등록일 */
	String regDate;
	/** 수정일 */
	String updateDate; 
	/** 카테고리명 */
	String name;
	/** 참조 카테고리 */
	int relId;
	/** 카테고리 링크 */
	String link;
	/** 카테고리 설명 */
	String desc;
	/** 사용여부 */
	int useYn; 
	
	/** category */
	String category;
	/** LEVEL */
	int level;
	/** parentName */
	String parentName;
}
