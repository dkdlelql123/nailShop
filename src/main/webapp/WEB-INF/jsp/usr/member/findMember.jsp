<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="계정찾기" />
<%@ include file="../common/head.jspf"%>

<script>

function findMember(url, data){ 		
	return new Promise(function(resolve, reject){
		$.get(url, data).done(function(response) {
			if (response) {
	        	resolve(response) 
	      	}
	     	reject(new Error("Request is failed"));
		})
	})
}

// 아이디찾기
async function check__findMemberId(form){
	form.name.value = form.name.value.trim();
	if(form.name.value.length < 0){
		alert("이름을 입력해주세요");
		form.name.focus();
		return;
	}
	
	form.email.value = form.email.value.trim();
	if(form.email.value.length < 0){
		alert("이메일를 입력해주세요");
		form.email.focus();
		return;
	}
	
	let url = '/usr/member/findLoginId';
	let data = {
		"name":form.name.value,
		"email":form.email.value
	} 
	
	try {
    	let res = await findMember(url, data); 
    	let body = "다시 입력해주세요.";
    	if(res.resultCode.substr(0,1) == "S")
    		body = "회원님의 아이디는 '"+res.data1+"' 입니다."; 
    	
    	$(".modal h3").text(res.msg);
    	$(".modal p").text(body);
    	$("#my-modal").prop("checked", true);
	} catch (error) {
	    console.log(error);
  	} 

}

//새 비밀번호 발급
async function check__getNewPw(form){ 	
	let ui_id = form.loginId.value.trim();
	if(ui_id.length < 0){
		alert("이름을 입력해주세요");
		form.loginId.focus();
		return;
	}
	
	let ui_email = form.email.value.trim();
	if(ui_email.length < 0){
		alert("이메일를 입력해주세요");
		form.email.focus();
		return;
	}
	
	let url = '/usr/member/findLoginPassword';
	let data = {
		"loginId" : ui_id,
		"email" : ui_email
	}
	 
	try {
    	let res = await findMember(url, data); 
        $(".modal h3").text(res.msg);
    	$(".modal p").text("");
	    $("#my-modal").prop("checked", true);
	} catch (error) {
	    console.log(error);
  	} 
}
</script>

<div class="min-h-full flex flex-col items-center gap-20 py-12 px-4 sm:px-6 lg:px-8">
  <div class="max-w-md w-full space-y-8">
    <div>
      <h2 class="mt-6 text-center text-3xl font-extrabold">아이디 찾기</h2>
    </div>
    <form class="mt-8 space-y-6" onsubmit="check__findMemberId(this); return false;">   
      <div class="rounded-md shadow-sm -space-y-px">
        <div class="mb-2">
          <input name="name" type="text" required class="rounded-full appearance-none relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:z-10 sm:text-sm" placeholder="이름">
        </div>
        <div>
          <input name="email" type="text" autocomplete="current-password" required class="rounded-full appearance-none relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:z-10 sm:text-sm" autoComplete="off" placeholder="이메일" >
        </div>
      </div>
      <div>
        <button type="submit" class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-full text-white btn btn-primary">
          아이디 찾기
        </button>
    </div>
    </form>
  </div>
  
  <div class="max-w-md w-full space-y-8">
    <div>
      <h2 class="mt-6 text-center text-3xl font-extrabold">비밀번호 찾기</h2>
    </div>
    <form class="mt-8 space-y-6" onsubmit="check__getNewPw(this); return false;">    
      <div class="rounded-md shadow-sm ">
        <div class="mb-2">
          <input value="테스트" name="loginId" type="text" required class="rounded-full appearance-none relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:z-10 sm:text-sm" placeholder="아이디">
        </div> 
        <div>
          <input value="dkdlelql123@naver.com" name="email" type="text" required class="rounded-full appearance-none relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:z-10 sm:text-sm" autoComplete="off" placeholder="이메일" >
        </div>
      </div> 
      <div>
        <button type="submit" class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-full text-white btn btn-primary">
          비밀번호 찾기
        </button>
      </div>
    </form> 
  </div>
</div> 

<!-- Put this part before </body> tag -->
<input type="checkbox" id="my-modal" class="modal-toggle" />
<div class="modal">
  <div class="modal-box">
    <h3 class="font-bold text-lg"><!-- js --></h3>
    <p class="py-4"><!-- js --></p>
    <div class="modal-action">
      <label for="my-modal" class="btn">확인</label>
    </div>
  </div>
</div>
 
<%@ include file="../common/tail.jspf"%>
