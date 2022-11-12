package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ShopCateRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Item;
import com.nyj.exam.demo.vo.ResultData;
import com.nyj.exam.demo.vo.Shop;

@Service
public class ShopCateService {
	
	@Autowired
	ShopCateRepository shopCateRepository;  
	
	@SuppressWarnings("unused")
	private Shop getFindById(int id) {
		return shopCateRepository.getFindById(id);
	}

	public int getLastInsertId() {
		return shopCateRepository.getLastInsertId();		 
	}

	public List<Shop> getForPrintShopCates() { 
		return shopCateRepository.getForPrintShopCates();
	}

	public List<Shop> getForPrintCategoryAndLevel() { 
		return shopCateRepository.getForPrintCategoryAndLevel();
	}
	
	/**
	 * 대메뉴만(중메뉴만) 호출하기
	 * ex) relId = 0 항목만 추출
	 * param int relId
	 * return List<shop>
	 * */
	public List<Shop> getShopCateByRelId(int relId) { 
		return shopCateRepository.getShopCateByRelId(relId);
	}

	public ResultData CheckForDuplicates(String value, String type) { 
		Shop oldShopCate  = shopCateRepository.CheckForDuplicates(value, type);
		if(oldShopCate != null) {
			return ResultData.form("F-1", "중복되는 카테고리명이 있습니다.", "oldShopCate", oldShopCate);
		}
		return ResultData.form("S-1", "사용가능한 이름입니다."); 
	}	

	public ResultData doWrite(Shop shop) { 
		shopCateRepository.doWrite(shop);
		int id = getLastInsertId();
		return ResultData.form("S-1", Ut.f("%d번째 카테고리가 생성되었습니다.", id));
	}
 
	public List<Shop> getForPrintNameAndParentName(String parentName) { 
		return shopCateRepository.getForPrintNameAndParentName(parentName);
	} 

}
