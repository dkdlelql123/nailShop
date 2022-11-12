package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Item;

@Mapper
public interface ShopItemRepository {

	int getLastInsertId();

	List<Item> getAllShopItem();

	int getShopItemCount(String searchKeywordType, String searchKeyword);

	List<Item> getForPrintShopItems(String searchKeywordType, String searchKeyword, int limitStart, int limitTake);

	void doWrite(Item item);


}
