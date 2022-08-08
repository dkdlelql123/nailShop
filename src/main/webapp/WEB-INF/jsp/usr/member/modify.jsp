<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.nyj.exam.demo.util.Ut" %>

<c:set var="pageTitle" value="회원가입수정" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript" defer="defer">
	function isNull(el) {
		let str = el.trim();
		if (str.length <= 0) {
			return false
		}
		return true;
	}

	let submitJoinFormDone = false;

	function checkForm(form) {
		if (submitJoinFormDone) {
			alert("처리중입니다.");
			return;
		}
		
		if (form.loginPw.value.trim().length > 0) {  
			if(form.loginPw2.value.trim().length <= 0){
				$(".messege").html("<div class='py-2'>비밀번호을(를) 입력해주세요.</div>")
				form.loginPw2.focus();
				return; 
			}
			
			if(form.loginPw.value != form.loginPw2.value){
				$(".messege").html("<div class='py-2'>비밀번호가 일치하지 않습니다.</div>")
				form.loginPw2.focus();
				return;
			}
		}; 
		
		if(!isNull(form.email.value)){
			$(".messege").html("<div class='py-2'>이메일을(를) 입력해주세요.</div>");
			form.email.focus();
			return;
		}
		
		if(!isNull(form.nickname.value)){
			$(".messege").html("<div class='py-2'>별명을(를) 입력해주세요.</div>");
			form.nickname.focus();
			return;
		}
		
		if(!isNull(form.phoneNumber.value)){
			$(".messege").html("<div class='py-2'>전화번호을(를) 입력해주세요.</div>");
			form.phoneNumber.focus();
			return;
		}
		
		$(".messege").html("");

		submitJoinFormDone = true;
		form.submit();
	} 
</script>

<div class="table-box-type-1 m-auto w-full lg:w-1/2">
  <div class="messege mb-4 text-red-500 text-center bg-red-100 rounded"></div> 
  
  <form onsubmit="checkForm(this); return false;" action="/usr/member/doModify" method="post">
  <input type="hidden" name="memberModifyAuthKey" value="${param.memberModifyAuthKey}" />
    <table>
      <colgroup>
        <col width="200">
      </colgroup>
      <tr>
        <td>아이디</td>
        <td>
          <input type="text" id="loginId" value="${member.loginId}"
            name="loginId" class="input input-disabled w-full" required
            disabled />
        </td>
      </tr> 
      <tr>
        <td>새 비밀번호</td>
        <td>
          <input type="password" name="loginPw" class="input w-full" 
            placeholder="새 비밀번호"autoComplete="off"  />
        </td>
      </tr>
       <tr>
        <td>새 비밀번호 재확인</td>
        <td>
          <input type="password" name="loginPw2" class="input w-full" 
            placeholder="비밀번호 재확인" autoComplete="off" />
        </td>
      </tr>
      <tr>
        <td>이름</td>
        <td>
          <input type="text" value="${member.name}" name="name"
            class="input input-disabled w-full" placeholder="이름"
            required disabled />
        </td>
      </tr>
      <tr>
        <td>이메일</td>
        <td>
          <input type="email" value="${member.email}" name="email"
            class="input w-full" placeholder="abc@abc.com" />
        </td>
      </tr>
      <tr>
        <td>별명</td>
        <td>
          <input type="text" value="${member.nickname}" name="nickname"
            class="input w-full" placeholder="별명" required />
        </td>
      </tr>
      <tr>
        <td>전화번호</td>
        <td>
          <input type="text" value="${member.phoneNumber}"
            name="phoneNumber" class="input w-full" placeholder="전화번호"
            required />
        </td>
      </tr>
    </table>
    <button class="w-full btn btn-info mt-4 py-2 block text-center">정보수정</button> 
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
