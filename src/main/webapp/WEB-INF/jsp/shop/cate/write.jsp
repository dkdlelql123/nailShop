<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 카테고리 생성" />
<%@ include file="../common/head.jspf"%> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script>
let submitWriterFormDone = false;
let vaildCateName = "";

/** 작성 폼 체크 */
function board__submitForm(form) {  
	if (submitWriterFormDone) {
		alert("처리중입니다.");
		return;
	}
	
	let nm = form.name.value.trim(); 
	
	if(!isNull(nm)){
		alert("카테고리명을 입력해주세요.");
      	form.name.focus();
		return;
	}  
    
    if(nm == vaildCateName){
		alert("사용이 불가능합니다. \n다시 입력해주세요");
		return;
	}
    
    //form.replyStatus.value = form.replyStatusBtn.value == "on" ? 0 : 1;
	form.submit();
	submitWriterFormDone = true;
}  

/** 이름 중복 확인 */
async function checkName(el){
  	let dataValue = el.value.trim();
  	let type = el.name;
  
 	let data = {
  		"value": dataValue,
  		"type": type	  
  	} 
  	let span = $("input[name="+el.name+"]").siblings("span");  
 	
	if(isNull(dataValue) && isNull(type)){	
  		await $.ajax({
        	url:"/adm/shop/cate/doCheck",
        	type: "GET",
        	data: data,
          	success: function(result){
        		if( result.resultCode.substr(0,1) == "S"){
                	span.html('<div class="text-xs pt-2 text-green-600">✔️ '+result.msg+'</div>');
              	} else {
                	span.html('<div class="text-xs pt-2 text-red-600">❌ '+result.msg+'</div>');
                	if( type == 'name' ){
                  		vaildBoardName = dataValue;
                    }  
          		}
        	},error: function(error){
          		console.log(error)			  
          	} 
      	})
  	} else {
  		span.html("")
  	}
}
const fncDebounce = _.debounce(checkName, 500);

 
</script>

<h1 class="font-title mb-8 text-3xl font-extrabold">상품카테고리 생성하기</h1>
<div>
  <div>
    <ul>
      <c:forEach var="item" items="${allCateList}" >
        <li class=" ${item.level == 1 ? 'mt-2 font-bold text-lg' : 'pl-2'} flex items-center">
          <c:out value="${item.category}" />
          &nbsp;
         <%--
         <a href="?id=${item.id}" class="text-xs" title="수정"> 
            <i class="far fa-edit"></i>
          </a> 
           &nbsp;
         <a href="/adm/shopCate/doDelete?id=${item.id}" class="text-xs text-red-800" title="삭제"> 
            <i class="far fa-trash-alt"></i>
          </a> 
        --%> 
        </li>
      </c:forEach>
    </ul>
  </div>

  <form onsubmit="board__submitForm(this); return false;" class="table-box-type-1 mt-4" action="/adm/shop/cate/doWrite" method="POST">
    <table >
      <colgroup>
        <col width="200" />
      </colgroup> 
      <tr>
        <th>상위 카테고리</th>
        <td>
            <select name="relId" class="select select-sm select-bordered ">
            <option disabled >-선택해주세요-</option>
            <option value="0">없음</option>
            <c:forEach var="cate" items="${cateList}" >
              <option value="${cate.id}">${cate.name}</option>
            </c:forEach>
            </select>
        </td>
      </tr>
      <tr>
        <th>이름</th>
        <td>
            <input type="text" class="w-full input input-sm" name="name" onkeyup="fncDebounce(this);"   
            required="required" placeholder="이름을 입력해주세요."  />
            <span></span>
        </td>
      </tr>  
      <!-- 
      <tr>
        <th>링크</th>
        <td>
            <input type="text" class="w-full input input-sm" name="link" placeholder="선택시 작성해주세요" />
        </td>
      </tr> 
      <tr>
        <th>설명</th>
        <td> 
          <textarea name="desc" class="w-full textarea" row="1" placeholder="간단한 설명을 작성해주세요" ></textarea>
        </td>
      </tr> -->  
      <tr>
        <th>사용여부</th>
        <td>
        <div class="flex gap-4">
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">사용</span> 
              <input type="radio" name="useYn" class="radio checked:bg-blue-500" value="1" checked />
            </label>
          </div> 
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">미사용</span> 
              <input type="radio" name="useYn" class="radio checked:bg-red-500" value="0" />
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
