package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ShopCateRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.ShopCate;

@Service
public class ShopCateService {
	
	@Autowired
	ShopCateRepository shopCateRepository;  
	
	private ShopCate getFindById(int id) {
		return shopCateRepository.getFindById(id);
	}

	public int getLastInsertId() {
		return shopCateRepository.getLastInsertId();		 
	}

	public List<ShopCate> getForPrintShopCates() { 
		return shopCateRepository.getForPrintShopCates();
	}
	
	/**
	 * 대메뉴만 호출하기
	 * relId = 0 항목만 추출
	 * param int relId
	 * return List<shopCate>
	 * */
	public List<ShopCate> getShopCates(int relId) { 
		return shopCateRepository.getShopCates(relId);
	}

	public ResultData CheckForDuplicates(String value, String type) { 
		ShopCate oldShopCate  = shopCateRepository.CheckForDuplicates(value, type);
		if(oldShopCate != null) {
			return ResultData.form("F-1", "중복되는 카테고리명이 있습니다.", "oldShopCate", oldShopCate);
		}
		return ResultData.form("S-1", "사용가능한 이름입니다."); 
	}	

	public ResultData doWrite(ShopCate shopCate) { 
		shopCateRepository.doWrite(shopCate);
		int id = getLastInsertId();
		return ResultData.form("S-1", Ut.f("%d번째 카테고리가 생성되었습니다.", id));
	}

}
