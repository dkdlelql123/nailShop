<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="main" value="true" />
<c:set var="pageTitle" value="홈" />
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

<!--  text-base-content glass xl:rounded-box -mt-48 grid max-w-screen-xl gap-4 bg-opacity-60 xl:pb-0 -->
<section>
  <h2 class="text-4xl font-extrabold mb-2">BEST</h2>
  <div class="mx-auto grid md:grid-cols-3 grid-cols-1 gap-4">
  <c:forEach var="article" items="${bestArticles}">
    <a class="card card-compact bg-base-200 border shadow-sm" href="/usr/article/detail?id=${article.id}">
      <div class="card-body">
         <h2 class="card-title flex-col" style="align-items:flex-start">
            <span class="badge badge-outline font-normal py-2">${article.extra__boardName}</span>
            <span class="title_text text-lg font-semibold">${article.title}</span>
         </h2>       
         <p class="text-sm mt-4">${article.extra__writerName} | ${article.getForPrintType1RegDate()}</p>
      </div>
    </a>
  </c:forEach>
  </div>
</section>


<section class="mt-12">
  <h2 class="text-4xl font-extrabold mb-2">NEW</h2> 
  <div class="mx-auto grid md:grid-cols-3 grid-cols-1 gap-4">
  <c:forEach var="article" items="${newArticles}">
    <a class="card card-compact bg-base-200 border shadow-sm" href="/usr/article/detail?id=${article.id}">
      <div class="card-body">
         <h2 class="card-title flex-col" style="align-items:flex-start">
            <span class="badge badge-outline font-normal py-2">${article.extra__boardName}</span>
            <span class="title_text text-lg font-semibold">${article.title}</span>
         </h2>       
         <p class="text-sm mt-4">${article.extra__writerName} | ${article.getForPrintType1RegDate()}</p>
      </div>
    </a>
  </c:forEach>
  </div>
</section>

<%@ include file="../common/tail.jspf"%>