package com.nyj.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ShopRepository;
import com.nyj.exam.demo.vo.Customer;

@Service
public class ShopService {
	
	@Autowired
	ShopRepository shopRepository;

	public Customer getCustomerByPhoneNumber(String phoneNumber) { 
		return shopRepository.getCustomerByPhoneNumber(phoneNumber);
	}

	public void doCustomerJoin(Customer customer) {
		shopRepository.doCustomerJoin(customer);
		
	}

}
