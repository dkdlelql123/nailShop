package com.nyj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.nyj.exam.demo.vo.Customer;

@Mapper
public interface ShopRepository {

	Customer getCustomerById(int id);

	Customer getCustomerByPhoneNumber(String phoneNumber);

	void doCustomerJoin(Customer customer);

	List<Customer> getCustomers();

	void doUpdateCustomer(Customer customer);

}
