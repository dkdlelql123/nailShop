package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Attendance; 

@Mapper
public interface CalendarRepository {

	void checkAttendance(String title, String start, int memberId);

	int getLastInsertId();

	Attendance getAttendanceById(int id);

	Attendance getAttendanceByMemberIdAndStart(String start, int memberId);
	
	List<Attendance> getAllAttendance();

}
