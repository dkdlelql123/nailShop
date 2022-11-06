<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시판관리" />
<%@ include file="../common/head.jspf"%>

<h1 class="font-title mb-4 text-3xl font-extrabold">게시판 총 ${boardsCount}개</h1>
<div class="form-control">
  <form class="input-group justify-center" name="search-form"> 
    <input type="hidden" name="itemsCountInAPage"
      value="${param.itemsCountInAPage}" />
    <select id="select" name="searchKeywordType"
      data-value="${param.searchKeywordType}"
      class="select select-md select-bordered border-r-0 rounded-r-none"
      style="border-bottom-right-radius: 0px; border-top-right-radius: 0px; font-weight: normal">
      <option value="name,code" selected>이름,코드</option>
      <option value="name">이름</option>
      <option value="code">코드</option>
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
      <input type="hidden" name="searchKeywordType"
        value="${param.searchKeywordType}" />
      <input type="hidden" name="searchKeyword"
        value="${param.searchKeyword}" /> 
      <select id="select" name="itemsCountInAPage"
        data-value="${param.itemsCountInAPage}"
        onchange="this.form.submit();"
        class="select select-sm select-bordered font-normal"
        style="font-weight: normal">
        <option value="5" selected>5개씩 보기</option>
        <option value="10">10개씩 보기</option>
        <option value="20">20개씩 보기</option>
        <option value="50">50개씩 보기</option>
      </select>
    </form>
  </div>
  <div>
    <a href="/adm/board/write" class="btn btn-sm btn-info">생성</a>
  </div>
</div>


<div class="table-box-type-1">
  <table id="boardtable">
    <colgroup>
      <col width="45">
      <col width="100">
      <col>
      <col>
      <col width="100">
      <col width="100">
      <col width="100">
      <col width="120">
    </colgroup>
    <thead>
      <tr>
        <th><input type="checkbox" class="allCheckIds" /></th>
        <th>번호</th>
        <th>코드</th>
        <th>이름[게시글수]</th>
        <th>댓글</th> 
        <th>좋아요</th> 
        <th>공개</th> 
        <th>관리</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="board" items="${boards}">
        <tr>
          <th><input type="checkbox" class="checkId" value="${board.id}"/></th>
          <th class="text-center">${board.id}</th>
          <td>
            <a href="/adm/board/detail?id=${board.id}"> 
              ${board.code}
            </a>
          </td>
          <td class="text-center">
            <a href="/usr/article/list?id=${board.id}"> 
              ${board.name}[${board.extra__articleCount}]
            </a>
          </td>
          <td class="text-center">${board.replyStatus == 1 ? "O":"X"}</td> 
          <td class="text-center">${board.reactionPointStatus == 1 ? "O":"X"}</td> 
          <td class="text-center">${board.publicStatus == 1 ? "O":"X"}</td> 
          <td>
            <div class="flex justify-center gap-1">
              <a href="/adm/board/modify?id=${board.id}" class="btn btn-xs btn-success">수정</a>
              <a href="" class="btn btn-xs btn-error">삭제</a>
            </div>
          </td>
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

<!--
<div class="mt-4">
  <button class="doDeleteBoardsBtn btn btn-xs btn-outline btn-error">선택삭제</button>
</div> -->    

<form hidden action="../board/doDelete" name="doDeletes" method="POST">
  <input type="hidden" name="ids" value=""/>
  <input type="hidden" name="replaceUri" value="${rq.getCurrentUri()}"/>
</form>

<script>
	$(".doDeleteBoardsBtn").click(() => {
		 const checkIdCheckedCount = $(".checkId:checked").length;
		 
		 if(checkIdCheckedCount == 0) {
			 alert("삭제할 게시판을 선택해주세요");
			 return false;
		 }
		 
		 if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		 }
		 
		const checked = $(".checkId:checked").map((i, el) => {
			return el.value
		}).get();
		
		$("input[name=ids]").val(checked.join());
		document["doDeletes"].submit();
	})
</script>

<!-- 페이지 관련 -->
<c:set var="pageRange" value="9" />
<c:set var="startPage"
  value="${page - pageRange >= 1 ? page - pageRange : 1}" />
<c:set var="endPage"
  value="${ startPage+pageRange <= pagesCount ? startPage+pageRange : pagesCount }" />

<c:set var="baseUri" value="?" />
<c:set var="baseUri"
  value="${baseUri}&itemsCountInAPage=${param.itemsCountInAPage}" />
<c:set var="baseUri"
  value="${baseUri}&searchKeywordType=${param.searchKeywordType}" />
<c:set var="baseUri"
  value="${baseUri}&searchKeyword=${param.searchKeyword}" /> 

<div class="flex justify-center mt-8">
  <div class="btn-group">
    <c:if test="${page != 1}">
      <a href="${baseUri}&page=1" class="btn btn-sm">«</a>
    </c:if>

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
      <a href="${baseUri}&page=${i}"
        class="btn btn-sm ${page == i ? 'btn-active' : '' }">${i}</a>
    </c:forEach>

    <c:if test="${page != pagesCount && pagesCount != 1 }">
      <a href="${baseUri}&page=${pagesCount}" class="btn btn-sm">»</a>
    </c:if>
  </div>
</div>


<%@ include file="../common/tail.jspf"%>