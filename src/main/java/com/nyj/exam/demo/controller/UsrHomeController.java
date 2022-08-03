package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.ArticleService;
import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.Board;

@Controller
public class UsrHomeController {

	@Autowired
	ArticleService articleService;

	@Autowired
	BoardService boardService;
	
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/usr/home";  
	}
	
	
	@RequestMapping("/usr/home") 
	public String showHome(Model model) { 
		
		// 조회수 높은 글
		List<Article> bestArticles = articleService.getBestArticles();
		model.addAttribute("bestArticles", bestArticles);

		// 새로 작성된 글
		List<Article> newArticles = articleService.getNewArticles();
		model.addAttribute("newArticles", newArticles);
		
		return "usr/home/index";
	}
}
