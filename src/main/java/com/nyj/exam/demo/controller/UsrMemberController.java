package com.nyj.exam.demo.controller; 

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.nyj.exam.demo.service.ArticleService;
import com.nyj.exam.demo.service.GenFileService;
import com.nyj.exam.demo.service.MailService;
import com.nyj.exam.demo.service.MemberService;
import com.nyj.exam.demo.service.ReplyService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.Mail;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.Reply;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Rq;

@Controller
public class UsrMemberController {

	@Autowired
	MemberService memberService; 
	
	@Autowired
	MailService mailService; 
	
	@Autowired
	ArticleService articleService; 
	
	@Autowired
	ReplyService replyService;  

	@Autowired
	GenFileService genFileService; 

	private Rq rq;

	public UsrMemberController(Rq rq) {
		this.rq = rq;
	}

	@RequestMapping("/usr/member/join")
	public String showJoin() { 	
		return "/usr/member/join";
	}
	
	@RequestMapping("usr/member/doCheckLoginId")
	@ResponseBody
	public ResultData doCheckLoginId(String loginId) {
		ResultData doCheckLoginIdRd = memberService.doCheckLoginId(loginId);
		return doCheckLoginIdRd;
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(MultipartRequest multipartReq, String loginId, String loginPw, String email, String name, String nickname, String phoneNumber) {
		
		ResultData joinRd = memberService.join(loginId, loginPw, email, name, nickname, phoneNumber);
		if (joinRd.isFail()) {
			return Ut.jsHistoryBack(joinRd.getMsg());
		}

		int newMemberId = memberService.getLastInsertId();
		
		Map<String, MultipartFile> fileMap = multipartReq.getFileMap();
		
		for(String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);
			
			if(multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, newMemberId); 
				System.out.println(multipartFile);
			}
		} 	 
		
		Member member = memberService.getMemberById(newMemberId);
		rq.login(member);  

