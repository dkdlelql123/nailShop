package com.nyj.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nyj.exam.demo.vo.Rq;

@Controller
public class AdmHomeController {
	private Rq rq;
	
	public AdmHomeController(Rq rq) {
		this.rq = rq;
	}	
	
	@RequestMapping("/adm")
	public String main() {
		return "redirect:/adm/home";
	}
	
	@RequestMapping("/adm/home")
	public String showMain() {
		return "/adm/home/index";
	}
	
}
