package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
	private int id;
	private int memberId;
	private String title;
	private String start;
	private String end;
	private int allDay;
}
