package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	List<Reply> getForPrintReplies(int id, String relTypeCode);

	Reply getForPrintReply(int id);

	void doDelete(int id);

	void doModify(int id, String body);

	int increaseGoodReactionPoint(int id);
	
	int increaseBadReactionPoint(int id);

	int decreaseReactionPoint(int relId, String cancelReaction);

	void deleteReplyFromMember(int memberId);
	
	void doMemberWriteReply(int memberId, String pw, String salt, String relTypeCode, int relId, String body);

	void doNonMemberWriteReply(String writer, String pw, String salt, String relTypeCode, int relId, String body);

	List<Reply> getNewReplies(); 

	List<Reply> getReplyByMemberId(int memberId, int limitStart, int limitTake);
}
