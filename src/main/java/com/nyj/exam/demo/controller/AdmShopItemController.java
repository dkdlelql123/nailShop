package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.ShopCateService;
import com.nyj.exam.demo.service.ShopItemService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Item;
import com.nyj.exam.demo.vo.Member;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Rq;
import com.nyj.exam.demo.vo.Shop;

@Controller
public class AdmShopItemController {
	
	@Autowired
	ShopCateService shopCateService; 
	
	@Autowired
	ShopItemService shopItemService; 
	
	@Autowired
	Rq rq;
	  
	@RequestMapping("/adm/shop/item/write")
	public String showItemWrite(Model model) {
		 
		List<Shop> cateList = shopCateService.getShopCates(0);
		model.addAttribute("cateList", cateList);
		
		List<Shop> seasonList = shopCateService.getForPrintNameAndParentName("계절");
		model.addAttribute("seasonList", seasonList);
		
		List<Shop> toneTypeList = shopCateService.getForPrintNameAndParentName("toneType");
		model.addAttribute("toneTypeList", toneTypeList);
		
		return "/adm/shop/item/write";
	}
	
	@RequestMapping("/adm/shop/item/doWrite")
	@ResponseBody
	public String doWrite(Item item) { 
		
		if(item.getName() == null || "".equals(item.getName())) {
			return Ut.jsHistoryBack("이름을 입력해주세요."); 
		}
		
		if(item.getCategoryId() == 0 || item.getCategoryId() == '0'  ) {
			return Ut.jsHistoryBack("새로고침 후 이용해주세요."); 
		}
		
		if(item.getPrice() == 0 || item.getPrice() == '0' ) {
			return Ut.jsHistoryBack("가격을 입력해주세요."); 
		}
		
		Member member = rq.getMember();
		 
		item.setMemberName(member.getName());
		item.setMemberId(member.getId());
		
		ResultData rs = shopItemService.doWrite(item);
		
		return Ut.jsReplace(rs.getMsg(), "/adm/shop/item/write");
	} 

}
