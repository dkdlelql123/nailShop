package com.nyj.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nyj.exam.demo.repository.ShopRepository;
import com.nyj.exam.demo.util.Ut;
import com.nyj.exam.demo.vo.Customer;
import com.nyj.exam.demo.vo.Payment;
import com.nyj.exam.demo.vo.ResultData;

@Service
public class ShopService {
	
	@Autowired
	ShopRepository shopRepository;

	public ResultData getCustomerById(int customerId) { 
		Customer customer = shopRepository.getCustomerById(customerId);
		
		if(customer != null) {
			return ResultData.form("S-1", Ut.f("고객님(%d)의 정보가 존재합니다.", customerId), customer);
		}
		
		return ResultData.form("F-1", "고객정보가 없습니다.");
		
	}
	
	public Customer getCustomerByPhoneNumber(String phoneNumber) { 
		return shopRepository.getCustomerByPhoneNumber(phoneNumber);
	}

	public void doCustomerJoin(Customer customer) {
		shopRepository.doCustomerJoin(customer); 
	}

	public List<Customer> getCustomers() { 
		return shopRepository.getCustomers();
	}

	public void doUpdateCustomer(Customer customer) {
		shopRepository.doUpdateCustomer(customer);  
	}

	public void doSavePayment(Payment payment) {
		shopRepository.doSavePayment(payment);
	}

}
