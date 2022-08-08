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
  <h1 class="text-2xl text-center">비밀번호 확인</h1>
  <form 
    class="table-box-type-1 mt-8"
    action="/usr/member/doCheckPassword" method="POST"
    onsubmit="checkForm(this); return false;">
    <input type="hidden" name="replaceUri" value="${param.replaceUri}" />
    
    <table>
      <colgroup>
        <col width="200">
      </colgroup>
      <tr>
        <th>아이디</th>
        <td>
         <div class="py-2">${rq.member.loginId}</div>
        </td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td>
          <input type="password" name="loginPw" class="input w-full"
            required="required" placeholder="현재 비밀번호" autoComplete="off" />
        </td>
      </tr>
    </table>

    <div class="messege my-4 text-red-500 text-center bg-red-100 rounded"></div>

    <div class="btn-wrap mt-4 ">
      <button class="w-full btn btn-success">확인</button>
    </div>
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
