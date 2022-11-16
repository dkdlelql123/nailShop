package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Customer {
	/** pk */
	int id;
	/** 등록일 */
	String regDate;
	/** 수정일 */
	String updateDate; 
	/** 코드 */
	String code;
	/** 이름 */
	String name;
	/** 전화번호 뒷자리 4글자 */
	String phoneNumber;

}
