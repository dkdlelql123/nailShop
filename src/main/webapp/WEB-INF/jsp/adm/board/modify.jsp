<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시판수정" />
<%@ include file="../common/head.jspf"%> 

<input type="hidden" id="name" value="${board.name}" />
<input type="hidden" id="code" value="${board.code}" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script>
$(function() {
	$("input[name='name']").focus();
})
</script>
<script>
  let submitWriterFormDone = false;
  let vaildBoardName = "";
  let vaildBoardCode = "";
  const currentBoardName = document.getElementById("name").value;
  const currentBoardCode = document.getElementById("code").value;
  function board__submitForm(form) {
    if (submitWriterFormDone) {
      alert("처리중입니다.");
      return;
    }
    
    form.name.value =form.name.value.trim();
    if(form.name.value == null || form.name.value <= 0){
      alert("게시판 이름을 입력해주세요.");
      form.name.focus();
      return;
    } 
       
    form.code.value =form.code.value.trim(); 
    if (form.code.value == null || form.code.value <= 0) {
    	alert("게시판 이름을 입력해주세요.");
      form.code.focus();
	return;
    }
    
    if( form.name.value == vaildBoardName || form.code.value == vaildBoardCode){
    	alert("사용이 불가능합니다. \n다시 입력해주세요");
   	return;
    }
    form.submit();
    submitWriterFormDone = true;
  }  
  function checkName(el){
    let dataValue = el.value.trim();
    let type = el.name;
    
    let data = {
        "value": dataValue,
        "type": type    
      } 
    let span = $("input[name="+el.name+"]").siblings("span");  
      if(dataValue.length > 0 && type != null){   
        $.ajax({
            url:"/adm/board/doCheck",
            type: "GET",
            data: data,
              success: function(result){
                  if( result.resultCode.substr(0,1) == "S"){
                     span.html('<div class="text-xs pt-2 text-green-600">✔️ '+result.msg+'</div>');
                  } else {                    
                     if( type == 'name' ){
                        vaildBoardName = dataValue;
                        if(currentBoardName == dataValue){
                        	return
                        }
                     } else {
                        vaildBoardCode = dataValue;
                        if(currentBoardCode == dataValue){
                        	return
                        }
                     }
                	 
                   	 span.html('<div class="text-xs pt-2 text-red-600">❌ '+result.msg+'</div>');
              	  }
              }, error: function(error){
                console.log(error)        
              } 
          })
      }
  }
  const fncDebounce = _.debounce(checkName, 500)
</script>

<h1 class="font-title mb-8 text-3xl font-extrabold">게시판 수정</h1>

<div class="table-box-type-1">
  <form action="/adm/board/doModify" method="post" onsubmit="board__submitForm(this); return false;"> 
    <table>
      <colgroup>
        <col width="200" />
        <col/>
        <col width="200" />
        <col/>
      </colgroup>
       <tr>
        <th>번호</th>
        <td colspan="3">
          <input type="text" name="id" value="${board.id}" readonly/>
        </td>
       </tr>

       <tr>
        <th>생성일자</th>
        <td>
          ${board.forPrintType1RegData} 
        </td>
        <th>생성일자</th>
        <td>
          ${board.forPrintType1UpdateData}
        </td>
      </tr>

      <tr>
        <th>이름</th>
        <td colspan="3">
            <input type="text" class="w-full input input-sm" name="name" onkeyup="fncDebounce(this);"   
            required="required" placeholder="이름을 입력해주세요."  value="${board.name}" />
            <span></span>
        </td>
      </tr> 

      <tr>
        <th>코드</th>
        <td colspan="3">
            <input type="text" class="w-full input input-sm" name="code" onkeyup="fncDebounce(this);"   
            required="required" placeholder="코드를 입력해주세요."  value="${board.code}" />
            <span></span>
        </td>
      </tr>
    </table>

    <div class="flex justify-end mt-4 gap-2">
      <button type="submit" class="btn btn-info btn-sm">수정</button>
      <a href="/adm/board/list" class="btn btn-info btn-sm btn-outline">목록</a>
    </div>
  </form>
</div>



<%@ include file="../common/tail.jspf"%>