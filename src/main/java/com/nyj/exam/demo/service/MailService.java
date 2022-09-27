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
    private static final String TO_ADDRESS = "dkdlelql123@naver.com";
    
    public MailService(JavaMailSender mailSender) {
    	this.mailSender = mailSender;
	}
	
    /**
     * 임시 비밀번호 생성, mail 내용 작성
     * @param Member member : 회원정보
     * @return Mail mail : 임시비밀번호가 담긴 메일
     * */
	public Mail createMailAndChangePassword(Member member) {
		// 임시 비밀번호
		String uuid = UUID.randomUUID().toString().replace("-", "");
		String tempPw = uuid.substring(0, 6);
		
		Mail mail = new Mail();
		mail.setAddress(member.getEmail()); // 받는사람
		mail.setTitle(member.getLoginId()+"님의 임시비밀번호 안내 이메일 입니다.");
		mail.setMsg("안녕하세요. 임시비밀번호 안내 관련 이메일 입니다." + "[" + member.getLoginId() + "]" +"님의 임시 비밀번호는 "
        + tempPw + " 입니다.");
		mail.setNewPw(tempPw); 
		return mail;
		
	}
	
	/** 
	 * 임시 비밀번호 메일 전송 
	 * @param Mail mail
	 * */
	public void mailSend(Mail mail){
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
    }
	
	/** 
	 * contact 메일 전송 
	 * @param Mail mail
	 * */ 
	public void sendContect(Mail mail) { 
		try { 
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(TO_ADDRESS);
	        message.setFrom(FROM_ADDRESS);
	        message.setSubject(mail.getTitle());
	        message.setText(mail.getMsg());
	        mailSender.send(message);   
		} catch (Exception e) { 
			e.printStackTrace();
		} 
	}
}
