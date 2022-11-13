<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="title" value="${id == 0 ? '생성':'수정'}"/>
<c:set var="pageTitle" value="관리자 - 상품${title}" />  
 
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

<h1 class="font-title mb-8 text-3xl font-extrabold">상품 ${title}하기</h1> 

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
              <label class="cursor-pointer label" for="cate${item.id}">
                <span class="label-text mr-2" >${item.name}</span>
                <input type="radio" name="categoryId"  id="cate${item.id}" class="category radio checked:bg-blue-500" value="${item.id}"  ${item.id == category ? "checked=true" : null} /> 
              </label> 
            </c:forEach>
          </div>
        </td>
      </tr>
      <tr>
        <th class="req">이름</th>
        <td>
            <input type="text" class="w-full input input-sm" name="name" required="required" placeholder="이름을 입력해주세요." value="${shopItem.name}"  />
        </td>
      </tr> 
 
      <tr>
        <th>설명</th>
        <td> 
          <input type="text" class="w-full input input-sm" name="desc"  placeholder="간단한 설명을 작성해주세요"  value="${shopItem.desc}"  />
        </td>
      </tr> 
       <tr>
        <th>가격</th>
        <td>
           <input type="text" class="w-full input input-sm" name="price" id="price"  placeholder="가격을 작성해주세요"
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  
            value="${shopItem.price}" 
            title="숫자만 입력이 가능합니다."
            /> 
        </td>
      </tr>
      <tr>
        <th>세일가격</th>
        <td> 
           <input type="text" class="w-full input input-sm" name="sale"  placeholder="세일가격을 작성해주세요" 
            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="0"
            value="${shopItem.sale}" 
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
                      class="checkbox checkbox-primary seasonCheckBox" 
                      value="${item.id}" 
                      <c:if test="${fn:contains(shopItem.seasonType, item.id) }">checked</c:if>
                      /> 
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
                       class="checkbox checkbox-primary toneCheckBox" 
                       value="${item.id}" 
                       <c:if test="${fn:contains(shopItem.toneType, item.id)}"> checked</c:if> 
                       /> 
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
              <input type="radio" name="useYn" class="radio checked:bg-blue-500" value="1" ${id == 0 ? "checked" : null} ${shopItem.useYn == 1 ? "checked" : null}  />
            </label>
          </div> 
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text mr-2">미사용</span> 
              <input type="radio" name="useYn" class="radio checked:bg-red-500" value="0"  ${shopItem.useYn == 0 ? "checked" : null}  />
            </label>
          </div> 
        </div> 
        </td>
      </tr>  
    </table>

    <div class="flex justify-end mt-4">
      <button type="submit" class="btn btn-info btn-sm">${title}</button>
    </div>
  </form>
</div>

 

<%@ include file="../../common/tail.jspf"%>
