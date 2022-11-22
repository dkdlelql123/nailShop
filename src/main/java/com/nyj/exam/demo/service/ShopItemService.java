package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ShopItemRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Board;
import com.nyj.exam.demo.vo.Item;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class ShopItemService {

	@Autowired
	ShopItemRepository shopItemRepository;

	public int getLastInsertId() { 
		return shopItemRepository.getLastInsertId();
	}
	
	public Item getShopItemById(int id) { 
		return shopItemRepository.getShopItemById(id);
	}
	
	public List<Item> getAllShopItem() {
		return shopItemRepository.getAllShopItem();
	}

	public int getShopItemCount(String searchKeywordType, String searchKeyword) { 
		return shopItemRepository.getShopItemCount(searchKeywordType,searchKeyword);
	}

	public List<Item> getForPrintShopItems(String searchKeywordType, String searchKeyword, int page, int itemsCountInAPage) {
		int limitStart = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;
		
		System.out.println("limitTake"+limitTake);
		return shopItemRepository.getForPrintShopItems(searchKeywordType,searchKeyword,limitStart, limitTake);
	} 
	
	public ResultData doWrite(Item item) {
		shopItemRepository.doWrite(item);
		int id = getLastInsertId();
		return ResultData.form("S-1", Ut.f("상품이 생성되었습니다.", id), id);
	}

	
}
