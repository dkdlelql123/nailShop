<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 리스트" />
<%@ include file="../common/head.jspf"%>

<h1 class="font-title mb-4 text-3xl font-extrabold">${board.name} 총 ${articlesCount}개</h1>
<c:if test="${not empty board.link}">
<a href="${board.link}" target="_blank"class="text-base-content/70">✨ 해당 사이트로 이동(클릭)</a>
</c:if>
 
<c:if test="${rq.member.authLevel == 10}">
  <div class="flex justify-end">  
    <a href="/usr/article/write?boardId=${board.id}"
      class="btn btn-sm btn-primary">글쓰기</a>
  </div>
</c:if>

<div class="flex flex-col-reverse lg:flex-row gap-2 lg:gap-0 itmes-center justify-between mt-12 mb-4 md:my-4">  
  <div class="form-control">
    <form>
       <input type="hidden" name="boardId" value="${param.boardId}" /> 
       <input type="hidden" name="searchKeywordType" value="${param.searchKeywordType}" />
       <input type="hidden" name="searchKeyword" value="${param.searchKeyword}" /> 
       
       <select id="select" name="itemsCountInAPage" data-value="${param.itemsCountInAPage}" 
          onchange="this.form.submit();"
          class="select select-sm select-bordered font-normal" 
          style="font-weight:normal"> 
          <option value="10" selected>10개씩 보기</option>
          <option value="20">20개씩 보기</option>
          <option value="50">50개씩 보기</option>
        </select>
    </form>
  </div>
  
  <div class="form-control">
    <form class="input-group border-primary border justify-center rounded-full sm:border-none " name="search-form">
     <select id="select" name="searchKeywordType" data-value="${param.searchKeywordType}" 
        class="select select-sm select-bordered border-r-0 rounded-r-none hidden sm:inline">
        <option value="title" selected>제목</option>
        <option value="body">내용</option>
        <option value="title,body">제목+내용</option>
      </select>
      <input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="Search…" 
      class="input input-sm input-bordered w-11/12 sm:w-1/4 lg:w-1/2 border-0 sm:border my-1 sm:my-0 focus:z-10 focus:outline-none appearance-none"/>
      
      <!--  중간에 위치시키는 이유는 css적용 때문에 -->
     <input type="hidden" name="boardId" value="${param.boardId}" />
     <input type="hidden" name="itemsCountInAPage" value="${param.itemsCountInAPage}" />
     
      <button type="submit" class="btn btn-sm px-1 py-0 hidden sm:inline">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke="#fff" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>
      </button>
    </form>
  </div> 
</div>

<div class="table-box-type-1">
  <table id="boardtable">
    <colgroup> 
      <col>
      <col width="80">
      <col width="100">
    </colgroup>
    <thead>
      <tr> 
        <th>제목</th>
        <th>조회</th> 
        <th>작성일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="article" items="${articles}">
        <tr> 
          <td>
             <div>
                <a class="flex flex-wrap gap-2" href="${rq.getArticleDetailFromList(article)}">
                  ${article.title}
                  <c:if test="${replyStatus == 1}"> 
                    <span class="text-base-content/60 text-sm"><i class="far fa-comment-dots"></i> ${article.extra__replyCount}</span>
                  </c:if>
                  <c:if test="${reactionPointStatus == 1}">
                    <span class="text-base-content/60 text-sm"><i class="far fa-heart"></i> ${article.goodReactionPoint}</span>
                  </c:if>  
                </a>
              </div>
              <!-- <div class="flex items-center gap-1">
                <span class="text-base-content/70 text-xs" >${article.extra__writerName}</span>
                <span class="text-base-content/70 text-xs lg:hidden" >${article.forPrintType1RegDate}</span>
              </div> -->
          </td>
          <td class="text-center">${article.hit}</td> 
          <td class="text-center"> ${article.forPrintType1RegDate}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<!-- 페이지 관련 -->
<c:set var="pageRange" value="9" />
<c:set var="startPage" value="${page - pageRange >= 1 ? page - pageRange : 1}" />
<c:set var="endPage" value="${ startPage+pageRange <= pagesCount ? startPage+pageRange : pagesCount }" />

<c:set var="baseUri" value="?boardId=${board.id}" />
<c:set var="baseUri" value="${baseUri}&itemsCountInAPage=${param.itemsCountInAPage}" />
<c:set var="baseUri" value="${baseUri}&searchKeywordType=${param.searchKeywordType}" />
<c:set var="baseUri" value="${baseUri}&searchKeyword=${param.searchKeyword}" />

<div class="flex justify-center mt-8">
  <div class="btn-group">
    <c:if test="${page != 1}">
      <a href="${baseUri}&page=1" class="btn btn-sm btn-outline btn-primary ">«</a>
    </c:if>
    
    <c:forEach begin="${startPage}" end="${endPage}" var="i">
      <a
        href="${baseUri}&page=${i}"
       class="btn btn-sm btn-outline btn-primary  ${page == i ? 'btn-active' : '' }">${i}</a>
    </c:forEach>
    
    <c:if test="${page != pagesCount && pagesCount != 1 }">
    <a 
      href="${baseUri}&page=${pagesCount}" 
      class="btn btn-sm btn-outline btn-primary ">»</a>
    </c:if>
  </div>
</div>

<%@ include file="../common/tail.jspf"%>
