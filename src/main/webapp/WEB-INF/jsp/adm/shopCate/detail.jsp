<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="관리자 - 게시판상세" />
<%@ include file="../common/head.jspf"%> 

<h1 class="font-title mb-8 text-3xl font-extrabold">게시판 상세</h1>
<div class="table-box-type-1">
    <table>
      <colgroup>
        <col width="200" />
        <col/>
        <col width="200" />
        <col/>
      </colgroup>
       <tr>
        <th>번호</th>
        <td colspan="3">
          ${board.id}
        </td>
       </tr>

       <tr>
        <th>생성일자</th>
        <td>
          ${board.forPrintType1RegData} 
        </td>
        <th>수정일자</th>
        <td>
          ${board.forPrintType1UpdateData}
        </td>
      </tr>

      <tr>
        <th>이름</th>
        <td colspan="3">
            <a href="#" >${board.name}[${board.extra__articleCount}]</a>
        </td>
      </tr> 

      <tr>
        <th>코드</th>
        <td colspan="3">
            ${board.code}
        </td>
      </tr> 
      <tr>
        <th>링크</th>
        <td colspan="3">
            ${board.link != null ? board.link: "-"}
        </td>
      </tr>
      <tr>
        <th>댓글 기능</th>
        <td colspan="3">
           ${board.replyStatus == 1 ? "사용" : "미사용"}
        </td>
      </tr> 
      <tr>
        <th>좋아요 기능</th>
        <td colspan="3">
           ${board.reactionPointStatus == 1 ? "사용" : "미사용"}
        </td>
      </tr> 
       <tr>
        <th>공개여부</th>
        <td colspan="3">
           ${board.publicStatus == 1 ? "공개" : "미공개"}
        </td>
      </tr> 
    </table>
     
    <div class="flex justify-end mt-4 gap-2">
      <a href="/adm/board/modify?id=${board.id}" class="btn btn-info btn-sm">수정</a>
      <a href="/adm/board/list" class="btn btn-info btn-sm btn-outline">목록</a>
    </div>
</div>



<%@ include file="../common/tail.jspf"%>