<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<c:set var="pageTitle" value="방문 기록" />
<%@ include file="../common/head.jspf"%>

<script  src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<script type="text/javascript"> 

function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year +"-"+ month +"-"+ day;
}

$(function(){ 
  $("#visitDate").val(getToday()); 
})

let submitFormDone = false; 

/** 회원가입 폼 체크 */
function checkForm(form) {
  if (submitFormDone) {
    alert("처리중입니다. \n새로고침 후 다시 시도해주세요");
    return;
  } 
  let visitDate = form.visitDate.value.trim();  
  let customerId = form.customerId.value.trim();  
  let itemId = form.itemId.value.trim();  
  let itemPrice = form.itemPrice.value.trim();  
  let salePrice = form.salePrice.value.trim();  
  let totalPrice = form.totalPrice.value.trim();  

  if (!isNull(visitDate)) {
    alert("등록일(을)를 입력해주세요.");
    form.visitDate.focus();
    return;
  } 
  if (!isNull(customerId)) {
      alert("고객님(을)를 입력해주세요.");
      form.customerId.focus();
      return;
  } 
  if (!isNull(itemId)) {
      alert("상품(을)를 등록해주세요.");
      form.itemName.focus();
      return;
  } 
  if (!isNull(itemPrice)) {
      alert("상품가격(을)를 입력해주세요."); 
      return;
  } 
  if (!isNull(salePrice)) {
      alert("세일가격(을)를 등록해주세요.");
      form.salePrice.focus();
      return;
  } 
  if (!isNull(totalPrice)) {
      alert("세일가격(을)를 등록해주세요.");
      form.totalPrice.focus();
      return;
  } 	
  
  form.submit();
  submitFormDone = true;
} 

function btn__itemModalOnClick(){ 
	let itemId = $('input[name=item]:checked').data("id");
	let name = $('input[name=item]:checked').data("name");
	let price = $('input[name=item]:checked').data("price");
	
	if(itemId == null || itemId <= 0) {
		alert("상품을 선택해주세요.");
	}
	
	if(itemId == null || itemId <= 0) {
		alert("상품을 선택해주세요.");
	}
	
	console.log(itemId)
	 
	$('#itemId').val(itemId);
	$('#itemName').val(name);
	$('#itemPrice').val(price);
}

function onChange_prcie(){
	let itemPrice = $('#itemPrice').val();
	let salePrice = $('#salePrice').val();
	$('#totalPrice').val(itemPrice-salePrice);
}

