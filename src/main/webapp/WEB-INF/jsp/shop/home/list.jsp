<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="pageTitle" value="홈" />
<%@ include file="../common/head.jspf"%>

<main class="py-6 px-4 sm:p-6 md:py-10 md:px-8">
  <div class="max-w-xl mx-auto grid grid-cols-1 lg:max-w-xl gap-y-10">
    <section>
      <h1 class="mt-1 font-semibold text-white sm:text-slate-900 text-2xl dark:sm:text-white">BEST</h1>
      <div class="flex flex-wrap mt-4"> 
         <c:forEach var="item" items="${bestList}">
           <div class="card bg-base-100 w-1/2 p-2">
             <a href="/shop/item/detail?id=<c:out value="${item.id}"/>" class="block">
              <span>
                <img 
                  src="${item.getShopItemImgUri()}"
                  onerror="${item.getShopItemFallbackImgOnErrorHtmlAttr()}"
                  alt="<c:out value="${item.extra__categoryName}"/>" 
                  />
              </span>
              <div class="mt-4">
                <h2 class="md:mb-2"> 
                  <span class="text-base"><c:out value="${item.name}" /></span>
                </h2>
                <p><fmt:formatNumber value="${item.price}" pattern="#,###"/></p> 
              </div>
            </a>
          </div> 
        </c:forEach>    
      </div>
    </section>
    
    <section>
      <h1 class="mt-1 font-semibold text-white sm:text-slate-900 text-2xl dark:sm:text-white">NEW</h1>
      <div class="flex flex-wrap mt-4"> 
         <c:forEach var="item" items="${newList}">
           <div class="card bg-base-100 w-1/2 p-2">
             <a href="/shop/item/detail?id=<c:out value="${item.id}"/>" class="block">
              <span>
                <img 
                  src="${item.getShopItemImgUri()}"
                  onerror="${item.getShopItemFallbackImgOnErrorHtmlAttr()}"
                  alt="<c:out value="${item.extra__categoryName}"/>" 
                  />
              </span>
              <div class="mt-4">
                <h2 class="md:mb-2"> 
                  <span class="text-base"><c:out value="${item.name}" /></span>
                </h2>
                <p><fmt:formatNumber value="${item.price}" pattern="#,###"/></p> 
              </div>
            </a>
          </div> 
        </c:forEach>  
    </section>
  </div>
</main>


<%@ include file="../common/tail.jspf"%>



