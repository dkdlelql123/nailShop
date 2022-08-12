<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 글쓰기" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../../common/toastUIEditerLib.jspf"%>

<c:set var="board_id" value="${param.boardId}" />
<input type="hidden" id="board_id" value="${board_id}" />

<script>
	let submitWriterFormDone = false;

	function article__submitForm(form) { 
		if (submitWriterFormDone) {
			alert("처리중입니다.");
			return;
		}
		
		form.boardId.value =form.boardId.value.trim(); 
		if(form.boardId.value == null || form.boardId.value <= 0){
			alert("새로고침후 이용해주세요.");
			return;
		} 
		   
	    if (form.title.value.length == 0) {
	      alert('제목을 입력해주세요.');
	      form.title.focus();
	      return;
	    }

	 	const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
	    const markdown = editor.getMarkdown().trim(); 
 
	    if (markdown.length < 10) {
			alert("내용을 10글자 이상 작성해주세요.");
			editor.focus();
			
			return; 
	    }
	    
	    form.body.value = markdown; 

		form.submit();
		submitWriterFormDone = true;
	}

	$(function() { 
		const boardId = $("#board_id").val();
		$("#boardCategory option[data=cate" + boardId + "]").prop("selected",true);
		
	});
</script>


<div>
  <form onsubmit="article__submitForm(this); return false;"
    class="table-box-type-1" action="/usr/article/doWrite" method="POST">
    <input type="hidden" name="memberId" value="${rq.loginedMemberId}" />
    <input type="hidden" name="body" />

    <table >
       <colgroup>
          <col width="200" />
        </colgroup>
      <tr style="width:200px">
        <th>작성자</th>
        <td>
          <input type="text" class="w-full input input-sm"
            value="${rq.member.nickname}" readonly />
        </td>
      </tr>
      <tr>
        <th>카테고리</th>
        <td>
          <select name="boardId" id="boardCategory"
            class="select select-sm select-bordered ">
            <option disabled >-선택해주세요-</option>
            <c:forEach var="board" items="${boards}">
              <option value="${board.id}" data="cate${board.id}">${board.name}</option>
            </c:forEach>
          </select>
        </td>
      </tr>
      <tr>
        <th>제목</th>
        <td>
          <input type="text" class="w-full input input-sm input-bordered" name="title"  
            required="required" placeholder="제목을 입력해주세요." />
        </td>
      </tr> 
    </table>
    <div class="toast-ui-editor">
        <script type="text/x-template"></script>
    </div>  

    <div class="flex justify-end mt-4">
      <button type="submit" class="btn btn-info btn-sm">작성하기</button>
    </div>
  </form>
</div>

<%@ include file="../common/tail.jspf"%>
