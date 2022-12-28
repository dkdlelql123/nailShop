<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />
<%@ include file="./common/head.jspf"%>
<script>
function loginFormCheck(form){
	let loginId = form.loginId.value.trim();
	let loginPw = form.loginPw.value.trim();
	let formAlert = $("#formAlert");
	
	if(!isNull(loginId)){
		formAlert.html("<p class='my-4 py-2'>아이디를 입력해주세요</p>");
		form.loginId.focus();
		return false;
	}
	
	if(!isNull(loginPw)){
		formAlert.html("<p class='my-4 py-2'>비밀번호를 입력해주세요</p>"); 
		form.loginPw.focus();
		return false;
	}
	
	form.submit();
}
</script>

<div class="flex items-center justify-center py-8 px-4 sm:px-6 lg:px-8">
  <div class="max-w-md w-full space-y-8">
    <div>       
      <h2 class="mt-6 text-center text-3xl font-extrabold">LOGIN</h2>
    </div>
    <form class="mt-12 space-y-6"  action="/usr/member/doLogin" method="POST" onsubmit="loginFormCheck(this); return false;">   
    <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
      <div class="rounded-md shadow-sm -space-y-px">
        <div class="mb-6"> 
          <input id="email-address" name="loginId" type="text" autocomplete="email" required class="rounded-full appearance-none relative block w-full px-3 py-3 input input-md input-bordered rounded-lg focus:z-10 sm:text-sm" placeholder="Id">
        </div>
        <div> 
          <input id="password" name="loginPw" type="password" autocomplete="current-password" required class="rounded-full appearance-none relative block w-full px-3 py-3 input input-md input-bordered rounded-lg focus:z-10 sm:text-sm" autoComplete="off" placeholder="Password" >
        </div>
      </div> 
       
      <div id="formAlert" class="text-red-500 text-center bg-red-100 rounded"> 
      </div>

      <div>
        <button type="submit" class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-full text-white btn btn-primary">
          <span class="absolute left-0 inset-y-0 flex items-center pl-3"> 
            <svg class="h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>
          </span>
         로그인
        </button>
      </div>
      
      <div class="flex mb-4 gap-2">
              <label class="cursor-pointer label">
                <span class="label-text mr-2" >자동로그인</span>
                <input type="checkbox" name="autoLogined" 
                      class="checkbox checkbox-primary" value="자동로그인" /> 
              </label> 
      </div>
    </form> 

  </div>
</div>
 
 
</body>
</html>