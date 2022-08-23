package com.nyj.exam.demo.controller;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nyj.exam.demo.service.ArticleService;
import com.nyj.exam.demo.service.MemberService;
import com.nyj.exam.demo.service.VisitService;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.Rq;

@Controller
public class AdmHomeController {
	private Rq rq;
	
	@Autowired
	VisitService visitService; 
	@Autowired
	ArticleService articleService; 
	@Autowired
	MemberService memberService; 
	
	public AdmHomeController(Rq rq) {
		this.rq = rq;
	}	
	
	@RequestMapping("/adm")
	public String main() {
		return "redirect:/adm/home";
	}
	
	@RequestMapping("/adm/home")
	public String showMain(Model model) {
		
		int total = visitService.getTotalCount();
		int today = visitService.getTodayCount();
		int yesterday = visitService.getYesterdayCount();
		model.addAttribute("total", total);
		model.addAttribute("today", today);
		model.addAttribute("yesterday", yesterday);
		
		List<Article> articleList = articleService.getNewArticles();
		model.addAttribute("articleList", articleList);
		
		List<Member> memberList = memberService.getNewMembers();
		model.addAttribute("memberList", memberList); 
		
		return "/adm/home/index";
	}
	
}
