package com.nyj.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nyj.exam.demo.service.ShopCateService;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Shop;

@Controller
public class AdmShopCateController {
	
	@Autowired
	ShopCateService shopCateService; 
	 
	@RequestMapping("/adm/shop/cate/write")
	public String showWrite(Model model) {

		List<Shop> allCateList = shopCateService.getForPrintCategoryAndLevel();
		model.addAttribute("allCateList", allCateList);
		
		List<Shop> cateList = shopCateService.getShopCateByRelId(0);
		model.addAttribute("cateList", cateList); 
		
		return "/adm/shop/cate/write";
	} 
	
	@RequestMapping("/adm/shop/cate/doWrite")
	@ResponseBody
	public String doWrite(Shop shop) {
		
		System.out.println(shop);
		
		if(shop.getName() == null || "".equals(shop.getName())) {
			return Ut.jsHistoryBack("이름을 입력해주세요"); 
		}
		  
		ResultData rs = shopCateService.doWrite(shop);
		
		return Ut.jsReplace(rs.getMsg(), "/adm/shop/cate/write");
	}
	
	@RequestMapping("/adm/shop/cate/doCheck")
	@ResponseBody
	public ResultData doCheck(String value, String type) {
		ResultData rd = shopCateService.CheckForDuplicates(value,type);
		return rd;
	} 
}