		//return Ut.jsReplace("????????? ?????? ??????????????????.", "/usr/member/login");
		return Ut.jsReplace(Ut.f("%s??? ???????????????.", member.getNickname()), "/");
	}
	

	@RequestMapping("/usr/member/login")
	public String showLogin() { 
		return "/usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {
		if (rq.isLogined() == true) {
			return Ut.jsHistoryBack("?????? ????????? ???????????????");
		}

		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("???????????? ??????????????????.");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("??????????????? ??????????????????.");
		}

		Member member = memberService.getMemberLoginId(loginId);
		if (member == null) {
			return Ut.jsHistoryBack("??????????????? ????????????.");
		}

		String salt = "";
		String encrypt = loginPw;
		String msg = Ut.f("%s??? ???????????????.", member.getNickname());
		
		if( member.getSalt() != null && member.getSalt().length() > 0) { 
			salt = member.getSalt();
			encrypt = Ut.sha256(loginPw, salt);
		} else {
			// salt??? ?????? ??????
			afterLoginUri = "/usr/member/checkPassword";
			afterLoginUri += "?replaceUri=../member/modify";
			msg = Ut.f("%s??? ??????????????? ??????????????????.", member.getNickname());			
		}

		if (member.getLoginPw().equals(encrypt) == false) {
			return Ut.jsHistoryBack("????????? ????????? ???????????? ????????????.");
		}

		rq.login(member);  
		
		return Ut.jsReplace(msg, afterLoginUri);
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {
		 if (!rq.isLogined()) {
			return Ut.jsHistoryBack("?????? ???????????? ???????????????");
		} 

		rq.logout();

		return Ut.jsReplace("???????????? ???????????????", afterLogoutUri);
	}
	
	@RequestMapping("/usr/member/mypage")
	public String showMyPage(Model model) {
		Member member = rq.getMember();
		model.addAttribute("member", member);
		
		List<Article> articleList = articleService.getArticlesByMemberId(member.getId(),0,0);
		model.addAttribute("articleList", articleList);
		
		List<Reply> ReplyList = replyService.getReplyByMemberId(member.getId(),0,0);
		model.addAttribute("replyList", ReplyList);
		
		return "/usr/member/mypage";
	}
	 
	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() { 
		return "/usr/member/checkPassword";
	}
	
	@RequestMapping("/usr/member/doCheckPassword")
	@ResponseBody
	public String doCheckPassword(String loginPw, String replaceUri) {  
		String salt = "";
		String encrypt = loginPw;
		
		if(rq.getMember().getSalt() !=null && rq.getMember().getSalt().length() > 0) {
			salt = rq.getMember().getSalt();
			encrypt = Ut.sha256(loginPw, salt);
		} 		 
		
		if(rq.getMember().getLoginPw().equals(encrypt) == false) {
			return Ut.jsHistoryBack("??????????????? ???????????? ????????????");
		}
		
		if(replaceUri.equals("../member/modify")) {
			String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedMemberId());
			replaceUri += "?memberModifyAuthKey="+memberModifyAuthKey ;
		}
		
		return Ut.jsReplace("", replaceUri);
	}
	
	@RequestMapping("/usr/member/modify")
	public String showModify(Model model, String memberModifyAuthKey) {
		if(Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackJsOnView("???????????? ????????????. ????????? ???????????? ??????????????????.");
		}
		
		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);
		
		if(checkMemberModifyAuthKeyRd.isFail()) {
			return rq.historyBackJsOnView(checkMemberModifyAuthKeyRd.getMsg());
		}
		
		model.addAttribute("member", rq.getMember());
				
		return "/usr/member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(MultipartRequest multipartReq, String loginPw, String loginPw2, String email,String nickname, String phoneNumber, String memberModifyAuthKey) {
		if(Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackJsOnView("???????????? ????????????. ????????? ???????????? ??????????????????.");
		}
		
		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);
		
		if(checkMemberModifyAuthKeyRd.isFail()) {
			return rq.historyBackJsOnView(checkMemberModifyAuthKeyRd.getMsg());
		}
		
		if(loginPw.trim().length() <= 0) {
			loginPw = null;
		} else {
			if(loginPw.equals(loginPw2) == false) {
				return Ut.jsHistoryBack("??? ??????????????? ???????????? ????????????.");
			}
		} 
		
		ResultData doModifyRd = memberService.doModify( rq.getLoginedMemberId(), loginPw, email, nickname, phoneNumber);
		
		if (doModifyRd.isFail()) {
			return Ut.jsHistoryBack(doModifyRd.getMsg());
		}
		 
		// 
		if ( rq.getRequest().getParameter("deleteFile__member__0__extra__profileImg__1") != null ) {
            genFileService.deleteGenFile("member", rq.getLoginedMemberId(), "extra", "profileImg", 1);
        }
		
		Map<String, MultipartFile> fileMap = multipartReq.getFileMap();
		
		for(String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);
			
			if(multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, rq.getLoginedMemberId());
				System.out.println("=================multipartFile===================");
				System.out.println(multipartFile);
			}
		} 
		
		return Ut.jsReplace("????????????????????? ?????????????????????.", "/usr/member/mypage");
	} 
	
	@RequestMapping("/usr/member/findMember") 
	public String showFindMember() {
		return "/usr/member/findMember";
	}
	
	@RequestMapping("/usr/member/findLoginId")
	@ResponseBody
	public ResultData findLoginId(String name, String email, Model model) {
		Member member = memberService.getMemberByNameAndEmail(name, email);
		if(member == null) {
			return ResultData.form("F-1", "????????? ???????????? ????????? ????????????.");
		}
		
		model.addAttribute("loginId", member.getLoginId());
		return ResultData.form("S-1", "?????? ???????????? ???????????????", "member", member.getLoginId());
	}

	@RequestMapping("/usr/member/findLoginPassword") 
	@ResponseBody
	public ResultData showfoundMember(String loginId, String email, Model model) {
		
		Member member = memberService.getMemberLoginId(loginId);
		if(member == null || member.getEmail().equals(email) == false)  {
			return  ResultData.form("F-1", "????????? ???????????? ????????? ????????????.");
		}
		
		// 1. ?????? ???????????? ?????? 
		// 2. ?????? ?????? - mailService
		Mail mail = mailService.createMailAndChangePassword(member);
		mailService.mailSend(mail);
		
		// 3. ?????? ??????????????? ?????? ?????? ?????? - memberService
		String salt = member.getSalt();
		String encrypt = Ut.sha256(mail.getNewPw(), salt);
		memberService.changePw(member.getId(), encrypt, salt);
		
		return ResultData.form("S-1", "?????? ??????????????? ???????????? ??????????????????.", "mail", mail);
	}
	
}
