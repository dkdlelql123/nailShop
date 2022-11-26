package com.nyj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
	/** pk */
	int id;
	/** 방문일 */
	String visitDate;
	/** 고객 */
	int customerId; 
	/** 고객이름 */
	int customerName; 
	/** 상품 */
	int itemId;  
	/** 상품이름 */
	int itemName;  
	/** 상품판매가 */
	int itemPrice;  
	/** 결제할인가 */
	int salePrice;  
	/** 총결제액 */
	int totalPrice;  
	/** 기타사항 */
	String etc;  
	/** 결제방법 */	 
	String paymentMethod;  
}
