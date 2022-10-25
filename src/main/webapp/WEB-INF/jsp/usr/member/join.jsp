<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../common/head.jspf"%>

<script  src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script type="text/javascript"> 
let submitJoinFormDone = false;
let validLoginId = "";

/** 회원가입 폼 체크 */
function checkForm(form) {
	if (submitJoinFormDone) {
		alert("처리중입니다. \n새로고침 후 다시 시도해주세요");
		return;
	}
	
	let loginId = form.loginId.value.trim();
	let loginPw = form.loginPw.value.trim();
	let loginPw2 = form.loginPw2.value.trim();
	let userName = form.name.value.trim();
	let userEmail = form.email.value.trim();
	let userNickname = form.nickname.value.trim();
	let userPhoneNumber = form.phoneNumber.value.trim();
	
	if (!isNull(loginId)) {
		alert("아이디(을)를 입력해주세요.");
		form.loginId.focus();
		return;
	}

	if (validLoginId == loginId) {
		alert("이미 사용중인 아이디입니다.");
		return;
	}

	if (!isNull(loginPw)) {
		alert("비밀번호(을)를 입력해주세요.");
		form.loginPw.focus();
		return;
	}

	if (!isNull(loginPw2)) {
		alert("비밀번호(을)를 입력해주세요.");
		form.loginPw2.focus();
		return;
	}

	if (loginPw != loginPw2) {
		alert("비밀번호가 동일하지 않습니다. \n다시 확인해주세요.");
		form.loginPw.focus();
		return;
	} 

	if (!isNull(userName)) {
		alert("이름(을)를 입력해주세요.");
		form.name.focus();
		return;
	}

	if (!isNull(userEmail)) {
		alert("이메일(을)를 입력해주세요.");
		form.email.focus();
		return;
	}
	
	if(validEmailCheck(form.email) == false){
        alert('올바른 이메일 주소를 입력해주세요.') 
        form.email.focus();
        return;
    }

	if (!isNull(userNickname)) {
		alert("별명(을)를 입력해주세요.");
		form.nickname.focus();
		return;
	}

	if (!isNull(userPhoneNumber)) {
		alert("전화번호(을)를 입력해주세요.");
		form.phoneNumber.focus();
		return;
	}
	
	if (userPhoneNumber.length != 11) {
		alert("전화번호(을)를 11글자 입력해주세요");
		form.phoneNumber.focus();
		return;
	}

	form.submit();
	submitJoinFormDone = true;
}


/** 로그인아이디 중복 확인 */
function checkLoginIdDup(loginId) { 
	let data = loginId.value.trim(); 
	if (!isNull(data)) {
		$('.loginId-message').html('');
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
						.html('<div class="mt-1 loginId-message text-xs text-green-600">✔️ 사용가능한 아이디입니다</div>');
				} else if (resultCode == 'F') {
					validLoginId = loginId;
					$('.loginId-message')
						.html('<div class="mt-1 loginId-message text-xs text-red-600">🚫 이미 사용중인 아이디입니다.</div>');
				}
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
}

// 0.5초마다 로그인 아이디 중복 체크 
const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 500);
</script>

<div class="table-box-type-1 m-auto w-full lg:w-1/2">
  <form onsubmit="checkForm(this); return false;" action="/usr/member/doJoin" method="post" enctype="multipart/form-data">
    <div class="mt-8 mb-4">
      <label 
        for="loginId"
        class="block mb-2 text-sm font-medium label-text">아이디</label>
      <input 
        type="text" 
        name="loginId" 
        id="loginId"
        onkeyup="checkLoginIdDupDebounced(this);"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
        placeholder="아이디" 
        autocomplete="off" 
        required />
      <div class="text-xs loginId-message"></div>
    </div>

    <div class="mb-4">
      <label 
        for="loginPw"
        class="block mb-2 text-sm font-medium label-text">비밀번호</label>
      <input 
        type="password" 
        id="loginPw" 
        name="loginPw"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
        placeholder="비밀번호" 
        required 
        autoComplete="off" />
    </div>
    
    <div class="mb-4">
      <label 
        for="loginPw2"
        class="block mb-2 text-sm font-medium label-text">비밀번호</label>
      <input 
        type="password" 
        id="loginPw2" 
        name="loginPw2"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
        placeholder="비밀번호 재확인" 
        required 
        autoComplete="off" />
    </div>

    <div class="mb-4">
      <label 
        for="name"
        class="block mb-2 text-sm font-medium label-text">이름</label>
      <input 
        type="text" 
        name="name" 
        id="name"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm" 
        placeholder="이름"
        required />
    </div>
    
    <div class="mb-4">
      <label
        for="email"
        class="block mb-2 text-sm font-medium label-text">이메일</label>
      <input 
        type="email" 
        name="email" 
        id="email"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
        title="올바른 이메일을 등록해주세요."
        placeholder="abc@abc.com"  
        required />
    </div>

    <div class="mb-4">
      <label 
        for="nickname"
        class="block mb-2 text-sm font-medium label-text">별명</label>
      <input 
        type="text" 
        name="nickname" 
        id="nickname"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
        placeholder="별명" 
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
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm "
        placeholder="-를 빼고 숫자만 입력해주세요."
        maxlength="11" 
        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
        required />
    </div>
    
    <div  class="mb-4"> 
        <label class="block mb-2 text-sm font-medium label-text">
            프로필 이미지
        </label>
        <!-- 
                      :file
        relTypeCode   :member
        relId         :0
        typeCode      :extra
        type2Code     :profileImg
        fileNo        :1 (profileImg 중 1번)
         -->
        <input type="file" name="file__member__0__extra__profileImg__1" placeholder="프로필 이미지를 선택해주세요." />
     </div>

    <button 
      type="submit"
      class="w-full btn btn-primary mt-4 py-2 block text-center">회원가입</button>
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
