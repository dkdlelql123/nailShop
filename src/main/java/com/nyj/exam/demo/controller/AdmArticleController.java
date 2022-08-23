package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nyj.exam.demo.service.ArticleService;
import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Article;
import com.nyj.exam.demo.vo.Board;

@Controller
public class AdmArticleController {
	
	@Autowired
	BoardService boardService; 
	@Autowired
	ArticleService articleService; 
	
	@RequestMapping("/adm/article/list")
	public String showList(
			@RequestParam(defaultValue = "0") int boardId,
			@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "10") int itemsCountInAPage,
			@RequestParam(defaultValue = "title,body") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword,
			Model model
		) {
		
		if(boardId != 0) {
			Board board = boardService.getBoardById(boardId);
			
			if(board==null) 
				Ut.jsHistoryBack("해당 게시판은 존재하지 않습니다.");

			model.addAttribute("board", board);
		} 
		 
		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordType, searchKeyword);
		
		int pagesCount = (int) Math.ceil((double)articlesCount / itemsCountInAPage) ; 
		
		List<Article> articles = articleService.getArticles(boardId, searchKeywordType, searchKeyword, page, itemsCountInAPage);
		
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		
		return "adm/article/list";
	}
	

}
