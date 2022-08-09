package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
 
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Visit {
	private int id;
	private int articleId;  
	private String regDate; 
	
	private int extra__totalCount;
	private int extra__todayCount;
}
