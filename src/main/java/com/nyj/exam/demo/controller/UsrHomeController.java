package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nyj.exam.demo.service.ArticleService;
import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.Rq;

@Controller
public class UsrHomeController {

	@Autowired
	ArticleService articleService;

	@Autowired
	BoardService boardService;
	
	@Autowired
	Rq rq;
	
	
	@RequestMapping("/")
	public String main() {
		if(rq.isLogined()) {
			return "redirect:/shop/customer/join";
		}
		return "redirect:/usr/member/login";  
	}
	
	
	@RequestMapping("/usr/home") 
	public String showHome(Model model, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int itemsCountInAPage ) { 

		List<Article> newArticles = articleService.getTenNewArticles(page,itemsCountInAPage); 
		model.addAttribute("newArticles", newArticles); 
		System.out.println(newArticles);
		
		for(Article a : newArticles) {
			System.out.println(a);
		}
		
		return "usr/home/index";
	}
	
//	@RequestMapping("/usr/home/getMore") 
//	@ResponseBody
//	public ResultData getMoreArticles(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int itemsCountInAPage ) { 
//		List<Article> newArticles = articleService.getTenNewArticles(page,itemsCountInAPage); 
//		ResultData rd = ResultData.form("S-1", "게시물 추가 성공", "NewArticles", newArticles);
//		
//		return rd;
//	}
	
	@RequestMapping("/portfolio")
	public String showIntro() {
		return "/usr/home/intro";  
	}
}