</script>
<main class="py-6 px-4 sm:p-6 md:py-10 md:px-8">
  <div class="max-w-xl mx-auto grid grid-cols-1 lg:max-w-xl lg:gap-y-10">
    <section>
      <h1 class="mt-1 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">
        방문 기록
      </h1>
      
      <form onsubmit="checkForm(this); return false;" action="/shop/payment/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="customerId" value="${customer.id}" /> 
        <input type="hidden" name="itemId" id="itemId" /> 
        
        <div class="mt-8 mb-4 flex gap-2"> 
          <div class="w-full">
            <label 
              for="visitDate"
              class="block mb-2 text-sm font-medium label-text">방문일</label>
            <input 
              type="date" 
              name="visitDate" 
              id="visitDate"
              class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm" 
              placeholder="방문일"
              value="${payment.visitDate}"
              required />
          </div>  
          <div class="w-full">
            <label 
              for="customerName"
              class="block mb-2 text-sm font-medium label-text">이름</label>
            <input 
              type="text" 
              name="customerName" 
              id="customerName"
              class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm" 
              placeholder="이름"
              value="${customer.name}"
              required />
            </div>
        </div> 
        
        <div > 
          <label 
            for="itemName"
            class="block mb-2 text-sm font-medium label-text">상품</label>
            <div class="mb-4 flex gap-2">
              <input 
                type="text" 
                name="itemName" 
                id="itemName"
                class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm" 
                placeholder="상품을 검색해주세요"
                value="${payment.itemName}"
                required readonly/> 
                <label type="button" for="modal-item"  class="btn btn-sm btn-secondary space-x-2"><i class="fas fa-search"></i></label>
            </div>
        </div> 
    
        <div class="mb-4"> 
          <label 
            for="etc"
            class="block mb-2 text-sm font-medium label-text">특이사항</label>
            <textarea name="etc" id="etc" rows="2" class="block p-2 w-full textarea input-bordered rounded-lg sm:text-sm" 
            placeholder="특이사항이 있다면 작성해주세요"  value="${payment.etc}"
            ></textarea>
        </div> 
        
        <div class="mb-4"> 
          <span class="block mb-2 text-sm font-medium label-text">결제방법</span>
           <div class="flex mb-4 gap-2">
              <label class="cursor-pointer label">
                <span class="label-text mr-2" >현금</span>
                <input type="radio" name="paymentMethod" 
                      class="radio radio-primary" value="현금" checked/> 
              </label> 
              <label class="cursor-pointer label">
                <span class="label-text mr-2" >카드</span>
                <input type="radio" name="paymentMethod" 
                      class="radio radio-primary" value="카드" /> 
              </label>  
            </div>
        </div>
        
        <h1 class="mt-12 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">
          결제
        </h1>
        <div class="flex flex-col w-full mt-8">
          <div class="flex">
            <span class="w-1/3 flex items-center">상품가격</span>
            <span class="text-right w-2/3">
              <input type="text" name="itemPrice" id="itemPrice" class="input input-sm text-right" value="" placeholder="0" required readonly/>            
            </span> 
          </div> 
          <div class="wx-1 h-px bg-base-content/20 my-2"></div> 
          <div class="flex">
            <span class="w-1/3 flex items-center">할인금액</span>
            <span class="text-right w-2/3">
              <input type="text" name="salePrice" id="salePrice" class="input input-sm text-right" value=""
              onchange="onChange_prcie()" placeholder="할인금액" required/>            
            </span>
          </div>
          <div class="wx-1 h-px bg-base-content/20 my-2"></div> 
          <div class="flex">
            <span class="w-1/3 flex items-center">총 결제금액</span>
            <span class="text-right w-2/3">
              <input type="text" name="totalPrice" id="totalPrice" class="input input-sm text-right w-full" value="" placeholder="할인금액을 입력하면 자동으로 나옵니다."
                required readonly
              />            
            </span>
          </div>
        </div>
    
        <button 
          type="submit"
          class="w-full btn btn-primary mt-12 py-2 block text-center">등록</button>
      </form> 
    </section>
  </div>
</main>
 
<!-- Put this part before </body> tag -->
<input type="checkbox" id="modal-item" class="modal-toggle" />
<div class="modal">
  <div class="modal-box w-3/4 max-w-5xl">
   <label for="modal-item" class="btn btn-sm btn-circle absolute right-2 top-2">✕</label>
    
    <div class="form-control ">
      <div class="input-group input-group-lg justify-center border border-secondary rounded-full sm:border-0" >
        <input 
        type="search" 
        name="searchKeyword"
        class="input input-md input-secondary w-11/12 md:w-1/3 focus:z-10 focus:outline-none appearance-none border-0 sm:border my-1 sm:my-0 "
        placeholder="상품이름을 검색해주세요."  /> 
        <button type="submit" class="btn btn-secondary btn-md hidden sm:inline">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </button>
      </div>
    </div> 
    
    <h3 class="font-bold text-lg">검색 <c:out value="${count}" />건</h3>
    <div class="py-4">
       <div class="flex flex-wrap mt-4">
        <c:forEach var="item" items="${itemList}">
           <div class="card bg-base-100 w-1/6 p-1">
             <label for="item_<c:out value="${item.id}"/>" class="block">
              <input type="radio" name="item" id="item_${item.id}" class="radio checked:bg-blue-500" 
                    value="${item.id}"
                    data-id="${item.id}"
                    data-name="${item.name}"
                    data-price="${item.price}"
              /> 
              <span>
                <img 
                  src="${item.getShopItemImgUri()}"
                  onerror="${item.getShopItemFallbackImgOnErrorHtmlAttr()}"
                  alt="<c:out value="${item.extra__categoryName}"/>" 
                  />
              </span>  
              <span class="text-sm mt-2 block"><c:out value="${item.name}" /></span>  
            </label>
          </div> 
        </c:forEach>  
      </div> 
    </div>
    <div class="modal-action">
      <label for="modal-item" onclick="btn__itemModalOnClick()" class="btn btn-sm btn-secondary">선택완료</label>
    </div>
  </div>
</div>

<%@ include file="../common/tail.jspf"%>
