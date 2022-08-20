<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.nyj.exam.demo.util.Ut" %>

<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../common/head.jspf"%>

<div class="table-box-type-1 m-auto w-full lg:w-1/2">
  <h1 class="text-3xl font-bold text-center">내정보</h1>
  
  <div class="mt-8 mb-4">
    <label for="loginId" class="block mb-2 text-sm font-medium ">아이디</label>
    <input 
      type="text"  
      id="loginId"
      class="block p-2 w-full cursor-not-allowed input input-sm input-bordered rounded-lg sm:text-xs"
      value="${member.loginId}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="name" class="block mb-2 text-sm font-medium label-text">이름</label>
    <input 
      type="text"  
      id="name"
      class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
      value="${member.name}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="email" class="block mb-2 text-sm font-medium label-text">이메일</label>
    <input 
      type="text"  
      id="email"
      class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
      value="${member.email}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="nick" class="block mb-2 text-sm font-medium label-text">별명</label>
    <input 
      type="text"  
      id="nick"
      class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
      value="${member.nickname}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="tel" class="block mb-2 text-sm font-medium label-text">전화번호</label>
    <input 
      type="text"  
      id="tel"
      class="block p-2 w-full input input-sm input-bordered rounded-lg sm:text-sm"
      value="${member.phoneNumber}"
      readonly disabled
    />
  </div>  
  <a 
    href="/usr/member/checkPassword?replaceUri=${Ut.getUriEncoded('../member/modify')}" 
    class="w-full btn btn-primary mt-4 text-center">
    정보수정하기
  </a>
</div>

<%@ include file="../common/tail.jspf"%>
