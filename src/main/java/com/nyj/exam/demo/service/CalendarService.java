package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.CalendarRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Attendance;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class CalendarService {

	@Autowired
	CalendarRepository calendarRepository;

	public ResultData checkAttendance(String title, String start, int memberId) {
		if(Ut.empty(memberId)) {
			ResultData.form("F-1", "회원만 사용가능합니다.");
		}
		
		calendarRepository.checkAttendance(title, start, memberId);

		int id = calendarRepository.getLastInsertId(); 
		
		return ResultData.form("S-1", Ut.f("%d번째 출석체크입니다", id), id); 
	}
	
	public List<Attendance> getAllAttendance() { 
		List<Attendance> list = calendarRepository.getAllAttendance(); 
		return list;
	}

	public Attendance getAttendanceById(int id) { 
		return calendarRepository.getAttendanceById(id); 
	}

	public Attendance getAttendanceByMemberIdAndStart(String start, int memberId) {
		return calendarRepository.getAttendanceByMemberIdAndStart(start, memberId); 
	}
}
