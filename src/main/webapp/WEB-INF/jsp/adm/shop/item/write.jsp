<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 상품생성" />  
 
<%@ include file="../../common/head.jspf"%> 

<script>
let submitWriterFormDone = false ;

/** 작성 폼 체크 */
function submitForm_check(form) {  
  if (submitWriterFormDone) {
    alert("처리중입니다.");
    return;
  }
  
  let nm = form.name.value.trim(); 
  let price = form.price.value.trim();  
  
  if(!isNull(nm)){
    alert("이름을 입력해주세요.");
        form.name.focus();
    return;
  }   

  console.log(price > 0)
  if( price <= 0 || price == '0' || !isNull(price)){
    alert("가격을 입력해주세요.");
        form.price.focus();
    return;
  } 
   
  let seasonList = "", toneList = "";
  
  $("input.seasonCheckBox:checked").each(function(i, val) {  
	  seasonList += val.value +" ";
  }); 
  
  $("input.toneCheckBox:checked").each(function(i, val) { 
	  toneList += val.value +" "; 
  });
  
  form.seasonType.value = seasonList;
  form.toneType.value = toneList;
   
  let itemId = form.id.value;
  if(itemId == 0){
    form.action = "/adm/shop/item/doWrite";	  
  } else {	  
    form.action = "/adm/shop/item/doModify";	  
  }
  
  form.method = "POST";
  form.submit();
  submitWriterFormDone = true;
}  

</script>

<h1 class="font-title mb-8 text-3xl font-extrabold">상품 생성하기</h1>
<div> 
  <form onsubmit="submitForm_check(this); return false;" class="table-box-type-1 mt-4" >
    <input type="hidden" name="id" id="id" value="${id}" />
    <input type="hidden" name="seasonType" value="" />
    <input type="hidden" name="toneType" value="" />
    <table >
      <colgroup>
        <col width="200" />
      </colgroup>   
      <tr>
        <th class="req">카테고리</th>
        <td>
           <div class="flex gap-4">
            <c:forEach var="item" items="${cateList}">
              <label class="cursor-pointer label">
                <span class="label-text mr-2" >${item.name}</span>
                <input type="radio" name="categoryId" class="category${item.id} radio checked:bg-blue-500" value="${item.id}" /> 
              </label> 
            </c:forEach>
          </div>
        </td>
      </tr>
      <tr>
        <th class="req">이름</th>
        <td>
            <input type="text" class="w-full input input-sm" name="name" required="required" placeholder="이름을 입력해주세요."  />
        </td>
      </tr> 
 
      <tr>
        <th>설명</th>
        <td> 
          <input type="text" class="w-full input input-sm" name="desc"  placeholder="간단한 설명을 작성해주세요" /> 
        </td>
      </tr> 
       <tr>
        <th>가격</th>
        <td>
           <input type="text" class="w-full input input-sm" name="price" id="price"  placeholder="가격을 작성해주세요"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  
            title="숫자만 입력이 가능합니다."
            /> 
        </td>
      </tr>
      <tr>
        <th>세일가격</th>
        <td> 
           <input type="text" class="w-full input input-sm" name="sale"  placeholder="세일가격을 작성해주세요" 
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="0"
            title="숫자만 입력이 가능합니다."
           /> 
        </td>
      </tr>  
      
      <tr>
        <th>계절</th>
        <td>
          <div class="flex gap-4">
            <c:forEach var="item" items="${seasonList}">
              <label class="cursor-pointer label">
                <span class="label-text mr-2" >${item.name}</span>
                <input type="checkbox" name="seasonList" 
                      class="checkbox checkbox-primary seasonCheckBox" value="${item.id}" /> 
              </label> 
            </c:forEach>
            </div>
        </td>
      </tr> 
       <tr>
        <th>톤 타입</th>
        <td> 
          <div class="flex gap-4">
            <c:forEach var="item" items="${toneTypeList}">
              <label class="cursor-pointer label">
                <span class="label-text mr-2">${item.name}</span>
                <input type="checkbox" name="toneTypeList" 
                       class="checkbox checkbox-primary toneCheckBox" value="${item.id}" /> 
              </label> 
            </c:forEach>
            </div>
        </td>
      </tr>  
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
      <button type="submit" class="btn btn-info btn-sm">${id == 0 ? '생성':'수정' }</button>
    </div>
  </form>
</div>

<script>

/** 초기화 */
if( $("#id").val() == 0 ){
	$(".category2").prop("checked", true);
}
</script>

<%@ include file="../../common/tail.jspf"%>
