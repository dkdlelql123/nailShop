<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시판생성" />
<%@ include file="../common/head.jspf"%> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script>
	let submitWriterFormDone = false;
	let vaildBoardName = "";
	let vaildBoardCode = "";

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
	    
	    form.replyStatus.value = form.replyStatusBtn.value == "on" ? 0 : 1;
	    
	    console.log(form.replyStatusBtn.value)
	    console.log(form.reactionPointStatusBtn.value)
	    
	    return ;

		//form.submit();
		//submitWriterFormDone = true;
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
                    	span.html('<div class="text-xs pt-2 text-red-600">❌ '+result.msg+'</div>');
                    
                    if( type == 'name' ){
                    	vaildBoardName = dataValue;
                    } else {
                    	vaildBoardCode = dataValue;
                    } 
                }
                }, error: function(error){
                	console.log(error)			  
                } 
            })
        }
	}
	const fncDebounce = _.debounce(checkName, 500) 
	 
</script>

<h1 class="font-title mb-8 text-3xl font-extrabold">게시판 생성하기</h1>
<div>
  <form onsubmit="board__submitForm(this); return false;"
    class="table-box-type-1" action="/adm/board/doWrite" method="POST">
    <table >
      <colgroup>
        <col width="200" />
      </colgroup>
      <tr>
        <th>이름</th>
        <td>
            <input type="text" class="w-full input input-sm" name="name" onkeyup="fncDebounce(this);"   
            required="required" placeholder="이름을 입력해주세요."  />
            <span></span>
        </td>
      </tr> 
      <tr>
        <th>코드</th>
        <td>
            <input type="text" class="w-full input input-sm" name="code"  onkeyup="fncDebounce(this);"
            required="required" placeholder="영문으로만 입력해주세요." />
            <span></span>
        </td>
      </tr> 
      <tr>
        <th>댓글 기능</th>
        <td>
          <div class="flex gap-4">
            <div class="form-control">
              <label class="label cursor-pointer">
                <span class="label-text mr-2">YES</span> 
                <input type="radio" name="replyStatus" class="radio checked:bg-blue-500" value="1" checked/>
              </label>
            </div> 
            <div class="form-control">
              <label class="label cursor-pointer">
                <span class="label-text mr-2">No</span> 
                <input type="radio" name="replyStatus" class="radio checked:bg-red-500" value="0"/>
              </label>
            </div>
          </div>
        </td>
      </tr> 
      <tr>
        <th>좋아요 기능</th>
        <td>
        <div class="flex gap-4">
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">YES</span> 
              <input type="radio" name="reactionPointStatus" class="radio checked:bg-blue-500" value="1" checked/>
            </label>
          </div> 
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">No</span> 
              <input type="radio" name="reactionPointStatus" class="radio checked:bg-red-500" value="0" />
            </label>
          </div> 
        </div> 
        </td>
      </tr> 
      <tr>
        <th>공개여부</th>
        <td>
        <div class="flex gap-4">
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">공개</span> 
              <input type="radio" name="publicStatus" class="radio checked:bg-blue-500" value="1" checked />
            </label>
          </div> 
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">비공개</span> 
              <input type="radio" name="publicStatus" class="radio checked:bg-red-500" value="0" />
            </label>
          </div> 
        </div> 
        </td>
      </tr>  
    </table>

    <div class="flex justify-end mt-4">
      <button type="submit" class="btn btn-info btn-sm">생성하기</button>
    </div>
  </form>
</div>



<%@ include file="../common/tail.jspf"%>
