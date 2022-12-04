<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="고객 상세" />
<%@ include file="../common/head.jspf"%>

<script  src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<script type="text/javascript"> 
let submitJoinFormDone = false; 

/** 회원가입 폼 체크 */
function checkForm(form) {
	if (submitJoinFormDone) {
		alert("처리중입니다. \n새로고침 후 다시 시도해주세요");
		return;
	} 
	let userName = form.name.value.trim(); 
	let userPhoneNumber = form.phoneNumber.value.trim();
	

	if (!isNull(userName)) {
		alert("이름(을)를 입력해주세요.");
		form.name.focus();
		return;
	} 

	if (!isNull(userPhoneNumber)) {
		alert("전화번호(을)를 입력해주세요.");
		form.phoneNumber.focus();
		return;
	}
	
	if (userPhoneNumber.length != 4) {
		alert("전화번호(을)를 4글자 입력해주세요");
		form.phoneNumber.focus();
		return;
	}
	
    const maxSizeMb = 5;
    const maxSize = maxSizeMb * 1024 * 1024;
    const profileImgFileInput = form["file__member__0__extra__profileImg__1"];
    if (profileImgFileInput.value) {
        if (profileImgFileInput.files[0].size > maxSize) {
            alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
            profileImgFileInput.focus();
            return;
        }
    }

	form.submit();
	submitJoinFormDone = true;
} 
</script>
<main class="py-6 px-4 sm:p-6 md:py-10 md:px-8">
  <div class="max-w-xl mx-auto grid grid-cols-1 lg:max-w-xl lg:gap-y-10">
    <section>
      <h1 class="mt-1 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">
        고객 상세
      </h1>
      
      <form onsubmit="checkForm(this); return false;" action="/shop/customer/doSave" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${customer.id}" />
        <div class="mt-8 mb-4">
        <!--     
        <div class="mb-4"> 
            <label class="block mb-2 text-sm font-medium label-text">
                프로필 이미지
            </label> 
                          :file
            relTypeCode   :member
            relId         :0
            typeCode      :extra
            type2Code     :profileImg
            fileNo        :1 (profileImg 중 1번)
             
            <input 
              type="file" 
              name="file__customer__0__extra__profileImg__1" 
              accept= "image/png image/jpeg image/jpg"
              placeholder="프로필 이미지를 선택해주세요." />
         </div>
         
        <div class="mb-4"> --> 
          <label 
            for="name"
            class="block mb-2 text-sm font-medium label-text">이름</label>
          <input 
            type="text" 
            name="name" 
            id="name"
            class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm" 
            placeholder="이름"
            value="${customer.name}"
            required />
        </div>
         
        <div class="mb-4">
          <label 
            for="phoneNumber"
            class="block mb-2 text-sm font-medium label-text">전화번호</label> 
          <input 
            type="text" 
            name="phoneNumber" 
            id="phoneNumber"
            class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm required"
            placeholder="전화번호 뒷자리 4글자만 입력해주세요."
            maxlength="4" 
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  
            value="${customer.phoneNumber}"
            required />
        </div> 
        
        <button 
          type="submit"
          class="w-full btn btn-primary  mt-4 py-2 block text-center">저장</button>
      </form> 
      
      <c:if test="${customer.id > 0}">
        <div class="flex items-center mt-12"> 
            <h1 class="w-full text-base font-semibold text-white sm:text-slate-900 md:text-xl dark:sm:text-white">
              방문내역 
            </h1>
            <a class="btn btn-sm btn-circle btn-outline "  href="/shop/payment/detail?customerId=${customer.id}">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 12L18 12M12 6l0 12" /></svg>
            </a>
          </div>
          
          <div class="flex flex-wrap pt-4">
            <c:if test="${empty paymentList}">
              <div class="flex-grow text">정보가 없습니다.</div> 
            </c:if>
            <c:forEach var="payment" items="${paymentList}">
              <div class="stats w-1/4 border border-gray-500"> 
                <div class="stat">
                  <div class="stat-title">${payment.categoryNm}</div>
                  <div class="stat-value">
                    <a href="/shop/item/list?customerId=${customer.id}"> <span>${payment.tot}</span></a> 
                  </div>
                  <div class="stat-desc">last ${payment.lastVisit}</div>
                </div> 
              </div>
              </c:forEach> 
          </div>
        </c:if>
    </section>
  </div>
</main>

<%@ include file="../common/tail.jspf"%>
