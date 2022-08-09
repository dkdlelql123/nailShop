package com.nyj.exam.demo.vo;

import lombok.Getter;
import lombok.ToString;

@ToString
public class ResultData {
	@Getter
	String resultCode;

	@Getter
	String msg;
	
	@Getter
	String data1msg;
	
	@Getter
	Object data1;
	
	@Getter
	String data2msg;
	
	@Getter
	Object data2;

	private ResultData() {
	}
	
	public static ResultData form(String resultCode, String msg) {
		return form(resultCode, msg, null, null);
	}
	
	public static ResultData form(String resultCode, String msg, Object data1) {
		return form(resultCode, msg, null, data1);
	}
	
	public static ResultData form(String resultCode, String msg, String data1msg, Object data1) {
		ResultData rd = new ResultData();
		
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1msg = data1msg;
		rd.data1 = data1;
		
		return rd; 
	}
	
	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}
	
	public boolean isFail() {
		return isSuccess() == false;
	}
	
	public static ResultData newData(ResultData rd, Object obj) {
		ResultData newRd = new ResultData();
		
		newRd.resultCode = rd.getResultCode();
		newRd.msg = rd.getMsg(); 
		newRd.data1 = obj;
		
		return newRd;
	}
	
	public static ResultData newData(ResultData rd, String data1msg, Object data1) {
		ResultData newRd = new ResultData();
		
		newRd.resultCode = rd.getResultCode();
		newRd.msg = rd.getMsg();
		newRd.data1msg = data1msg;
		newRd.data1 = data1;
		
		return newRd;
	} 

	public void setData2(String msg, Object obj) {
		this.data2msg = msg;
		this.data2 = obj;
	}
	
}
