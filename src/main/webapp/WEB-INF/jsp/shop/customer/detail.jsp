<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="고객목록" />
<%@ include file="../common/head.jspf"%>

<main class="py-6 px-4 sm:p-6 md:py-10 md:px-8">
  <div class="max-w-xl mx-auto grid grid-cols-1 lg:max-w-xl lg:gap-y-10">
    <section>
      <h1
        class="mt-1 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">
        고객
        <c:out value="${customerCnt}" />명
      </h1>

      <ul class="divide-y mt-4">
        <c:forEach var="customer" items="${customers}">
          <li class="py-3 sm:py-4">
            <a href="/shop/customer/detail?customerId=<c:out value="${customer.id}"/>">
              <div class="flex items-center space-x-4">
                <div class="flex-shrink-0">
                  <img class="w-8 h-8 rounded-full" src="https://placeimg.com/60/60/arch" alt="Neil image">
                </div>
                <div class="flex-1 min-w-0">
                  <p class="text-sm font-medium truncate "><c:out value="${customer.name}" />(<c:out value="${customer.phoneNumber}" />)</p>
                  <p class="text-sm truncate">-</p>
                </div>
                <div class="inline-flex items-center text-base font-semibold">
                  $320
                </div>
              </div>
              </a>
          </li>
        </c:forEach> 
       </ul>
    </section>
  </div>
</main>


<div data-dial-init class="fixed right-6 bottom-14 group">
  <a href="/shop/customer/join"
    class="flex justify-center items-center w-12 h-12 text-white bg-primary rounded-full focus:ring-4 focus:outline-none"
    title="고객등록">
    <svg aria-hidden="true"
      class="w-6 h-6 transition-transform group-hover:rotate-45"
      fill="none" stroke="currentColor" viewBox="0 0 24 24"
      xmlns="http://www.w3.org/2000/svg">
      <path stroke-linecap="round" stroke-linejoin="round"
        stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
    <span class="sr-only">Open actions menu</span>
  </a>
</div>


<%@ include file="../common/tail.jspf"%>



