package com.nyj.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nyj.exam.demo.service.MailService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Mail;
import com.nyj.exam.demo.vo.Rq;

@Controller
public class UsrMailController {
	
	@Autowired
	Rq rq;

	@Autowired
	MailService mailService; 
	
	@RequestMapping("/usr/contact") 
	public String showContact() {  	
		return "usr/contact/write";
	}
	
	@RequestMapping("/usr/contact/send") 
	public String sendMail(String name, String email, String body) {
		
	   if(name == null || name.length() <= 0 ) {
		   return rq.pringHistoryBackJs("이름을 입력해주세요.");
	   }
	   
	   if(email == null || email.length() <= 0 ) {
		   return rq.pringHistoryBackJs("이메일을 입력해주세요.");
	   }
	   
	   if(body == null || body.length() <= 0 ) {
		   return rq.pringHistoryBackJs("메세지를 입력해주세요.");
	   }
	   
	   Mail mail = new Mail(); 
	   mail.setTitle(Ut.f("🌼 %s 님이 보낸 메일입니다.", name));
	   mail.setMsg(Ut.f("🌼 메일주소 : %s \n 🌼 내용 : %s", email, body));

	   mailService.sendContect(mail);
		
	   return "redirect:/"; 
	} 
	 
	 
}
