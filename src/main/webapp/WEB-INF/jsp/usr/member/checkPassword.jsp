<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript" defer="defer">
	let submitJoinFormDone = false;
	
	function checkForm(form) {
		if (submitJoinFormDone) {
			alert("처리중입니다.");
			return;
	    }

		if (form.loginPw.value.trim().length <= 0) {
			$(".messege").html("<div class='py-2'>비밀번호를(를) 올바르게 입력해주세요.</div>");
			form.loginPw.focus();
			return;
		}

		$(".messege").html("");

		form.submit();
		submitJoinFormDone = true;
	}
</script>

<div class="w-2/3 m-auto" style="margin-top: 100px;">
  <h1 class="text-3xl font-bold text-center">비밀번호 확인</h1>
  <form 
    class="table-box-type-1 mt-8"
    action="/usr/member/doCheckPassword" method="POST"
    onsubmit="checkForm(this); return false;">
    <input type="hidden" name="replaceUri" value="${param.replaceUri}" />
    
    <div class="messege my-4 text-red-500 text-center bg-red-100 rounded"></div>
    
    <div class="mb-4">
      <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">아이디</label>
      <input 
        type="text"  
        class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        value="${rq.member.loginId}"
        readonly disabled
      />
    </div>
    <div class="mb-4">
      <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">비밀번호</label>
      <input 
        type="password" name="loginPw"  
        class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        placeholder="현재 비밀번호"
        autoComplete="off" 
        required="required" 
      />
    </div>   

    <div class="btn-wrap mt-4">
      <button class="w-full btn btn-primary">확인</button>
    </div>
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
