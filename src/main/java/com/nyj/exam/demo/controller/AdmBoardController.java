package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.ResultData;

@Controller
public class AdmBoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/adm/board/list")
	public String showList(@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "5") int itemsCountInAPage,
			@RequestParam(defaultValue = "name,code") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword,
			Model model
		) {
		
		int boardsCount = boardService.getBoardCount(searchKeywordType, searchKeyword);
		model.addAttribute("boardsCount", boardsCount);
		
		int pagesCount = (int) Math.ceil((double)boardsCount / itemsCountInAPage);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page);
		
		List<Board> boards = boardService.getForPrintBoards(searchKeywordType, searchKeyword, page, itemsCountInAPage);
		model.addAttribute("boards", boards);
		
		
		return "/adm/board/list";
	}
	
	@RequestMapping("/adm/board/write")
	public String showWrite() {
		return "/adm/board/write";
	}
	
	@RequestMapping("/adm/board/doWrite")
	@ResponseBody
	public String doWrite(String name, String code) {
		
		boardService.doWrite(name, code);
		
		return Ut.jsReplace("게시판이 생성되었습니다.", "/adm/board/list");
	}
	
	@RequestMapping("/adm/board/doCheck")
	@ResponseBody
	public ResultData doCheck(String value, String type) {
		ResultData rd = boardService.CheckForDuplicates(value,type);
		return rd;
	}

	
	@RequestMapping("/adm/board/detail")
	public String showDetail(int id, Model model) {
		Board board = boardService.getBoardById(id);
		model.addAttribute("board", board);

		return "/adm/board/detail";
	}

}
