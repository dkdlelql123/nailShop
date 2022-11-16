package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.ShopCateService;
import com.nyj.exam.demo.service.ShopItemService;
import com.nyj.exam.demo.service.ShopService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.Customer;
import com.nyj.exam.demo.vo.Item;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Rq;
import com.nyj.exam.demo.vo.Shop;

@Controller
public class ShopController { 
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	Rq rq;
	  
	@RequestMapping("/shop/customer/join")
	public String showCustomerJoin() {
		return "/shop/customer/join";
	}
	
	@RequestMapping("/shop/customer/doJoin")
	@ResponseBody
	public String doCustomerJoin(Customer customer) {
		
		String name = customer.getName().trim();
		if("".equals(name) == true || name == null ) {
			return Ut.jsHistoryBack("이름을 입력해주세요.");
		} 
	
		String phoneNumber = customer.getPhoneNumber();
		if("".equals(phoneNumber) == true || phoneNumber == null ) {
			return Ut.jsHistoryBack("전화번호를 입력해주세요.");
		}
		
		Customer oldCustomer = shopService.getCustomerByPhoneNumber(phoneNumber);
		if(oldCustomer != null) {
			return Ut.jsHistoryBack("이미 존재하는 전화번호입니다.");
		}
		
		customer.setCode(name+phoneNumber);
		shopService.doCustomerJoin(customer);
		 
		return Ut.jsReplace(Ut.f("%s 회원님 등록이 완료되었습니다.", name), "/shop/customer/list") ;
	}
	
	@RequestMapping("/shop/customer/list")
	public String showCustomerList() {
		return "/shop/customer/list";
	}
	
	 

}
