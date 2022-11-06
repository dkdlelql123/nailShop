package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.ShopCate;

@Mapper
public interface ShopCateRepository {

	int getLastInsertId();

	ShopCate getFindById(int id);

	List<ShopCate> getForPrintShopCates();

	ShopCate CheckForDuplicates(String value, String type);

	List<ShopCate> getShopCates(int relId);

	void doWrite(ShopCate shopCate);
}
