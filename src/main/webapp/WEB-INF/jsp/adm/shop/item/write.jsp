<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시판생성" />
<%@ include file="../../common/head.jspf"%> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script> 
 

<h1 class="font-title mb-8 text-3xl font-extrabold">상품 생성하기</h1>
<div>
  <form onsubmit="submitForm_check(this); return false;" class="table-box-type-1 mt-4" action="/adm/shop/item/doWrite" method="POST">
    <table >
      <colgroup>
        <col width="200" />
      </colgroup> 
      <tr>
        <th>카테고리</th>
        <td>
            <select name="relId" class="select select-sm select-bordered ">
            <option disabled >-선택해주세요-</option> 
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
      </tr>  -->  
      <tr>
        <th>설명</th>
        <td> 
          <input type="text" class="w-full input input-sm" name="desc"  placeholder="간단한 설명을 작성해주세요" /> 
        </td>
      </tr>
       
      
       <tr>
        <th>가격</th>
        <td>
           <input type="text" class="w-full input input-sm" name="price"  placeholder="가격을 작성해주세요" /> 
        </td>
      </tr>
      <tr>
        <th>세일가격</th>
        <td> 
           <input type="text" class="w-full input input-sm" name="price"  placeholder="세일가격을 작성해주세요" /> 
       
        </td>
      </tr>  
      
      <tr>
        <th>계절</th>
        <td>
            
        </td>
      </tr>
      
       <tr>
        <th>톤 타입</th>
        <td>
            
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
      <button type="submit" class="btn btn-info btn-sm">생성하기</button>
    </div>
  </form>
</div>


<%@ include file="../../common/tail.jspf"%>
