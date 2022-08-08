<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시글관리" />
<%@ include file="../common/head.jspf"%>

<c:set var="authLevel" value="${param.searchAuthLevel}" />
<input type="hidden" id="authLevel" name="authLevel"
  value="${authLevel}" />

<script>
	// 검색조건 - 회원레벨체크
	let authLevel = $('input#authLevel').val();
	if (authLevel <= 0 || !authLevel)
		authLevel = 1;

	function init() {
		$("input[name=searchAutoLevel]").prop('checked', false);
	}
	init();

	$(function() {
		$("input[data-name=userType" + authLevel + "]").prop('checked',	true);
		$("input[data-name=userType" + authLevel + "] ~ span").removeClass("btn-outline");
	})
</script>


<h1 class="font-title mb-4 text-3xl font-extrabold">회원 총 ${membersCount}명</h1>
<div class="form-control">
  <form class="input-group justify-center" name="search-form">
    <input type="hidden" name="searchAuthLevel"
      value="${param.searchAuthLevel}" />
    <input type="hidden" name="itemsCountInAPage"
      value="${param.itemsCountInAPage}" />
    <select id="select" name="searchKeywordType"
      data-value="${param.searchKeywordType}"
      class="select select-md select-bordered border-r-0 rounded-r-none"
      style="border-bottom-right-radius: 0px; border-top-right-radius: 0px; font-weight: normal">
      <option value="loginId" selected>아이디</option>
      <option value="name">이름</option>
      <option value="nickname">별명</option>
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
      <input type="hidden" name="searchAuthLevel"
        value="${param.searchAuthLevel}" />
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
    <form>
      <input type="hidden" name="searchKeywordType"
        value="${param.searchKeywordType}" />
      <input type="hidden" name="searchKeyword"
        value="${param.searchKeyword}" />
      <input type="hidden" name="itemsCountInAPage"
        value="${param.itemsCountInAPage}" />

      <label for="AuthLevel1" onchange="this.form.submit();">
        <input type="radio" class="hidden" id="AuthLevel1"
          data-name="userType1" name="searchAuthLevel" value="1" />
        <span class="btn btn-sm btn-outline">전체</span>
      </label>

      <label for="AuthLevel2" onchange="this.form.submit();">
        <input type="radio" class="hidden" id="AuthLevel2"
          data-name="userType2" name="searchAuthLevel" value="2" />
        <span class="btn btn-sm btn-outline">일반회원</span>
      </label>

      <label for="AuthLevel3" onchange="this.form.submit();">
        <input type="radio" class="hidden" id="AuthLevel3"
          data-name="userType10" name="searchAuthLevel" value="10" />
        <span class="btn btn-sm btn-outline">관리자</span>
      </label>
    </form>
  </div>
</div>


<div class="table-box-type-1">
  <table id="boardtable">
    <colgroup>
      <col width="45">
      <col width="100">
      <col width="200">
    </colgroup>
    <thead>
      <tr>
        <th><input type="checkbox" class="allCheckMemberIds" /></th>
        <th>번호</th>
        <th>아이디</th>
        <th>이름</th>
        <th>별명</th>
        <th>이메일</th>
        <th>가입일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="member" items="${members}">
        <tr>
          <th><input type="checkbox" class="checkMemberId" value="${member.id}"/></th>
          <th class="text-center">${member.id}</th>
          <td>
            <a href="/adm/member/detail?id=${member.id}">
            <c:if test="${member.delStatus == 1}">
              <div class='btn btn-xs btn-error btn-outline mr-2'>탈퇴회원</div>
            </c:if>
            ${member.loginId}
            </a>
          </td>
          <td class="text-center">${member.name}</td>
          <td class="text-center">${member.nickname}</td>
          <td class="text-center">${member.email}</td>
          <td class="text-center">${member.forPrintType1RegDate}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<script>
$(".allCheckMemberIds").change(function(){
    const $this = $(this);
    const checkedStatus = $this.prop("checked");
    
    $(".checkMemberId").prop("checked",checkedStatus );
  });
  
  $(".checkMemberId").change(function(){
    const checkMemberIdCount = $(".checkMemberId").length;
    const checkMemberIdCheckedCount = $(".checkMemberId:checked").length;
    
    const allCheck = checkMemberIdCount == checkMemberIdCheckedCount ;
    
    $(".allCheckMemberIds").prop("checked", allCheck);
  }); 
</script>

<div class="mt-4">
  <button class="doDeleteMembersBtn btn btn-xs btn-outline btn-error">선택삭제</button>
</div>    

<form hidden action="../members/doDelete" name="doDeleteMembers" method="POST">
  <input type="hidden" name="ids" value=""/>
  <input type="hidden" name="replaceUri" value="${rq.getCurrentUri()}"/>
</form>

<script>
	$(".doDeleteMembersBtn").click(() => {
		 const checkMemberIdCheckedCount = $(".checkMemberId:checked").length;
		 
		 if(checkMemberIdCheckedCount == 0) {
			 alert("삭제할 회원을 선택해주세요");
			 return false;
		 }
		 
		 if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		 }
		 
		const checkedMembers = $(".checkMemberId:checked").map((i, el) => {
			return el.value
		}).get();
		
		$("input[name=ids]").val(checkedMembers.join());
		document["doDeleteMembers"].submit();
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
<c:set var="baseUri"
  value="${baseUri}&searchAuthLevel=${param.searchAuthLevel}" />

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