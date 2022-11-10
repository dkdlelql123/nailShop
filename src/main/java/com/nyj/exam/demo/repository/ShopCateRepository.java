package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Shop;

@Mapper
public interface ShopCateRepository {

	int getLastInsertId();

	Shop getFindById(int id);

	List<Shop> getForPrintShopCates();

	List<Shop> getForPrintCategoryAndLevel();

	Shop CheckForDuplicates(String value, String type);

	List<Shop> getShopCates(int relId);

	void doWrite(Shop shop);

	List<Shop> getForPrintNameAndParentName(String parentName);
}
