package com.nyj.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ShopItemRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Item;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class ShopItemService {

	@Autowired
	ShopItemRepository shopItemRepository;

	public ResultData doWrite(Item item) {
		shopItemRepository.doWrite(item);
		int id = getLastInsertId();
		return ResultData.form("S-1", Ut.f("%d번째 상품이 생성되었습니다.", id));
	}

	public int getLastInsertId() { 
		return shopItemRepository.getLastInsertId();
	}

}
