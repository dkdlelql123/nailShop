<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="출석체크" />
<%@ include file="../common/head.jspf"%>
 
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.2/main.min.js" ></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.2/main.min.css" />
<input type="hidden" id="memberId" value="${rq.logined ? rq.member.id : null}"/>

<script defer> 
  // 오늘날짜 구하기  
  const today = new Date();
  const year = today.getFullYear();
  const month = (today.getMonth() + 1) < 10 
  	 ? "0"+(today.getMonth() + 1) 
     : today.getMonth() + 1;
  const day = (today.getDate() < 10) 
 	 ? "0"+today.getDate() 
	 : today.getDate() ;
  const dateStr = year + '-' + month + '-' + day;  
    
  const memberId = $("#memberId").val();
  
  /**
  param title - String 
  param start - String
  param memberId - int
  param end - String    	#필요시 작성
  param allDay - boolean 	#default-true  
  */
  let data = {
    "title"  : "출석",
    "start" : dateStr,
    "memberId" : memberId, 
  } 
  
  $(() => {
    let calendarEl = document.getElementById('calendar');
    let calendar = new FullCalendar.Calendar(calendarEl, {  
        events: async function(){
          let response = await fetch("/usr/attendance/list");
          let jsonfile = await response.json();   
          return jsonfile;
      	},
        initialView: 'dayGridMonth',
        height: 500,                  		 
        fixedWeekCount: false,              
        customButtons: {                	 
          myCustomButton: {
            text: '출석체크',
            click: function() { 
            	if(memberId <= 0 || memberId == null){
            		alert("회원만 이용가능합니다");
                	return;
            	}   
            	$.ajax({
                  url: "/usr/attendance/check",
                  type: "POST",
                  data: data,
                  success: function(res) {  
                	console.log(res)
                	if (res.resultCode.substr(0,1) == "S"){
                		alert(res.msg);
                		calendar.refetchEvents();	
                	} else {
                		alert(res.msg);
                		return
                	} 
                  }
               })
            },
          }
        },
        
        headerToolbar: {
          left: 'myCustomButton',
          center: 'title',
          right: 'prev,next'              	
        }, 
    }); 

    calendar.render();
    
  });
</script>

<div id='calendar'></div>

 
<%@ include file="../common/tail.jspf"%>
