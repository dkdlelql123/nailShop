package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	
	private int memberId;
	private String writer;
	private String pw;
	private String salt;
	
	private String relTypeCode;
	private int relId;
	private String body;
	
	private String extra__writerName;
	private boolean extra__actorCanEdit;

	private String extra__reactionStatus;
	private int extra__sumReactionPoint;
	private int goodReactionPoint;
	private int badReactionPoint;
	
	public String getForPrintType1RegDate() {
		return regDate.substring(2,10);
	}
	
	public String getForPrintType1UpdateDate() {
		return updateDate.substring(2,10);
	}
	
	public String getForPrintType2RegDate() {
		return regDate.substring(2,16);
	}
	
	public String getForPrintType2UpdateDate() {
		return updateDate.substring(2,16);
	}
}
