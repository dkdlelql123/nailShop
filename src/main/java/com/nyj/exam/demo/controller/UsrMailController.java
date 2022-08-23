package com.nyj.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nyj.exam.demo.service.MailService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Mail;

@Controller
public class UsrMailController {

	@Autowired
	MailService mailService; 
	
	@RequestMapping("/usr/contact") 
	public String showContact() {  	
		return "usr/contact/write";
	}
	
	@RequestMapping("/usr/contact/send") 
	public String sendMail(String name, String email, String body) {
	   Mail mail = new Mail(); 
	   mail.setTitle(Ut.f("🌼 %s 님이 보낸 메일입니다.", name));
	   mail.setMsg(Ut.f("🌼 메일주소 : %s \n 🌼 내용 : %s", email, body));

	   mailService.sendContect(mail);
		
	   return "redirect:/"; 
	} 
	 
	 
}
