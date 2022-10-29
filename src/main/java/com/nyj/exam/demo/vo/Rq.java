package com.nyj.exam.demo.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.nyj.exam.demo.service.MemberService;
import com.nyj.exam.demo.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member member;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	private Map<String, String> paramMap;
	
	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {	
		this.req = req;
		this.resp = resp;
		this.paramMap  = Ut.getParamMap(req);
		
		this.session = req.getSession();
		
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member member = null;
		
		if(session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId= (int) session.getAttribute("loginedMemberId");
			member = memberService.getMemberById(loginedMemberId);
		}
		
		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.member = member;
		
		this.req.setAttribute("rq", this);
	} 
	
	public HttpServletRequest getRequest() {
		return this.req;
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	} 

	public void printReplaceJs(String msg, String url) {
		resp.setContentType("text/html; charset=UTF-8");
		print( Ut.jsReplace(msg, url) );
	}

	public void printHistoryBackJs(String msg) { 
		resp.setContentType("text/html; charset=UTF-8");

		println("<script>"); 
		
		if(Ut.empty(msg) == false) {
			println("alert('"+msg+"');");
		}
		
		println("history.back();");

		println("</script>");
	}

	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}	 

	public void println(String str) {
		print(str + "\n");
	}
	
	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
        String queryString = req.getQueryString();
        
        if(queryString != null && queryString.length() > 0) {
        	currentUri = currentUri + "?" + queryString;
        }
        
        System.out.println("currentUri : "+ currentUri); 
        return currentUri;
	}
	
	public String getEncodedCurrentUri(){
		return Ut.getUriEncoded(getCurrentUri());
	}

	public String historyBackJsOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "common/js";
	}
	
	public String getLoginUri() { 
		return "/usr/member/login?afterLoginUri=" + getAfterLoginUri() ;
	}
	
	public String getLogoutUri() {    
		return "/usr/member/doLogout?afterLogoutUri=" + getAfterLogoutUri() ;
	}

	public String getAfterLogoutUri() {
		String currentUri = req.getRequestURI(); 
		
		switch(currentUri) {
			case "/usr/article/write":
			case "/usr/member/mypage":
			case "/usr/member/modify":
			case "/usr/member/checkPassword": 
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLogoutUri", "/"));
		} 
		
		if(isAdmin()) {
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLogoutUri", "/"));
		}
		
		return getEncodedCurrentUri();
	}
	
	public String getAfterLoginUri() {  
		String currentUri = req.getRequestURI();
		
		switch(currentUri) {
			case "/usr/member/login":
			case "/usr/member/join":
			case "/usr/member/findLoginId":
			case "/usr/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLoginUri", "/"));
		}
		
		return getEncodedCurrentUri();
	}
	
	public String getArticleDetailFromList(Article article) {
		return "/usr/article/detail?id="+article.getId()+"&listUri="+getEncodedCurrentUri();
	}

	public boolean isAdmin() { 
		return member.isAdmin();
	}
	
	public String pringHistoryBackJs(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "/common/js";
	}
}
