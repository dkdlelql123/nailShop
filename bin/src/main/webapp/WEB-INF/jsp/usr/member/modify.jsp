<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.nyj.exam.demo.util.Ut"%>

<c:set var="pageTitle" value="회원가입수정" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">

function deleteProfileImg(chk){
	let status = $("#delete__profileImg").prop("checked");
	if(status) {
		$(".profileImg").addClass(' btn-disabled');
	} else{
		$(".profileImg").removeClass(' btn-disabled');
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
			alert("처리중입니다. \n새로고침 후 이용해주세요.");
			return;
		}

		if (form.loginPw.value.trim().length > 0) {
			if (form.loginPw2.value.trim().length <= 0) {
				$(".messege").html("<div class='py-2'>비밀번호을(를) 입력해주세요.</div>")
				form.loginPw2.focus();
				return;
			}

			if (form.loginPw.value != form.loginPw2.value) {
				$(".messege").html("<div class='py-2'>비밀번호가 일치하지 않습니다.</div>")
				form.loginPw2.focus();
				return;
			}
		}
		;

		if (!isNull(form.email.value)) {
			$(".messege").html("<div class='py-2'>이메일을(를) 입력해주세요.</div>");
			form.email.focus();
			return;
		}

		if (!isNull(form.nickname.value)) {
			$(".messege").html("<div class='py-2'>별명을(를) 입력해주세요.</div>");
			form.nickname.focus();
			return;
		}

		if (!isNull(form.phoneNumber.value)) {
			$(".messege").html("<div class='py-2'>전화번호을(를) 입력해주세요.</div>");
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
		
		// 기본 프로필 이미지 체크시 (이미지 삭제)
	    // const deleteProfileImgFileInput = $("#delete__profileImg");
		
   		const deleteProfileImgFileInput = form["deleteFile__member__0__extra__profileImg__1"];
        if ( deleteProfileImgFileInput.checked ) {
            form["file__member__0__extra__profileImg__1"].value = '';
        }

		$(".messege").html("");

		submitJoinFormDone = true;
		form.submit();
	}
	
</script>

<div class="table-box-type-1 m-auto w-full lg:w-1/2">
  <h1 class="text-3xl font-bold text-center">내정보 수정</h1>

  <form 
    onsubmit="checkForm(this); return false;"
    action="/usr/member/doModify" 
    method="post"
    enctype="multipart/form-data">
    <input type="hidden" name="memberModifyAuthKey"
      value="${param.memberModifyAuthKey}" />

    <div
      class="mask mask-squircle bg-base-content h-24 w-24 bg-opacity-10 p-px mx-auto mt-8 ">
      <img src="${member.getProfileImgUri()}"
        onerror="${member.getProfileFallbackImgOnErrorHtmlAttr()}"
        width="94" height="94" alt="member img"
        class="mask mask-squircle" />
    </div>
    <div class="mb-4 flex gap-2 items-center justify-center ">
      <div class="form-control">
        <label class="label cursor-pointer">
          <input type="checkbox" 
          name="deleteFile__member__0__extra__profileImg__1"
          id="delete__profileImg" 
          onclick="deleteProfileImg()"
          class="checkbox checkbox-primary checkbox-xs"  />
          &nbsp;
          <span class="label-text">기본이미지 선택</span>
        </label>
      </div>
      <div class="text-base-content/70">|</div>
      <label class="profileImg btn btn-xs btn-primary text-center label-text" for="profileImg" > 프로필 이미지 변경 </label>
      <div class="hidden">
        <!-- 
                      :file
        relTypeCode   :member
        relId         :0
        typeCode      :extra
        type2Code     :profileImg
        fileNo        :1 (profileImg 중 1번)
         -->
        <input 
          type="file" 
          onerror="${member.removeProfileImgIfNotExistsOnErrorHtmlAttr}" 
          name="file__member__0__extra__profileImg__1"
          src="${member.profileImgUri}" 
          id="profileImg" 
          accept="image/png image/jpeg image/jpg"
          placeholder="프로필 이미지를 선택해주세요." />
      </div>
    </div>

    <div class="mb-4">
      <label for="loginId"
        class="block mb-2 text-sm font-medium label-text">아이디</label>
      <input type="text" name="loginId" id="loginId"
        aria-label="disabled input"
        class="block p-2 w-full  input input-sm input-bordered rounded-lg sm:text-xs"
        value="${member.loginId}" readonly disabled />
    </div>
    <div class="mb-4">
      <label for="loginPw"
        class="block mb-2 text-sm font-medium label-text">새 비밀번호</label>
      <input type="password" id="loginPw" name="loginPw"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-xs"
        placeholder="새 비밀번호" autoComplete="off" />
    </div>
    <div class="mb-4">
      <label for="loginPw2"
        class="block mb-2 text-sm font-medium label-text">비밀번호
        재확인</label>
      <input type="password" name="loginPw2" id="loginPw2"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-xs"
        placeholder="새 비밀번호 재확인" autoComplete="off" />
    </div>
    <div class="mb-4">
      <label for="name"
        class="block mb-2 text-sm font-medium label-text">이름</label>
      <input type="text" name="name" id="name"
        aria-label="disabled input"
        class="block p-2 cursor-not-allowed w-full input input-sm input-bordered rounded-lg sm:text-xs"
        value="${member.name}" readonly disabled required />
    </div>
    <div class="mb-4">
      <label for="email"
        class="block mb-2 text-sm font-medium label-text">이메일</label>
      <input type="text" name="email" id="email"
        aria-label="disabled input"
        class="block cursor-not-allowed p-2 w-full input input-sm input-bordered rounded-lg sm:text-xs"
        value="${member.email}" readonly disabled required />
    </div>
    <div class="mb-4">
      <label for="nickname"
        class="block mb-2 text-sm font-medium label-text">별명</label>
      <input type="text" name="nickname" id="nickname"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-xs"
        value="${member.nickname}" />
    </div>
    <div class="mb-4">
      <label for="phoneNumber"
        class="block mb-2 text-sm font-medium label-text">전화번호</label>
      <input type="text" name="phoneNumber" id="phoneNumber"
        class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-xs"
        value="${member.phoneNumber}" />
    </div>

    <div
      class="messege mt-4 text-red-500 text-center bg-red-100 rounded"></div>

    <button class="w-full btn btn-primary mt-4 py-2 block text-center">정보수정</button>
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
