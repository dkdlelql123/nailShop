package com.nyj.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Customer;

@Mapper
public interface ShopRepository {

	Customer getCustomerByPhoneNumber(String phoneNumber);

	void doCustomerJoin(Customer customer);

}
