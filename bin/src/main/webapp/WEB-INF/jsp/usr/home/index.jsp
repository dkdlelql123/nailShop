<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="main" value="true" />
<c:set var="pageTitle" value="blog 만들기💓" />
<%@ include file="../common/head.jspf"%>

<style>
  .title_text{
    display:-webkit-box;
    overflow: hidden;
    text-overflow: ellipsis;
    word-break: break-word;
    line-height: 150%;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
  }
</style>

<script> 
function check__searchFrom(form){ 
	form.searchKeyword.vaule = form.searchKeyword.vaule.trim(); 
	
	if(form.searchKeyword.vaule.length < 0){
		form.searchKeyword.focus();
		return;
	}
	
	form.submit(); 
}
</script>


<section class="mt-12 lg:mt-0">
  <h2 class="hidden">전체검색</h2>
  <form action="/usr/article/searchList" method="get" onsubmit="check__searchFrom(this); return false; ">
    <div class="form-control ">
      <div class="input-group input-group-lg justify-center border border-primary rounded-full sm:border-0" >
        <input 
        type="search" 
        name="searchKeyword"
        class="input input-md md:input-lg input-primary w-11/12 md:w-1/3 focus:z-10 focus:outline-none appearance-none border-0 sm:border my-1 sm:my-0 "
        placeholder="Search…"  /> 
        <button type="submit" class="btn btn-primary btn-md hidden md:btn-lg sm:inline">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </button>
      </div>
    </div> 
  </form> 
</section>

<section class="mt-20">
  <h2 class="text-3xl font-extrabold mb-4">NEW</h2> 
  <div class="mx-auto grid md:grid-cols-3 grid-cols-1 gap-6">
  <c:forEach var="article" items="${newArticles}">
    <a class="card card-compact border shadow-sm" href="/usr/article/detail?id=${article.id}">
      <div class="card-body">
         <h2 class="card-title"> 
            <span class="title_text text-lg font-semibold">${article.title}</span>
         </h2>       
         <p class="text-base-content/70"><c:out value='${fn:substring(article.body.replaceAll("\\\<.*?\\\>",""),0,30)}' />..</p>
         <p class="text-xs text-base-content/70">
         조회 ${article.hit} | ${article.getForPrintType1RegDate()} | ${article.extra__boardName}
         </p>
      </div>
    </a>
  </c:forEach>
     <div class="card card-compact border shadow-sm flex-column items-center justify-center flex-stretch bg-yellow-100">
        <div class="text-gray-900">🌷놀러와주셔서 감사합니다🌷</div>
    </div>
  </div>
</section>


<%@ include file="../common/tail.jspf"%>