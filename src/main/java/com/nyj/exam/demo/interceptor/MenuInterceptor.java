package com.nyj.exam.demo.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.fasterxml.jackson.databind.cfg.HandlerInstantiator;
import com.nyj.exam.demo.service.BoardService;

@Component
public class MenuInterceptor implements HandlerInterceptor{
	private BoardService boardService;
	public MenuInterceptor(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
	
		List boards = boardService.getBoards();
		req.setAttribute("boards", boards);
		
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}	
