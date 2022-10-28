<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세페이지" />
<%@ include file="../common/head.jspf"%> 

<%@ include file="../../common/toastUIEditerLib.jspf"%>
<input type="hidden" name="articleId" value="${param.id}" />

<script> 
	// 게시물 조회수 시간계산
    let today =  Date.now()   			//오늘날짜
    let date = new Date();  
    date.setDate(date.getDate() + 1);  	// 내일날짜
    date.setHours(0,0,0,0);  			// 시, 분, 초, 밀리 - 내일날짜 중 시간은 초기화
    let tomorrow = date.getTime(); 
    //console.log("today "+today+", tomorrow "+ tomorrow);

	// 게시물 조회수 처리 함수
	let articleId = $("input[name='articleId']").val();
	articleId = parseInt(articleId);
	
	function setItemWithExpireTime(keyName, keyValue) {  
		const obj = {   
		 	value : keyValue,  
		 	expire : tomorrow //Date.now() + tts 
		} 
		// 객체를 JSON 문자열로 변환 
		const objString = JSON.stringify(obj);   
		
		// setItem 
		localStorage.setItem(keyName, objString);
	} 

	/** 게시물 조회수 */
	function ArticleDetail__increaseHitCount() { 
		const localStorageKey = "article__" + articleId + "__viewDone"; 
	 
		const objString = localStorage.getItem(localStorageKey);
		if (objString) { 			
			const obj = JSON.parse(objString);
			
			if(Date.now() >= obj.expire || !obj.expire )
				localStorage.removeItem(localStorageKey);
			else 
				return; 
		} 
		setItemWithExpireTime(localStorageKey, true); 

		$.ajax({
			url : '/usr/article/increaseHitCount?id=' + articleId,
			success : function(data) { 
				if(data.resultCode.substr(0,1) == "S"){
    				$(".articleHit").html(data.data1);
    				$("#today").html(data.data2.data1);
    				$("#total").html(data.data2.data2);
				}
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
	
	ArticleDetail__increaseHitCount();

	// 댓글 작성하기 	
	let submitReplyDone = false;
	function checkReplyForm(form) { 
		if (submitReplyDone) {
			alert("처리중입니다.");
			return;
		}

		let body = form.body.value.trim(); 
		if (body.length <= 2) {
			alert("댓글은 두글자 이상 입력이 가능합니다.");
			$("#replyBody").focus();
			return;
		} 
 
		let writer = form.writer.value.trim(); 
		if (writer.length < 1) {
			alert("이름을 입력해주세요");
			form.writer.focus();
			return;
		} 
		
		let pw = form.pw.value.trim(); 
		if (pw.length < 1) {
			alert("비밀번호를 입력해주세요.");
			form.pw.focus();
			return;
		}   

		form.submit();
		submitReplyDone = true;
	}
	
	async function checkReplyPw(form){       
      let replyId = form.id.value.trim();
      if(replyId == null | replyId <= 0){
      	alert("새로고침 후 다시 시도해주세요.");
      	return;
      } 
      
      let pw = form.pw.value.trim(); 
      if (pw.length < 1) {
      	alert("비밀번호를 입력해주세요.");
      	form.pw.focus();
      	return;
      } 

      $("#reply-pwCheck button").addClass("loading");
      let data = { 
      	"id" : replyId,
      	"pw" : pw,
      }; 
      let dataType = form.dataType.value.trim();
      
      $.ajax({
    	url :'/usr/reply/doCheckPw', 
    	data : data,
    	method: 'POST',
    	success : function(res){ 
    		if(res.success){
        	  	$("#my-modal-5").prop("checked", false)
                if(dataType == "delete")
                	deleteReply(replyId)
                else
              		$("#my-modal-6").prop("checked", true)
            } else {
            	  $(".status").html('<p class="text-error p-2">'+res.msg+'</p>');
            }
    	},error : function(err){
    		console.log(err)
    	},complete: function(){ 
          $("#reply-pwCheck button").removeClass("loading");
      	  form.pw.value = "";
    	}
      })  
	}
	
	function deleteReply(id){ 
		location.replace("/usr/reply/doDelete?id=" + id) 
	}

	$(document).on('click', 'label[data-type]', function(e) {
		$(".status").html(''); 
		
		$('div[id^=reply-] input.id').val(e.target.dataset.id);
		$('#reply-pwCheck input.dataType').val(e.target.dataset.type);
		$('#reply-modify textarea').val(e.target.dataset.body);
	})
</script>

<div class="flex justify-between mb-4">
  <div>
    <c:choose>
      <c:when test="${article.extra__publicStatus == 0}">
        <!-- 없음 -->
      </c:when>
      <c:when test="${empty param.listUri}">
        <a href="/usr/article/list?boardId=${article.boardId}" class="btn btn-sm btn-outline" >목록</a>
      </c:when>
      <c:otherwise>
        <a class="btn btn-sm" href="${param.listUri}">목록</a>
      </c:otherwise>
    </c:choose> 
  </div>

  <c:if test="${article.extra__actorCanEdit}">
    <div class="flex justify-end gap-2">
      <a href="/usr/article/modify?id=${article.id}"
        class="btn btn-info btn-sm">수정</a>
      <a href="/usr/article/doDelete?id=${article.id}"
        onclick="if( confirm('삭제하시겠습니까?') == false) return false; "
        class="btn btn-error btn-sm"> 삭제</a>
    </div>
  </c:if>
</div>

<div>
  <div class="text-center">
    <h4 class="text-sm text-base-content/70 mb-2">${article.extra__boardName}</h4>
    <h1 class="text-3xl font-bold mb-4">${article.title}</h1>
    <div class="text-sm text-base-content/70 pb-8 mb-8 border-b border-gray-400 flex items-center justify-center">
    
      <div class="mask mask-squircle bg-base-content h-8 w-8 bg-opacity-10 p-px mx-2">
        <img  src="${article.getWriterProfileImgUri()}" 
              onerror="${article.getWriterProfileFallbackImgOnErrorHtmlAttr()}" 
              width="44" height="44" alt="member img" class="mask mask-squircle" />
      </div>
      <span>작성자 ${article.extra__writerName} | </span>
      <span>${article.forPrintType2RegDate}</span>
      <c:if test="${article.extra__reactionPointStatus == 1}"> 
      <div class="flex gap-2 items-center justify-center mt-2">
        <span class="goodReactionPoint">👍 ${article.goodReactionPoint}</span>
        <c:if test="${actorCanMakeReactionPoint}">
          <a
            href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
            class="btn btn-xs btn-success btn-outline">좋아요👍</a>
          <a
            href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
            class="btn btn-xs btn-outline btn-secondary">싫어요👎</a>
        </c:if>

        <c:if test="${actorCanMakeCancleGoodReactionPoint}">
          <a
            href="/usr/reactionPoint/doCancleReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}&cancleReaction=good"
            class="btn btn-xs btn-success">좋아요👍</a>
          <a href="#" onclick="alert(this.title); return false;"
            title="좋아요를 취소해주세요"
            class="btn btn-xs btn-secondary btn-outline">싫어요👎</a>
        </c:if>

        <c:if test="${actorCanMakeCancleBadReactionPoint}">
          <a href="#" onclick="alert(this.title); return false;"
            title="싫어요를 취소해주세요"
            class="btn btn-xs btn-success btn-outline">좋아요👍</a>
          <a
            href="/usr/reactionPoint/doCancleReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}&cancleReaction=bad"
            class="btn btn-xs btn-secondary">싫어요👎</a>
        </c:if>
      </div> 
    </c:if> 
    </div>
  </div>
  <div style="min-height:33vh">
    <div class="toast-ui-viewer">
      <script type="text/x-template">
		${article.body}
	  </script>
    </div> 
  </div> 
</div> 

<c:if test="${article.extra__replyStatus == 1}"> 
<div class="py-8">
  <h4 class="py-2 border-b border-gray-400">💬 댓글 ${replyCount}개</h4>
  <table>
    <c:if test='${replyCount == 0}'>
      <div class="py-2">댓글이 없습니다.</div>
    </c:if>
    <c:forEach var="reply" items='${replies}'>
      <tr>
        <div class="flex flex-wrap gap-2 items-center py-2 border-b border-gray-200">
          <p>${reply.body}</p> 
          <c:if test="${article.extra__reactionPointStatus== 1}">
            <c:if test="${reply.extra__reactionStatus == ''}">
              <a
                href="/usr/reactionPoint/doGoodReaction?relId=${reply.id}&relTypeCode=reply&replaceUri=${rq.getEncodedCurrentUri()}"
                class="btn btn-xs btn-success btn-outline">${reply.goodReactionPoint}👍</a>
              <a
                href="/usr/reactionPoint/doBadReaction?relId=${reply.id}&relTypeCode=reply&replaceUri=${rq.getEncodedCurrentUri()}"
                class="btn btn-xs btn-secondary btn-outline">${reply.badReactionPoint}👎</a>
            </c:if>
            <c:if test="${reply.extra__reactionStatus == 'good'}">
              <a
                href="/usr/reactionPoint/doCancleReaction?relId=${reply.id}&relTypeCode=reply&replaceUri=${rq.getEncodedCurrentUri()}&cancleReaction=good"
                class="btn btn-xs btn-success">${reply.goodReactionPoint}👍</a>
              <a
                href="#" title="좋아요를 취소해주세요"
                onClick="alert(this.title); return false;"
                class="btn btn-xs btn-secondary btn-outline">${reply.badReactionPoint}👎</a>
            </c:if>
            <c:if test="${reply.extra__reactionStatus == 'bad'}">
              <a
                href="#" title="싫어요를 취소해주세요"
                onClick="alert(this.title); return false;"
                class="btn btn-xs btn-success btn-outline">${reply.goodReactionPoint}👍</a>
              <a
                href="/usr/reactionPoint/doCancleReaction?relId=${reply.id}&relTypeCode=reply&replaceUri=${rq.getEncodedCurrentUri()}&cancleReaction=bad"
                class="btn btn-xs btn-secondary ">${reply.badReactionPoint}👎</a>
            </c:if>
          </c:if>

          <span class="text-xs text-gray-500">${reply.extra__writerName}${reply.writer}</span>
          <span class="text-xs text-gray-500">${reply.forPrintType1RegDate}</span> 
          <label for="my-modal-5"
            class="text-xs underline cursor-pointer" data-id="${reply.id}" data-type="modify"
            data-body="${reply.body}">수정</label>
          <label for="my-modal-5"
            class="text-xs underline cursor-pointer" data-id="${reply.id}" data-type="delete"
            data-body="${reply.body}">삭제</label> 
          <c:if test="${reply.regDate != reply.updateDate}">
            <span class="text-xs text-gray-500">
              ${reply.forPrintType2UpdateDate} 에 수정됨
            </span>
          </c:if>
        </div>
      </tr>
    </c:forEach>
  </table> 
 
  <form id="nonMemberReplyForm" action="/usr/reply/doWrite?replaceUri=${rq.encodedCurrentUri}" method="post" class="mt-8" onsubmit="checkReplyForm(this); return false;">
    <input type="hidden" name="id" value="${article.id}" />
    <div class="flex flex-col gap-2 justify-bewteen items-end">
      <textarea id="replyBody" name="body" cols="30" rows="3" class="textarea textarea-bordered w-full" placeholder="내용을 입력해주세요" required></textarea>
      <div class="w-full flex flex-wrap gap-2 flex-col sm:flex-row">
          <input type="text" name="writer" placeholder="작성자명"  class="input input-sm input-bordered" value="${rq.member.nickname}" required />
          <input type="password" name="pw" placeholder="비밀번호" class="input input-sm input-bordered" autocomplete="false"  required/>        
          <button type="submit" class="btn btn-sm btn-outline">입력</button>
      </div>
    </div>
  </form> 
</div>

<input type="checkbox" id="my-modal-5" class="modal-toggle" />
<div id="reply-pwCheck" class="modal sm:modal-bottom modal-middle">
  <div class="modal-box">
    <div class="flex justify-between items-center">
      <h3 class="font-bold text-lg">비밀번호 확인</h3>
      <label for="my-modal-5" class="cursor-pointer p-2 font-lg text-lg">
        <i class="fas fa-times"></i>
      </label>
    </div>
    <form class="mt-2" onsubmit="checkReplyPw(this); return false;">
      <input type="hidden" name="id" class="id" value="" />
      <input type="hidden" name="dataType" class="dataType" value="" />
      <input type="password" name="pw" class="input input-sm input-bordered" autocomplete="false" placeholder="비밀번호" /> 
      <p class="status"></p>
      <button type="submit" class="btn btn-sm btn-info float-right">확인</button>
    </form>
  </div>
</div>  

<!-- 댓글 수정 모달-->
<input type="checkbox" id="my-modal-6" class="modal-toggle" />
<div id="reply-modify" class="modal sm:modal-bottom modal-middle">
  <div class="modal-box">
    <div class="flex justify-between items-center">
      <h3 class="font-bold text-lg">댓글 수정</h3>
      <label for="my-modal-6" class="cursor-pointer p-2 font-lg text-lg">
        <i class="fas fa-times"></i>
      </label>
    </div>
    <form
      action="/usr/reply/doModify?replaceUri=${rq.encodedCurrentUri}"
      method="post" 
      class="mt-2"
      onsubmit="checkReplyForm(this); return false;">
      <input type="hidden" name="id" class="id" value="" />
      <textarea name="body" cols="30" rows="5" class="textarea textarea-bordered  w-full p-2"></textarea>
      <button type="submit" class="btn btn-sm btn-info float-right">수정</button>
    </form>
  </div>
</div>  
</c:if>

<%@ include file="../common/tail.jspf"%>
