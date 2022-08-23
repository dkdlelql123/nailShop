package com.nyj.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.VisitRepository;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class VisitService {
	@Autowired
	VisitRepository visitRepository;

	public ResultData increaseHitCount(int articleId) { 
		visitRepository.increaseHitCount(articleId);
		
		int total = getTotalCount();
		int today = getTodayCount();
		ResultData rd = ResultData.form("S-1", "투데이, 토탈 조회수" , "today", today); 
		rd.setData2("total", total);
		
		return rd;
	}

	public int getTodayCount() { 
		return visitRepository.getTodayCount();
	}

	public int getTotalCount() { 
		return visitRepository.getTotalCount();
	}

	public int getYesterdayCount() {
		return visitRepository.getYesterdayCount();
	} 
}
