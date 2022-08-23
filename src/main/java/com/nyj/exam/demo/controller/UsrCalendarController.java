package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.CalendarService;
import com.nyj.exam.demo.service.MemberService;
import com.nyj.exam.demo.vo.Attendance;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.ResultData;

@Controller
public class UsrCalendarController { 
	
	@Autowired
	CalendarService calendarService;
	
	@Autowired
	MemberService memberService; 
	
	@RequestMapping("/usr/attendance") 
	public String showAttendance(Model model) { 
		return "usr/contact/attendance";
	}
	
	@RequestMapping("/usr/attendance/check") 
	@ResponseBody
	public ResultData checkAttendance(String title, String start, int memberId) {
		
		Member member = memberService.getMemberById(memberId);
		if(member == null) { 
			return ResultData.form("F-0", "로그인 이후 사용이 가능합니다.");
		}		
		
		Attendance che = calendarService.getAttendanceByMemberIdAndStart(start, memberId); 
		if(che != null) {
			return ResultData.form("F-1", "이미 출석했습니다.", "이미 출석한 계정", che); 
		}
		
		String newTitle = title + " - "+ member.getNickname();
		ResultData rd = calendarService.checkAttendance(newTitle, start, memberId);  
		Attendance attendance = calendarService.getAttendanceById((int)rd.getData1()); 
		
		if(attendance == null) {
			return ResultData.form("F-2", "출석체크 실패");
		}
		
		return ResultData.form("S-1", "출석체크 성공", "attendance", attendance);
	}
	
	@RequestMapping("/usr/attendance/list") 
	@ResponseBody
	public List<Attendance> doGetAttendances() {
		List<Attendance> lists = calendarService.getAllAttendance();
		if(lists.size() == 0) {
			ResultData.form("F-1", "출석체크 실패");
		} 
		return lists;
	} 
}
