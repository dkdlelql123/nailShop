package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	List<Reply> getForPrintReplies(int id, String relTypeCode);
	
}
