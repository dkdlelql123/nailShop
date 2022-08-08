package com.nyj.exam.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.MemberService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Rq;

@Controller
public class AdmMemberController {
	
	@Autowired
	MemberService memberService; 
	
	private Rq rq;
	
	public AdmMemberController(Rq rq) {
		this.rq = rq;
	}
	
	@RequestMapping("/adm/member/list")
	public String showMemberList(Model model,
			@RequestParam(defaultValue = "1") int searchAuthLevel, 
			@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "10") int itemsCountInAPage, 
			@RequestParam(defaultValue = "title,body") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		model.addAttribute("authLevel", searchAuthLevel);
		
		int membersCount =  memberService.getMembersCount(searchKeywordType, searchKeyword, searchAuthLevel);
		model.addAttribute("membersCount", membersCount);
		
		int pagesCount = (int) Math.ceil((double)membersCount / itemsCountInAPage);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page);
	
		List<Member> list = memberService.getForPrintMembers(searchKeywordType, searchKeyword, searchAuthLevel, page, itemsCountInAPage);
		model.addAttribute("members", list);
		
		return "adm/member/list";
	}
	
	@RequestMapping("/adm/members/doDelete")
	@ResponseBody
	public String doDeleteMembers(@RequestParam(defaultValue = "") String ids, @RequestParam(defaultValue = "/adm/member/list") String replaceUri) {
		List<Integer> memberIds = new ArrayList<>();
		
		for(String str : ids.split(",") ) {
			memberIds.add(Integer.parseInt(str));
		}
		
		ResultData rd = memberService.doDeleteMembers(memberIds);
		
		if(rd.isFail()) {
			return Ut.jsHistoryBack(rd.getMsg());
		}
		
		return Ut.jsReplace(rd.getMsg(), replaceUri);
	}
	
	@RequestMapping("/adm/member/detail")
	public String showMemberDetail(int id, Model model) {
		
		Member member = memberService.getForPrintMemberById(id);
		if(member == null) {
			return "";
		}
		
		model.addAttribute("member", member);
		
		
		return "adm/member/detail";
	}
	
	@RequestMapping("/adm/member/modify")
	public String showMemberModify() {
		return "adm/member/modify";
	}
	
}
