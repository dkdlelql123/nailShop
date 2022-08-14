package com.nyj.exam.demo.service;

import java.util.UUID;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.vo.Mail;
import com.nyj.exam.demo.vo.Member;

@Service
public class MailService {

    private JavaMailSender mailSender;
    private static final String FROM_ADDRESS = "dkdlelq123@gmail.com";
    
    public MailService(JavaMailSender mailSender) {
    	this.mailSender = mailSender;
	}
	 
	public Mail createMailAndChangePassword(Member member) {
		String uuid = UUID.randomUUID().toString().replace("-", "");
		String tempPw = uuid.substring(0, 6);
		
		Mail mail = new Mail();
		mail.setAddress(member.getEmail());
		mail.setTitle(member.getLoginId()+"님의 임시비밀번호 안내 이메일 입니다.");
		mail.setMsg("안녕하세요. 임시비밀번호 안내 관련 이메일 입니다." + "[" + member.getLoginId() + "]" +"님의 임시 비밀번호는 "
        + tempPw + " 입니다.");
		mail.setNewPw(tempPw); 
		return mail;
		
	}
	
	public void mailSend(Mail mail){
		System.out.println("이메일 전송 완료! -s-");
		try {
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(mail.getAddress());
	        message.setFrom(FROM_ADDRESS);
	        message.setSubject(mail.getTitle());
	        message.setText(mail.getMsg());
	        mailSender.send(message);
	        
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
        System.out.println("이메일 전송 완료! -e-");
    }
 

}
