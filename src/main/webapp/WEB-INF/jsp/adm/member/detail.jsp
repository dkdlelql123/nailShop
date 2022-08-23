<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.nyj.exam.demo.util.Ut" %>

<c:set var="pageTitle" value="회원 상세" />
<%@ include file="../common/head.jspf"%>

<script>   

    function deleteMember(memberId){
    	if(confirm("회원 탈퇴시키겠습니까?")){     
        	$("input[name=ids]").val(memberId);
        	document["doDeleteMembers"].submit();
    	} else {
        	alert("회원탈퇴가 취소되었습니다.");
        	return false;
    	}
    }

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


<div class="table-box-type-1 m-auto w-full">
  <div class="messege mb-4 text-red-500 text-center bg-red-100 rounded"></div> 
  
  <form hidden action="../members/doDelete" name="doDeleteMembers" method="POST">
    <input type="hidden" name="ids" value=""/>
    <input type="hidden" name="replaceUri" value="/adm/member/list"/>
  </form>
   
  <form onsubmit="checkForm(this); return false;" action="/adm/member/doModify" method="post">
    <input type="hidden" name="memberModifyAuthKey" value="" />
    <div class="flex justify-end mb-4 gap-2">
      <button class="btn btn-sm btn-info py-2 ">정보수정</button>
      <c:if test= "${member.delStatus == 0 }">
        <div onclick="deleteMember(${member.id});" class="btn btn-sm btn-accent py-2">회원탈퇴</div>
      </c:if>
    </div>
    <table>
      <colgroup>
        <col width="120">
        <col >
        <col width="120">
      </colgroup>
      <tr>
        <td>아이디</td>
        <td>
          <input type="text" id="loginId" value="${member.loginId}"
            name="loginId" class="input input-disabled w-full input-sm" required disabled />
        </td>
        <td>새 비밀번호</td>
        <td>
          <input type="password" name="loginPw" class="input w-full input-sm" 
            placeholder="새 비밀번호" />
        </td>
      </tr> 
      <tr>
        <td>이름</td>
        <td>
          <input type="text" value="${member.name}" name="name"
            class="input input-sm input-disabled w-full" placeholder="이름"
            required disabled />
        </td>
        <td>별명</td>
        <td>
          <input type="text" value="${member.nickname}" name="nickname"
            class="input input-sm w-full" placeholder="별명" required />
        </td>
      </tr>
      <tr>
        <td>이메일</td>
        <td>
          <input type="email" value="${member.email}" name="email"
            class="input input-sm w-full" placeholder="abc@abc.com" />
        </td>
        <td>전화번호</td>
        <td>
          <input type="text" value="${member.phoneNumber}"
            name="phoneNumber" class="input input-sm  w-full" placeholder="전화번호"
            required />
        </td>
      </tr>      
      <tr>
        <td>권한</td>
        <td colspan="3">
          <c:set var="authLevel" value="${member.authLevel}" />
          <label for="authLevel1">
            <input type="radio" id="authLevel1" name="level" value="2"  ${authLevel == 2 ? "checked" : null}/>
            <span>일반회원</span>
          </label>
          
          <label for="authLevel2" class="ml-4">
            <input type="radio" id="authLevel2"  name="level" value="10" ${authLevel == 10 ? "checked" : null}/>
            <span>관리자</span>
          </label>
        </td> 
      </tr>
      <tr>
        <td>가입일</td>
        <td>
          ${member.getForPrintType1RegDate()}
        </td>
        <td>정보수정일</td>
        <td>
          ${member.getForPrintType1UpdateDate()}
        </td>
      </tr>
      <tr>
        <td>탈퇴여부</td>
        <td>
          ${member.delStatus == 0 ? "-" : "<div class='text-red-600'>탈퇴</div>"}
        </td>
        <td>탈퇴일</td>
        <td>
          ${member.delDate != null ? member.delDate.substring(0, 16) : "-"}
        </td>
      </tr>
    </table>
  </form> 
  
  <table class="mt-8">
  <colgroup>
    <col width="200"/>
  </colgroup>
    <tr>
      <td>작성한 게시물 수</td>
      <td>${member.extra__totalWrittenArticles}</td>
    </tr>
    <tr>
      <td>작성한 댓글 수</td>
      <td>${member.extra__totalWrittenReplies}</td>
    </tr>
  </table>
</div>

<%@ include file="../common/tail.jspf"%>
