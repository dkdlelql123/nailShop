package com.nyj.exam.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.nyj.exam.demo.interceptor.BeforeActionInterceptor;
import com.nyj.exam.demo.interceptor.MenuInterceptor;
import com.nyj.exam.demo.interceptor.NeedAdminInterceptor;
import com.nyj.exam.demo.interceptor.NeedLoginInterceptor;
import com.nyj.exam.demo.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	
	@Autowired
	MenuInterceptor menuInterceptor;
	
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;
	
	@Autowired
	NeedAdminInterceptor needAdminInterceptor;


	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(beforeActionInterceptor)
		.addPathPatterns("/**")
		.excludePathPatterns("/resource/**")
		.excludePathPatterns("/error");
		
		registry.addInterceptor(menuInterceptor)
		.addPathPatterns("/**")
		.excludePathPatterns("/resource/**")
		.excludePathPatterns("/error")
		.excludePathPatterns("/adm")
		.excludePathPatterns("/adm/**")
		;
		
		registry.addInterceptor(needLoginInterceptor)
		.addPathPatterns("/usr/article/write")
		.addPathPatterns("/usr/article/doWrite")
		.addPathPatterns("/usr/article/modify")
		.addPathPatterns("/usr/article/doModify")
		.addPathPatterns("/usr/article/doDelete")
		.addPathPatterns("/usr/member/mypage")
		.addPathPatterns("/usr/member/modify")
		.addPathPatterns("/usr/member/checkPassword")
		.addPathPatterns("/usr/member/doCheckPassword")
		.addPathPatterns("/usr/member/doModify")
		.addPathPatterns("/usr/reactionPoint/doGoodReaction")
		.addPathPatterns("/usr/reactionPoint/dobadReaction")
		.addPathPatterns("/usr/reactionPoint/doCancleReaction")
		.addPathPatterns("/usr/reply/doWrite")
		.addPathPatterns("/usr/reply/doModfiy")
		.addPathPatterns("/usr/reply/doDelete")
		.addPathPatterns("/adm")
		.addPathPatterns("/adm/**")
		.excludePathPatterns("/adm/member/login")
		.excludePathPatterns("/adm/member/doLogin") 
		.excludePathPatterns("/adm/member/findLoginId")
		.excludePathPatterns("/adm/member/doFindLoginId")
		.excludePathPatterns("/adm/member/findLoginPw")
		.excludePathPatterns("/adm/member/doFindLoginPw");
		
		registry.addInterceptor(needLogoutInterceptor)
		.addPathPatterns("/usr/member/login")
		.addPathPatterns("/usr/member/doLogin")
		.addPathPatterns("/usr/member/join")
		.addPathPatterns("/usr/member/doJoin")
		.addPathPatterns("/usr/member/findMember")
		.addPathPatterns("/usr/member/findLoginId")
		.addPathPatterns("/usr/member/findLoginPassword")
		;
		
		registry.addInterceptor(needAdminInterceptor)
		.addPathPatterns("/adm")
		.addPathPatterns("/adm/**")
		.excludePathPatterns("/adm/member/login")
		.excludePathPatterns("/adm/member/doLogin") 
		.excludePathPatterns("/adm/member/findLoginId")
		.excludePathPatterns("/adm/member/doFindLoginId")
		.excludePathPatterns("/adm/member/findLoginPw")
		.excludePathPatterns("/adm/member/doFindLoginPw");
		;
	}
	
}