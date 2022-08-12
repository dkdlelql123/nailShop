package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	int id;
	String regDate;
	String updateDate;
	String code;
	String name;
	
	int replyStatus;
	int reactionPointStatus;
	int publicStatus;
	
	int delStatus;
	String delDate;
	
	int extra__articleCount; 
	
	public String getForPrintType1RegData() {
		return regDate.substring(0,19);
	}

	public String getForPrintType1UpdateData() {
		return updateDate.substring(0,19);
	}
}
