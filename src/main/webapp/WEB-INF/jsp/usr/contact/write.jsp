<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="CONTACT" />
<%@ include file="../common/head.jspf"%>
 
<script>
	
	let submitWriterFormDone = false;
	let num1 = Math.floor(Math.random() * 10);
	let	num2 = Math.floor(Math.random() * 11) + 5;
	
	$(function(){
		$(".num1").text(num1);
		$(".num2").text(num2);
	});

	async function mail__submitForm(form) { 
		if (submitWriterFormDone) {
			alert("처리중이거나 이미 메일을 보낸상태입니다.");
			return;
		}
		
		form.name.value =form.name.value.trim(); 
		if(form.name.value == null || form.name.value <= 0){
			alert("이름을 입력해주세요.");
			form.name.focus();
			return;
		} 
	
		form.email.value =form.email.value.trim();
	    if (form.email.value.length == 0) {
	      alert('이메일을 입력해주세요.');
	      form.email.focus();
	      return;
	    }
 
	    form.body.value = form.body.value.trim();
	    if (form.body.value.length < 5) {
			alert("내용을 5글자 이상 작성해주세요."); 
			return; 
	    }
	    
	    if(form.calc.value.trim() != (num2+num1)){
	    	alert("덧셈 계산이 틀렸습니다.");
	    	return;
	    } 
	    
	    let url = "/usr/contact/send";
	    let data = {
    		"name" :form.name.value,
    		"email" :form.email.value,
    		"body" :form.body.value,
	    }

	    $("#sendMail").addClass("loading animate-bounce ");
	    let res = await $.post(url, data);
	    $("#sendMail").removeClass("loading animate-bounce");

		submitWriterFormDone = true;
	} 
</script>


<div>
  <form onsubmit="mail__submitForm(this); return false;"> 
    <div class="card flex-shrink-0 w-full max-w-2xl shadow-2xl bg-base-100 mx-auto">
      <div class="card-body">
        <div class="md:flex md:gap-4">
          <div class="md:flex-grow form-control"> 
            <label class="label">
              <span class="label-text">이름</span>
            </label>
            <input type="text" name="name" placeholder="이름" class="input input-bordered" required  />
          </div>
           <div class="md:flex-grow form-control">
            <label class="label">
              <span class="label-text">Email</span>
            </label>
            <input type="email" name="email" placeholder="email" class="input input-bordered" required/>
          </div>
        </div>
        <div class="form-control"> 
         <label class="label">
            <span class="label-text">Message</span>
          </label>
          <textarea class="textarea textarea-bordered " name="body" rows=5 placeholder="메시지를 입력하세요." required ></textarea>
        </div>
       <div class="form-control"> 
          <div class="flex items-center justify-end gap-2">
          <span class="num1"></span>
          +
          <span class="num2"></span>
          =
          <input type="text" name="calc" placeholder="?" class="input input-bordered text-center w-20" required/>
          </div>
        </div>
        <div class="form-control mt-6">
          <button type="submit" id="sendMail" class="btn btn-primary transition duration-100">전송</button>
        </div>
      </div>
    </div>
     
  </form>
</div>

 
<%@ include file="../common/tail.jspf"%>
