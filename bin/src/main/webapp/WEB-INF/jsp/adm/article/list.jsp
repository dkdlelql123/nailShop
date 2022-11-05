<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시글관리" />
<%@ include file="../common/head.jspf"%>


<h1 class="font-title mb-4 text-3xl font-extrabold">게시글 총 ${articlesCount}개</h1>
<div class="form-control">
  <form class="input-group justify-center" name="search-form"> 
    <input type="hidden" name="itemsCountInAPage" value="${param.itemsCountInAPage}" />
    <select id="select" name="searchKeywordType" data-value="${param.searchKeywordType}"
      class="select select-md select-bordered border-r-0 rounded-r-none"
      style="border-bottom-right-radius: 0px; border-top-right-radius: 0px; font-weight: normal">
      <option value="title,body" selected>제목,내용</option>
      <option value="title">제목</option>
      <option value="body">내용</option>
    </select>
    <input type="text" name="searchKeyword"
      value="${param.searchKeyword}" placeholder="Search…"
      class="input input-md input-bordered" />
    <button type="submit" class="btn btn-md btn-square">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5"
        fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round"
          stroke="#fff" stroke-width="2"
          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>
    </button>
  </form>
</div>

<div class="flex itmes-center justify-between my-4">
  <div class="form-control">
    <form>
      <input type="hidden" name="searchKeywordType" value="${param.searchKeywordType}" />
      <input type="hidden" name="searchKeyword" value="${param.searchKeyword}" /> 
      <select id="select" name="itemsCountInAPage"
        data-value="${param.itemsCountInAPage}"
        onchange="this.form.submit();"
        class="select select-sm select-bordered font-normal"
        style="font-weight: normal">
        <option value="10" selected>10개씩 보기</option>
        <option value="20">20개씩 보기</option>
        <option value="50">50개씩 보기</option>
      </select>
    </form>
  </div>
  <div>
    <a href="/usr/article/write" class="btn btn-sm btn-info">생성</a>
  </div>
</div>


<div class="table-box-type-1">
  <table id="boardtable">
    <colgroup>
      <col width="45">
      <col width="100">
      <col> 
      <col width="100">
      <col width="100">
      <col width="120">
    </colgroup>
    <thead>
      <tr>
        <th><input type="checkbox" class="allCheckIds" /></th>
        <th>번호</th>
        <th>제목</th>
        <th>조회</th> 
        <th>작성자</th>
        <th>작성일</th> 
      </tr>
    </thead>
    <tbody>
      <c:forEach var="article" items="${articles}">
        <tr>
          <th><input type="checkbox" class="checkId" value="${board.id}"/></th>
          <td class="text-center">${article.id}</td>
          <td>
            <a href="${rq.getArticleDetailFromList(article)}">${article.title}</a>
          </td>
          <td class="text-center">${article.hit}</td> 
          <td class="text-center">${article.extra__writerName}</td>
          <td class="text-center">${article.forPrintType1RegDate}</td>
        </tr>  
      </c:forEach>
    </tbody>
  </table>
</div>

<script>
$(".allCheckIds").change(function(){
    const $this = $(this);
    const checkedStatus = $this.prop("checked");
    
    $(".checkId").prop("checked",checkedStatus );
  });
  
  $(".checkId").change(function(){
    const checkIdCount = $(".checkId").length;
    const checkIdCheckedCount = $(".checkId:checked").length;
    
    const allCheck = checkIdCount == checkIdCheckedCount ;
    
    $(".allCheckIds").prop("checked", allCheck);
  }); 
</script>


<!-- 페이지 관련 -->
<c:set var="pageRange" value="9" />
<c:set var="startPage" value="${page - pageRange >= 1 ? page - pageRange : 1}" />
<c:set var="endPage" value="${ startPage+pageRange <= pagesCount ? startPage+pageRange : pagesCount }" />
 
<c:set var="baseUri" value="?" />
<c:set var="baseUri" value="${baseUri}&itemsCountInAPage=${param.itemsCountInAPage}" /> 
<c:set var="baseUri" value="${baseUri}&searchKeywordType=${param.searchKeywordType}" />
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



<%@ include file="../common/tail.jspf"%>