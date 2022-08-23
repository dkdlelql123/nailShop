<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 홈" />
<%@ include file="../common/head.jspf"%>

<div class="flex flex-col gap-4">
  <div class="bg-base-300 w-full rounded-box p-6 flex gap-4 stats-horizontal">
    <div class="w-1/3">
      <p class="text-xl font-bold text-primary uppercase mb-4">yesterday</p>
      <p class="text-2xl font-bold">${yesterday}</p>
    </div>
    <div class="w-1/3  pl-6">
      <p class="text-xl font-bold text-info mb-4 uppercase">today</p>
      <p class="text-2xl font-bold">${today}</p>
    </div>
    <div class="w-1/3  pl-6">
      <p class="text-xl font-bold text-success mb-4 uppercase">total</p>
      <p class="text-2xl font-bold">${total}</p>
    </div>
  </div>
  
  <div class="flex gap-4">
    <div class="bg-base-300 w-1/2 rounded-box p-6">
      <h3 class="text-xl font-bold mb-4">
        NEW 게시글📃
        <a class="float-right" href="/adm/article/list"><i class="fas fa-chevron-right"></i></a>
      </h3>
      <ul class="flex flex-col gap-2">
        <c:forEach var="article" items="${articleList}">
        <li>
          <a class="flex items-center" href="/usr/article/detail?id=${article.id}">
            <span class="title_text text-md flex-grow">${article.title}</span>
            <span class="text-sm text-base-content/70">${article.forPrintType1RegDate}</span>
          </a>
        </li>
        </c:forEach>
      </ul>
    </div>
     
    
    <div class="bg-base-300 w-1/2 rounded-box p-6">
      <h3 class="text-xl font-bold mb-4">
        NEW 회원😁
        <a class="float-right" href="/adm/member/list"><i class="fas fa-chevron-right"></i></a>
      </h3>
      <ul class="flex flex-col gap-2">
        <c:forEach var="member" items="${memberList}">
        <li>
          <a class="flex items-center" href="/adm/member/detail?id=${member.id}" >
            <span class="title_text text-md flex-grow">${member.loginId}(${member.name})</span> 
            <span class="title_text text-md">${member.nickname}</span>
            <span class="text-sm text-base-content/70 ml-2">${member.forPrintType1RegDate}</span>
          </a>
        </li>
        </c:forEach>
      </ul>
    </div>
  </div>
  
</div>

<%@ include file="../common/tail.jspf"%>