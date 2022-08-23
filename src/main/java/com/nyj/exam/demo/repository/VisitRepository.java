package com.nyj.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VisitRepository {

	void increaseHitCount(int articleId);

	int getTodayCount();

	int getTotalCount();

	int getYesterdayCount();

}
