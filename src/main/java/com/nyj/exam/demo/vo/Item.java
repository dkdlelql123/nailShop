package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Item {
	/** pk */
	int id;
	/** 등록일 */
	String regDate;
	/** 수정일 */
	String updateDate;  
	/** 작성자ID */
	int memberId;
	/** 작성자ID */
	String memberName;
	/** 카테고리ID */
	int categoryId;
	/** 상풍명 */
	String name;
	/** 카테고리 링크 */
	String link;
	/** 카테고리 설명 */
	String desc;
	
	/** 톤 타입 */
	String toneType;
	/** 계절 */
	String seasonType;
	/** 가격 */
	int price;
	/** 세일가격 */
	int sale;
	
	/** 사용여부 */
	int useYn;  
	 
}
