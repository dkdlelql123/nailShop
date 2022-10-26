package com.nyj.exam.demo.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.service.VisitService;
import com.nyj.exam.demo.vo.Board;

@Component
public class MenuInterceptor implements HandlerInterceptor{
	
	private BoardService boardService;
	private VisitService visitService;
	
	public MenuInterceptor(BoardService boardService, VisitService visitService) {
		this.boardService = boardService;
		this.visitService = visitService;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		// left menu
		List<Board> boards = boardService.getBoards();
		req.setAttribute("boards", boards);
		
		// today
		int total = visitService.getTotalCount();
		int today = visitService.getTodayCount();
		req.setAttribute("total", total);
		req.setAttribute("today", today);
		
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}	
