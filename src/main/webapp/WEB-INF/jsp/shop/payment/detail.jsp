<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="방문 기록" />
<%@ include file="../common/head.jspf"%>

<script  src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<script type="text/javascript"> 
let submitFormDone = false; 

/** 회원가입 폼 체크 */
function checkForm(form) {
  if (submitFormDone) {
    alert("처리중입니다. \n새로고침 후 다시 시도해주세요");
    return;
  } 
  let userName = form.name.value.trim();  

  if (!isNull(userName)) {
    alert("이름(을)를 입력해주세요.");
    form.name.focus();
    return;
  } 
 
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
        <input type="hidden" name="itemId" value="" /> 
        
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
                required />
                <button class="btn btn-sm btn-secondary space-x-2"><i class="fas fa-search"></i></button>
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
        
        <h1 class="mt-12 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">
          결제
        </h1>
        <div class="flex flex-col w-full mt-8">
          <div class="flex">
            <span class="w-1/3">상품가격</span>
            <span class="text-right w-2/3 pr-3">100,000</span>
          </div> 
          <div class="wx-1 h-px bg-base-content/20 my-2"></div> 
          <div class="flex">
            <span class="w-1/3  flex items-center">세일가격</span>
            <span class="text-right w-2/3">
              <input type="text" class="input input-sm text-right" value="" placeholder="할인금액"/>            
            </span>
          </div>
          <div class="wx-1 h-px bg-base-content/20 my-2"></div> 
          <div class="flex">
            <span class="w-1/3">총 결제금액</span>
            <span class="text-right w-2/3">
              <input type="text" class="input input-sm text-right w-full" value="" placeholder="할인금액을 입력하면 자동으로 나옵니다."
                readonly
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

<%@ include file="../common/tail.jspf"%>
