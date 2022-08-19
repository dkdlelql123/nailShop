<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 수정페이지" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../../common/toastUIEditerLib.jspf"%>
 
<script> 
  let submitModifyrFormDone = false;
  
  function article__submitForm(form){
  	if(submitModifyrFormDone){
  		alert("처리중입니다.");
  	}
  	
    const editor = $(form).find('.toast-ui-editor').data('data-toast-editor'); 
  	const markdown = editor.getMarkdown().trim(); 
  	 
    if (markdown.length < 2) {
  		alert("내용을 2글자 이상 작성해주세요.");
  		editor.focus(); 
  		return; 
    } 
    console.log(markdown);
    form.body.value = markdown; 
    console.log(form.body.value); 
  
  	form.submit();
  	submitModifyrFormDone = true;
  } 
</script>

<form class="table-box-type-1" action="/usr/article/doModify" onsubmit="article__submitForm(this); return false;" method="POST"> 
  <input type="hidden" name="id" value="${article.id}" readonly /> 
  <input type="hidden" name="body" value="" />
  
  <c:if test="${article.extra__actorCanEdit}">
    <div class="flex justify-end mb-4 gap-2">
      <button class="btn btn-info btn-sm" >저장</button>
    </div>
  </c:if>

  <table>
    <colgroup>
      <col width="200">
    </colgroup>
    <tr class="">
      <td>번호</td>
      <td>${article.id}</td>
    </tr>
    <tr>
        <td>카테고리</td>
        <td>
          <select name="boardId" id="boardCategory" class="select select-sm select-bordered" >
            <option>-선택해주세요-</option>
            <c:forEach var="board" items="${boards}">
              <c:choose>
                <c:when test="${board.id == article.boardId}"> 
                  <option value="${board.id}" data="cate${board.id}" selected >${board.name}</option>
                </c:when>
                <c:otherwise>
                  <option value="${board.id}" data="cate${board.id}">${board.name}</option>
                </c:otherwise>
              </c:choose>
              
            </c:forEach>
          </select>
        </td>
      </tr>
    <tr>
      <td>작성자</td>
      <td>${article.extra__writerName}</td>
    </tr>
    <tr>
      <td>작성일</td>
      <td>${article.forPrintType2RegDate}</td>
    </tr>
    <tr>
      <td>수정일</td>
      <td>${article.forPrintType2UpdateDate}</td>
    </tr> 
    <tr>
      <td>제목</td>
      <td>
        <input type="text" class="w-full input input-sm input-bordered" name="title" value="${article.title}" />
      </td>
    </tr>
  </table>
  <div class="toast-ui-editor">
      <script type="text/x-template">${article.body}</script>
  </div>   
</form>
 

<%@ include file="../common/tail.jspf"%>