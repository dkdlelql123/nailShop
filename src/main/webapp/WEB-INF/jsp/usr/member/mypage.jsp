<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.nyj.exam.demo.util.Ut"%>

<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../common/head.jspf"%>

<div class="table-box-type-1 m-auto w-full lg:w-2/3">
  <h1 class="text-3xl font-bold text-center">내정보</h1>

  <div class="flex grid templete-row-3">
    <section class="flex gap-2 flex-col mt-20 text-center border rounded py-6">
      <div>
        😁 <span class="text-2xl font-bold">${member.loginId}</span>
        <span>(${member.nickname})</span>
      </div>
      <p>
        <span>🧍${member.name}</span>
        <a
          href="/usr/member/checkPassword?replaceUri=${Ut.getUriEncoded('../member/modify')}"
          class="btn btn-xs btn-primary btn-outline text-center ml-2"> 정보수정하기 </a>
      </p>
      <p class="text-base-content/70">📧 ${member.email} &nbsp; 📞${member.phoneNumber}</p> 
    </section>
    <section class="mt-20">
      <h2 class="text-2xl font-extrabold mb-4">내가 작성한 게시물</h2>
      <ul class="flex gap-2 flex-col">
        <c:forEach var="article"  items="${articleList}" >
          <li class="border p-2 flex rounded">
            <span class="flex-grow">${article.title}</span>
            <span class="text-base-content/70">${article.forPrintType2RegDate}</span>
          </li>
        </c:forEach>
        <c:if test="${articleList.size() == 0}">
        <div class="border p-2">작성된 게시물이 없습니다.</div>
        </c:if>
      </ul>
    </section>
    <section class="mt-20">
      <h2 class="text-2xl font-extrabold mb-4">내가 작성한 댓글</h2>

    </section>
  </div> 
</div>

<%@ include file="../common/tail.jspf"%>
