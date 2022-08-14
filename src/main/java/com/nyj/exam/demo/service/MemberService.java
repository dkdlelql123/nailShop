package com.nyj.exam.demo.service;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.MemberRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class MemberService {

	@Autowired
	MemberRepository memberRepository;
	
	@Autowired
	AttrService attrService;
	
	@Autowired
	ArticleService articleService;
	
	@Autowired
	ReplyService replyService;

	@Autowired
	ReactionPointService reactionPointService;

	
	public ResultData doCheckLoginId(String loginId) {
		Member oldMember = getMemberLoginId(loginId);
		if(oldMember != null) {
			return ResultData.form("F-1", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}
		return ResultData.form("S-1", Ut.f("사용 가능한 아이디입니다.", loginId));
	}
	
	public ResultData join(String loginId, String loginPw, String email, String name, String nickname, String phoneNumber) {
		Member oldMember = getMemberLoginId(loginId); 
		
		oldMember = getMemberByNameAndEmail(name, email);
		if(oldMember != null) {
			return ResultData.form("F-2", Ut.f("이미 사용중인 이름(%s)와 이메일(%s) 입니다", name, email));
		}
		
		String salt = getSalt();
		String encrypt = getEncrypt(loginPw, salt);
		
		memberRepository.join(loginId, encrypt, salt, email, name, nickname, phoneNumber);
		return ResultData.form("S-1", "회원가입이 완료되었습니다.");
	}
	
	public String getEncrypt(String loginPw, String salt) {
		String result = "";
		try {	
			// SHA-256 알고리즘 객체 생성
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			
			// password + salt 합친 문자열에 SHA-256 적용
			md.update((loginPw + salt).getBytes() );
			byte[] pwdsalt = md.digest();
			
			// byte to String
			StringBuffer sb = new StringBuffer();
			for(byte b : pwdsalt) {
				sb.append(String.format("%02x", b));
			}
			
			result = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public String getSalt() {
		// SecureRandom, byte 객체 생성
		SecureRandom r = new SecureRandom();
		byte[] salt = new byte[10];
		
		// 난수 생성
		r.nextBytes(salt);
		
		// byte To String (10진수 문자열 변경)
		StringBuffer sb = new StringBuffer();
		for(byte b : salt) {
			sb.append(String.format("%02x", b));
		}
		
		return sb.toString();
	}

	public int getLastInsertId() {
		return memberRepository.getLastInsertId();
	}
	
	public Member getMemberLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
	
	public Member getForPrintMemberById(int id) {
		return memberRepository.getForPrintMemberById(id);
	}
	
	public Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	public ResultData doModify(int memberId, String loginPw, String email, String nickname, String phoneNumber) {
		Member oldMember = getMemberById(memberId);
		
		if(oldMember == null) {			
			return ResultData.form("F-1", "회원정보가 없습니다.");
		}
		
		String salt = null;
		String encrypt = null;
		
		if(loginPw != null) {
			salt = getSalt();
			encrypt = getEncrypt(loginPw, salt);			
		}
		
		memberRepository.modify(memberId, encrypt, salt, email, nickname, phoneNumber);
		
		return ResultData.form("S-1", "정보수정이 완료되었습니다.");
	}

	public String genMemberModifyAuthKey(int memberId) {
		String memberModifyAuthKey = Ut.getTempPassword(10);  
		
		// 순서 : relTypeCode, relId, typeCode, type2Code, value, exprieDate 
		attrService.setValue("member", memberId, "extra", "memberModifyAuthKey", memberModifyAuthKey, Ut.getDataStrLater(60*5));
		
		return memberModifyAuthKey;
	} 
	public ResultData checkMemberModifyAuthKey(int loginedMemberId, String memberModifyAuthKey) {
		// 순서 : relTypeCode relId typeCode type2Code
		String value = attrService.getValue("member", loginedMemberId, "extra", "memberModifyAuthKey");
		System.out.println("value:  "+value);
		System.out.println("memberModifyAuthKey:  "+memberModifyAuthKey);
		
		if(memberModifyAuthKey.equals(value) == false) {			
			return ResultData.form("F-1", "인증키가 올바르지 않습니다.");
		}
		
		return ResultData.form("S-1", "인증에 성공했습니다.");
	}

	public int getALLMembersCount() {
		return memberRepository.getALLMembersCount();
	}
	
	public int getMembersCount(String searchKeywordType, String searchKeyword, int searchAuthLevel ) { 
		return memberRepository.getMembersCount(searchKeywordType, searchKeyword, searchAuthLevel);
	}

	public List<Member> getForPrintMembers(String searchKeywordType, String searchKeyword, int searchAuthLevel, int page,
			int itemsCountInAPage) {
		int limitStart = (page-1) * itemsCountInAPage ;
		int limitTake = itemsCountInAPage;
		return memberRepository.getForPrintMembers(searchKeywordType, searchKeyword,searchAuthLevel, limitStart, limitTake);
	}

	public ResultData doDeleteMembers(List<Integer> memberIds) {
		for(int id : memberIds) {
			Member member = getMemberById(id);
			if(member==null) {
				return ResultData.form("F-1", "해당 회원이 없습니다.", "member", id);
			} else if(member!=null) {
				doDelete(member);
			}
		}
		
		return ResultData.form("S-1", "회원 삭제가 성공했습니다.");
	}

	public void doDelete(Member member) {
		memberRepository.delete(member.getId());
		//articleService.deleteFromMember(member.getId());
		//replyService.deleteReplyFromMember(member.getId());
		//reactionPointService.deleteReactionPointFromMember(member.getId());
	}

	public void changePw(int id, String loginPw, String salt) { 
		memberRepository.changePw(id, loginPw, salt);
	}
 

	
}
