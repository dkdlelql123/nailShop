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
import com.nyj.exam.demo.vo.Customer;
import com.nyj.exam.demo.vo.Item;
import com.nyj.exam.demo.vo.Payment;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Rq;

@Controller
public class ShopController { 

	
	@Autowired
	ShopCateService shopCateService; 
	
	@Autowired
	ShopItemService shopItemService; 
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	Rq rq;
	
	/**
	 * HOME
	 * */
	@RequestMapping("/shop/home/list")
	public String showHomeList(Model model) {
		
		List<Item> bestList = shopItemService.getBestList();
		model.addAttribute("bestList", bestList);
		
		List<Item> newList = shopItemService.getNewList();
		model.addAttribute("newList", newList);
		
		return "/shop/home/list";
	} 

	/**
	 * 고객 목록
	 * */
	@RequestMapping("/shop/customer/list")
	public String showCustomerList(Model model) {
		List<Customer> customers = shopService.getCustomers();
		model.addAttribute("customers", customers);
		model.addAttribute("customerCnt", customers.size());
		
		return "/shop/customer/list";
	}
	  
	/**
	 * 고객 등록 페이지
	 * */
	@RequestMapping("/shop/customer/join")
	public String showCustomerJoin() {
		return "/shop/customer/detail";
	}
	
	/**
	 * 고객 등록 기능
	 * */
	@SuppressWarnings("unused")
	@RequestMapping("/shop/customer/doSave")
	@ResponseBody
	public String doCustomerSave(Customer customer) {
				
		String name = customer.getName().trim();
		if("".equals(name) == true || name == null ) {
			return Ut.jsHistoryBack("이름을 입력해주세요.");
		} 
	
		String phoneNumber = customer.getPhoneNumber();
		if("".equals(phoneNumber) == true || phoneNumber == null ) {
			return Ut.jsHistoryBack("전화번호를 입력해주세요.");
		}
		
		ResultData rd = shopService.getCustomerById(customer.getId()); 
		
		customer.setCode(name+phoneNumber);
		
		if(rd.isFail() == true) {  
			if( shopService.getCustomerByPhoneNumber(phoneNumber) != null ) {
				return Ut.jsHistoryBack("이미 존재하는 전화번호입니다.");
			}
			shopService.doCustomerJoin(customer); 
		} else { 
			// 회원수정
			Customer oldCustomer = (Customer) rd.getData1(); 
			if( shopService.getCustomerByPhoneNumber(phoneNumber) != null && oldCustomer.getPhoneNumber() != phoneNumber ) {
				return Ut.jsHistoryBack("이미 존재하는 전화번호입니다.");
			}
			shopService.doUpdateCustomer(customer);
		}  
		
		return Ut.jsReplace(Ut.f("%s님 저장이 완료되었습니다.", name), "/shop/customer/list") ;
	}
	
	/**
	 * 고객 목록
	 * */
	@RequestMapping("/shop/customer/detail")
	public String showCustomerList(int customerId, Model model) {
		ResultData rd = shopService.getCustomerById(customerId);
		if(rd.isFail() == true) {
			return Ut.jsHistoryBack(rd.getMsg());
		} 
		model.addAttribute("customer", rd.getData1()); 
		
		ResultData paymentRd = shopService.findPaymentListByCustomerId(customerId);
		model.addAttribute("paymentList", paymentRd.getData1());
		
		return "/shop/customer/detail";
	}
	
	 
	/**
	 * 상품 목록
	 * */
	@RequestMapping("/shop/item/list")
	public String showItemList(@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "10") int itemsCountInAPage,
			@RequestParam(defaultValue = "name,desc") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword,
			Model model) {

		int count = shopItemService.getShopItemCount(searchKeywordType, searchKeyword);
		model.addAttribute("count", count);
		
		int pagesCount = (int) Math.ceil((double)count / itemsCountInAPage);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page); 
		
		List<Item> itemList = shopItemService.getForPrintShopItems(searchKeywordType, searchKeyword, page, itemsCountInAPage);
		model.addAttribute("itemList", itemList);
		
		return "/shop/item/list";
	}
	
	/**
	 * 상품 목록
	 * */
	@RequestMapping("/shop/payment/detail")
	public String showPayment(int customerId,
			@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "12") int itemsCountInAPage,
			@RequestParam(defaultValue = "name,desc") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword,
			Model model) {
		ResultData rd = shopService.getCustomerById(customerId);
		if(rd.isFail()) {
			return "";
		} 	
		
		model.addAttribute("customer",rd.getData1());
		
		int count = shopItemService.getShopItemCount(searchKeywordType, searchKeyword);
		model.addAttribute("count", count);
		
		int pagesCount = (int) Math.ceil((double)count / itemsCountInAPage);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page); 
		
		List<Item> itemList = shopItemService.getForPrintShopItems(searchKeywordType, searchKeyword, page, itemsCountInAPage);
		model.addAttribute("itemList", itemList);
		
		return "/shop/payment/detail";
	}
	 
	/**
	 * 상품 목록
	 * */
	@RequestMapping("/shop/payment/save")
	@ResponseBody
	public String doPayment(Payment payment, Model model) {
		
		String visitDate = payment.getVisitDate().trim();
		if("".equals(visitDate) == true || visitDate == null ) {
			return Ut.jsHistoryBack("방문일을 입력해주세요.");
		}  
		
		String customerName = payment.getCustomerName().trim();
		if("".equals(customerName) == true || customerName == null ) {
			return Ut.jsHistoryBack("고객이름을 입력해주세요.");
		}
		
		String itemName = payment.getItemName().trim();
		if("".equals(itemName) == true || itemName == null ) {
			return Ut.jsHistoryBack("상품명을 입력해주세요.");
		}
		
		if( payment.getItemPrice() <= 0 ) {
			return Ut.jsHistoryBack("상품을 다시 선택해주세요.");
		}
		
		shopService.doSavePayment(payment); 
		 
		return Ut.jsReplace(Ut.f("%s님 방문기록이 완료되었습니다.", customerName), "/shop/customer/detail?customerId="+payment.getCustomerId()) ;
	}

}
