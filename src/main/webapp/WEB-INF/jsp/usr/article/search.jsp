<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="검색" />
<%@ include file="../common/head.jspf"%>

<script> 
function check__searchFrom(form){  
  form.searchKeyword.value = form.searchKeyword.value.trim(); 
  
  if(form.searchKeyword.value.length < 1){
    form.searchKeyword.focus();
    $(".alertMessage").html(`<div class="text-center pt-4 text-warning ">한글자 이상 작성해주세요 😅</div>`);
    return;
  }
  $(".alertMessage").html();
  form.submit(); 
}
</script>

<section>
  <h2 class="hidden">전체검색</h2>
  <form action="/usr/article/searchList" method="get" onsubmit="check__searchFrom(this); return false; ">
   <input type="hidden" name="itemsCountInAPage" value="${param.itemsCountInAPage}" /> 
    <div class="form-control ">
      <div class="input-group input-group-lg justify-center">
        <input 
        type="search" 
        name="searchKeyword" 
        class="input input-lg input-bordered input-primary w-full max-w-xs"
        value="${param.searchKeyword}" 
        placeholder="Search…"  /> 
        <button class="btn btn-primary btn-lg">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </button>
      </div>
      <div class="alertMessage"></div>
    </div> 
  </form> 
</section>
 
<h1 class="font-title mt-20 mb-4 text-3xl font-extrabold">
  <span class="text-primary">"${param.searchKeyword}"</span> 검색결과 총 ${articlesCount}개
</h1> 

<c:if test="${articlesCount == 0}">
  <div>검색 조건에 맞는 게시물이 없습니다.</div>
</c:if>
  
<c:if test="${articlesCount != 0}">
  <div class="flex itmes-center justify-end my-4">  
    <div class="form-control">
      <form>  
         <input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />  
         <select id="select" name="itemsCountInAPage" data-value="${param.itemsCountInAPage}" 
            onchange="this.form.submit();"
            class="select select-sm select-bordered font-normal" style="font-weight:normal"> 
            <option value="10" selected>10개씩 보기</option>
            <option value="20">20개씩 보기</option>
            <option value="50">50개씩 보기</option>
          </select>
      </form>
    </div> 
  </div>
  
  
  <div class="table-box-type-1">
    <table id="boardtable">
      <colgroup>
        <col width="100">
        <col width="500">
      </colgroup>
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>조회</th>
          <c:if test="${reactionPointStatus == 0}">
            <th>추천</th>
          </c:if>
          <th>작성자</th>
          <th>작성일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="article" items="${articles}">
          <tr>
            <th class="text-center">${article.id}</th>
            <td>
              <a href="${rq.getArticleDetailFromList(article)}">${article.title}</a>
              <c:if test="${replyStatus == 0}"> [0] </c:if>
            </td>
            <td class="text-center">${article.hit}</td>
            <c:if test="${reactionPointStatus == 0}">
              <td class="text-center">${article.goodReactionPoint}</td>
            </c:if>
            <td class="text-center">${article.extra__writerName}</td>
            <td class="text-center">${article.forPrintType1RegDate}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  
  <!-- 페이지 관련 -->
  <c:set var="pageRange" value="9" />
  <c:set var="startPage" value="${page - pageRange >= 1 ? page - pageRange : 1}" />
  <c:set var="endPage" value="${ startPage+pageRange <= pagesCount ? startPage+pageRange : pagesCount }" />
   
  <c:set var="baseUri" value="?" />
  <c:set var="baseUri" value="${baseUri}&itemsCountInAPage=${param.itemsCountInAPage}" /> 
  <c:set var="baseUri" value="${baseUri}&searchKeyword=${param.searchKeyword}" />
  
  <div class="flex justify-center mt-8">
    <div class="btn-group">
      <c:if test="${page != 1}">
        <a href="${baseUri}&page=1"  class="btn btn-sm">«</a>
      </c:if>
      
      <c:forEach begin="${startPage}" end="${endPage}" var="i">
        <a
          href="${baseUri}&page=${i}"
         class="btn btn-sm ${page == i ? 'btn-active' : '' }">${i}</a>
      </c:forEach>
      
      <c:if test="${page != pagesCount && pagesCount != 1 }">
      <a 
        href="${baseUri}&page=${pagesCount}" 
        class="btn btn-sm">»</a>
      </c:if>
    </div>
  </div> 
</c:if>
  



<%@ include file="../common/tail.jspf"%>
