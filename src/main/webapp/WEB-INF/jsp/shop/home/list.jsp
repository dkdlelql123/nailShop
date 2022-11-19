<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="홈" />
<%@ include file="../common/head.jspf"%>

<main class="py-6 px-4 sm:p-6 md:py-10 md:px-8">
  <div class="max-w-xl mx-auto grid grid-cols-1 lg:max-w-xl lg:gap-y-10">
    <section>
      <h1 class="mt-1 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">BEST</h1>
      <div class="flex flex-wrap mt-4">
        <div class="card bg-base-100 w-1/2 p-2  ">
          <figure>
            <img src="https://placeimg.com/400/225/arch" alt="Shoes" />
          </figure>
          <div class="mt-4">
            <h2 class="card-title">
              Shoes!
              <div class="badge badge-secondary">NEW</div>
            </h2>
            <p>If a dog chews shoes whose shoes does he choose?</p>
            <div class="card-actions justify-end">
              <div class="badge badge-outline">Fashion</div>
              <div class="badge badge-outline">Products</div>
            </div>
          </div>
        </div>
        <div class="card bg-base-100 w-1/2 p-2 ">
          <figure>
            <img src="https://placeimg.com/400/225/arch" alt="Shoes" />
          </figure>
          <div class="mt-4">
            <h2 class="card-title">
              Shoes!
              <div class="badge badge-secondary">NEW</div>
            </h2>
            <p>If a dog chews shoes whose shoes does he choose?</p>
            <div class="card-actions justify-end">
              <div class="badge badge-outline">Fashion</div>
              <div class="badge badge-outline">Products</div>
            </div>
          </div>
        </div>
        <div class="card bg-base-100 w-1/2 p-2 ">
          <figure>
            <img src="https://placeimg.com/400/225/arch" alt="Shoes" />
          </figure>
          <div class="mt-4">
            <h2 class="card-title">
              Shoes!
              <div class="badge badge-secondary">NEW</div>
            </h2>
            <p>If a dog chews shoes whose shoes does he choose?</p>
            <div class="card-actions justify-end">
              <div class="badge badge-outline">Fashion</div>
              <div class="badge badge-outline">Products</div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section>
      <h1
        class="mt-1 text-lg font-semibold text-white sm:text-slate-900 md:text-2xl dark:sm:text-white">NEW</h1>
    </section>
  </div>
</main>


<%@ include file="../common/tail.jspf"%>



