package com.nyj.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Item;

@Mapper
public interface ShopItemRepository {

	void doWrite(Item item);

	int getLastInsertId();

}
