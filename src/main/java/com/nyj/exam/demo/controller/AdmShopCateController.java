package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.AttrService;
import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.service.ShopCateService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.ShopCate;

@Controller
public class AdmShopCateController {
	
	@Autowired
	ShopCateService shopCateService; 
	
//	@RequestMapping("/adm/shopCate/list")
//	public String showList(@RequestParam(defaultValue = "1") int page, 
//			@RequestParam(defaultValue = "10") int itemsCountInAPage,
//			@RequestParam(defaultValue = "name,code") String searchKeywordType,
//			@RequestParam(defaultValue = "") String searchKeyword,
//			Model model
//		) {
//		int boardsCount = boardService.getBoardCount(searchKeywordType, searchKeyword);
//		model.addAttribute("boardsCount", boardsCount);
//		
//		int pagesCount = (int) Math.ceil((double)boardsCount / itemsCountInAPage);
//		model.addAttribute("pagesCount", pagesCount);
//		model.addAttribute("page", page);
//		
//		List<Board> boards = boardService.getForPrintBoards(searchKeywordType, searchKeyword, page, itemsCountInAPage);
//		model.addAttribute("boards", boards); 
//		
//		return "/adm/board/list";
//	}
//	
	@RequestMapping("/adm/shopCate/write")
	public String showWrite(Model model) {
		
//		List<ShopCate> cateList = shopCateService.getForPrintShopCates();
		List<ShopCate> cateList = shopCateService.getShopCates(0);
		model.addAttribute("cateList", cateList); 
		
		return "/adm/shopCate/write";
	}
	
	@RequestMapping("/adm/shopCate/doWrite")
	@ResponseBody
	public String doWrite(ShopCate shopCate) {
		
		System.out.println(shopCate);
		
		if(shopCate.getName() == null || "".equals(shopCate.getName())) {
			return Ut.jsHistoryBack("이름을 입력해주세요"); 
		}
		  
		ResultData rs = shopCateService.doWrite(shopCate);
		
		return Ut.jsReplace(rs.getMsg(), "/adm/shopCate/write");
	}
	
	@RequestMapping("/adm/shopCate/doCheck")
	@ResponseBody
	public ResultData doCheck(String value, String type) {
		ResultData rd = shopCateService.CheckForDuplicates(value,type);
		return rd;
	}
//
//	
//	@RequestMapping("/adm/board/detail")
//	public String showDetail(int id, Model model) {
//		Board board = boardService.getBoardById(id);
//		model.addAttribute("board", board);
//
//		return "/adm/board/detail";
//	}
//	
//
//	@RequestMapping("/adm/board/modify")
//	public String showModify(int id, Model model) {
//		Board board = boardService.getBoardById(id);
//		model.addAttribute("board", board);
//
//		return "/adm/board/modify";
//	}
//	
//	@RequestMapping("/adm/board/doModify")
//	@ResponseBody
//	public String doModify(String name, String code,@RequestParam(defaultValue = "") String link, int id, int replyStatus, int reactionPointStatus, int publicStatus, Model model) {
//
//		Board board = boardService.getBoardById(id);
//		if(board == null) {
//			return Ut.jsHistoryBack("존재하지 않는 게시판입니다.");
//		}
//
//		model.addAttribute("board", board);
//
//		boardService.doModify(id, name, code, link,replyStatus, reactionPointStatus, publicStatus);
//		return Ut.jsReplace("게시판이 수정되었습니다.", "/adm/board/detail?id="+id);
//	}

}
