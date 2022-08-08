<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../common/head.jspf"%>

<script
  src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script type="text/javascript" >
	function isNull(el) {
		let str = el.trim();
		if (str.length <= 0) {
			return false
		}
		return true;
	}

	let submitJoinFormDone = false;
	let validLoginId = "";

	function checkForm(form) {  
		if (submitJoinFormDone) {
			alert("처리중입니다.");
			return;
		}

		if (!isNull(form.loginId.value)) {
			console.log("아이디(을)를 입력해주세요.");
			form.loginId.focus();
			return;
		}

		if (validLoginId == form.loginId.value) {
			return;
		}

		if (!isNull(form.loginPw.value)) {
			console.log("비밀번호(을)를 입력해주세요.");
			form.loginPw.focus();
			return;
		}
		;

		if (!isNull(form.loginPw2.value)) {
			console.log("비밀번호(을)를 입력해주세요.");
			form.loginPw2.focus();
			return;
		}

		if (form.loginPw.value.trim() != form.loginPw2.value.trim()) {
			alert("비밀번호가 동일하지 않습니다. \n다시 확인해주세요.");
			form.loginPw.focus();
			return;
		}

		console.log("완료")
		form.submit();
		submitJoinFormDone = true;
	}  
 
	function checkLoginIdDup(loginId) {
		let data = loginId.value.trim(); 
		
		if (data.length <= 0) {
			$('.loginId-message').html('<div class="loginId-message text-xs">* 중복체크 필수입니다.</div>');
		} else {
			$.ajax({
				url : '/usr/member/doCheckLoginId',
				type : "GET",
				data : {
					"loginId" : data
				},
				success : function(result) {
					let resultCode = result.resultCode.substr(0, 1); 
					if (resultCode == 'S') {
						$('.loginId-message')
								.html( '<div class="loginId-message text-xs text-green-600">✔️ 사용가능한 아이디입니다</div>');
					} else if (resultCode == 'F') {
						validLoginId = loginId;
						$('.loginId-message')
								.html('<div class="loginId-message text-xs text-red-600">🚫 이미 사용중인 아이디입니다.</div>');
					}
				},
				error : function(error) {
					console.log(error)
				}
			})
		} 
	}
	
	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 500);  
	
</script>

<div class="table-box-type-1 m-auto w-full lg:w-1/2">
  <form onsubmit="checkForm(this); return false;"
    action="/usr/member/doJoin" method="post">
    <table>
      <colgroup>
        <col width="200">
      </colgroup>
      <tr>
        <td>아이디</td>
        <td>
          <div class="flex items-center gap-1 mb-1">
            <input type="text" id="loginId" name="loginId" onkeyup="checkLoginIdDupDebounced(this);"
              class="input w-full" placeholder="아이디" autocomplete="off"
              required />
          </div>
          <div class="text-xs loginId-message">* 중복체크 필수입니다.</div>
        </td>
      </tr>
      <tr>
        <td>비밀번호</td>
        <td>
          <input type="password" id="loginPw" name="loginPw"
            class="input w-full loginPw" placeholder="비밀번호" required autoComplete="off" />
      </tr>
      <tr>
        <td>비밀번호 재확인</td>
        <td>
          <input type="password" name="loginPw2" class="input w-full"
            placeholder="비밀번호" required autoComplete="off" />
        </td>
      </tr>
      <tr>
        <td>이름</td>
        <td>
          <input type="text" name="name" class="input w-full"
            placeholder="이름" required />
        </td>
      </tr>
      <tr>
        <td>이메일</td>
        <td>
          <input type="email" name="email" class="input w-full"
            placeholder="abc@abc.com" required />
        </td>
      </tr>
      <tr>
        <td>별명</td>
        <td>
          <input type="text" name="nickname" class="input w-full"
            placeholder="별명" required />
        </td>
      </tr>
      <tr>
        <td>전화번호</td>
        <td>
          <input type="text" name="phoneNumber" class="input w-full"
            placeholder="전화번호" required />
        </td>
      </tr>
    </table>
    <button type="submit"
      class="w-full btn btn-info mt-4 py-2 block text-center">회원가입</button>
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
