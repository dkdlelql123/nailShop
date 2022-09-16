package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String title;
	private String body;

	private String regDate;
	private String updateDate;
	
	private int hit;
	
	private int boardId;
	private String extra__boardName;
	private int extra__publicStatus;
	private int extra__replyStatus;
	private int extra__reactionPointStatus;
	
	private int memberId;
	private String extra__writerName;
	private boolean extra__actorCanEdit;

	private int extra__replyCount;
	
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
