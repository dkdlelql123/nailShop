package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ReplyRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Reply;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class ReplyService {

	@Autowired
	ReplyRepository replyRepository;
	 
	public List<Reply> getForPrintReplies(int memberId, int id, String relTypeCode) {
		List<Reply> replies = replyRepository.getForPrintReplies(id, relTypeCode); 
		 
		for (Reply reply : replies) {
			ResultData rd = actorCanEdit(reply, memberId);
			reply.setExtra__actorCanEdit(rd.isSuccess());	
		} 
		
		return replies;
	}

	private ResultData actorCanEdit(Reply reply, int memberId) { //수정 삭제 권한체크
		if (reply == null) {
			return ResultData.form("F-1", "해당 댓글이 없습니다");
		}
		if (reply.getMemberId() != memberId) {
			return ResultData.form("F-2", "권한이 없습니다");
		}
		return ResultData.form("S-1", "게시물 변경이 가능합니다.", reply);
	}

	public ResultData doMemberWriteReply(int memberId, String pw, String relTypeCode, int relId, String body) {
		String salt = Ut.getSalt();
		String encrypt = Ut.sha256(pw, salt);
		
		replyRepository.doMemberWriteReply(memberId, encrypt, salt, relTypeCode, relId, body);
		return ResultData.form("S-1", "회원님 댓글을 등록되었습니다.");
	}
	
	public ResultData doNonMemberWriteReply(String writer, String pw, String relTypeCode, int relId, String body) {
		String salt = Ut.getSalt();
		String encrypt = Ut.sha256(pw, salt);
		
		replyRepository.doNonMemberWriteReply(writer, encrypt, salt, relTypeCode, relId, body);
		return ResultData.form("S-1", Ut.f("%s님 댓글을 등록되었습니다.", writer));
	}

	public void doDelete(int id) {
		replyRepository.doDelete(id);
	}

	public void doModify(int id, String body) {
		replyRepository.doModify(id, body);
	}

	public Reply getForPrintReply(int id) {
		Reply reply = replyRepository.getForPrintReply(id);
		
		return reply;
	}
	
	public ResultData increaseGoodReactionPoint(int relId) {
		int affectedCount= replyRepository.increaseGoodReactionPoint(relId);
		if(affectedCount == 0) {
			return ResultData.form("F-1", "해당 게시물이 존재하지 않습니다.", "affectedCount", affectedCount);			
		}
		return ResultData.form("S-1", "좋아요 + 1", "affectedCount", affectedCount);
	}

	public ResultData increaseBadReactionPoint(int relId) {
		int affectedCount= replyRepository.increaseBadReactionPoint(relId);
		if(affectedCount == 0) {
			return ResultData.form("F-1", "해당 게시물이 존재하지 않습니다.", "affectedCount", affectedCount);			
		}
		return ResultData.form("S-1", "싫어요 + 1", "affectedCount", affectedCount);
	}

	public ResultData decreaseReactionPoint(int relId, String cancleReaction) {
		int affectedCount = 0;
		System.out.println("cancleReaction: "+cancleReaction);
		
		if(cancleReaction.equals("good")) {
			affectedCount = replyRepository.decreaseReactionPoint(relId, "goodReactionPoint");
		} else if(cancleReaction.equals("bad")) {
			affectedCount = replyRepository.decreaseReactionPoint(relId, "badReactionPoint");
		}
	 
		if( affectedCount == 0 ) {
			return ResultData.form("F-1", "해당 게시물이 존재하지 않습니다.", "affectedCount", affectedCount);			
		}
		return ResultData.form("S-1", "리액션 헤제", "affectedCount", affectedCount);
		
	}

	public void deleteReplyFromMember(int memberId) {
		replyRepository.deleteReplyFromMember(memberId);
	}

	public List<Reply> getNewReplies() {
		return replyRepository.getNewReplies();
	}

}
