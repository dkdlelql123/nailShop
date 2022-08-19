<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.nyj.exam.demo.util.Ut" %>

<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../common/head.jspf"%>

<div class="table-box-type-1 m-auto w-full lg:w-1/2">
  <h1 class="text-3xl font-bold text-center">내정보</h1>
  
  <div class="mt-8 mb-4">
    <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">아이디</label>
    <input 
      type="text"  
      class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      value="${member.loginId}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">이름</label>
    <input 
      type="text"  
      class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      value="${member.name}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">이메일</label>
    <input 
      type="text"  
      class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      value="${member.email}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">별명</label>
    <input 
      type="text"  
      class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      value="${member.nickname}"
      readonly disabled
    />
  </div>
  <div class="mb-4">
    <label for="small-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">전화번호</label>
    <input 
      type="text"  
      class="block p-2 w-full text-gray-900 bg-gray-50 rounded-lg border border-gray-300 sm:text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
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
