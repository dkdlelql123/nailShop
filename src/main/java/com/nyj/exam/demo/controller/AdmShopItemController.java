package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.AttrService;
import com.nyj.exam.demo.service.BoardService;
import com.nyj.exam.demo.service.ShopCateService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Shop;

@Controller
public class AdmShopItemController {
	
	@Autowired
	ShopCateService shopCateService; 
	
	@Autowired
	ShopItemService shopItemService; 
	  
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
	public String doWrite(Shop shopCate) {
		
		System.out.println(shopCate);
		
		if(shopCate.getName() == null || "".equals(shopCate.getName())) {
			return Ut.jsHistoryBack("이름을 입력해주세요"); 
		}
		  
		ResultData rs = shopCateService.doWrite(shopCate);
		
		return Ut.jsReplace(rs.getMsg(), "/adm/shop/item/write");
	} 

}
