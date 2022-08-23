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
  
  let data = {
    "title"  : "출석",
    "start" : dateStr,
    "memberId" : memberId,
    // "end": , 필요시 작성
    // allDay : false 일때만 작성
  }
  
  let now =  Date.now();   			//오늘날짜
  let date = new Date();  
  date.setDate(date.getDate() + 1);  	// 내일날짜
  date.setHours(0,0,0,0);  				// 시, 분, 초, 밀리 - 내일날짜 중 시간은 초기화
  let tomorrow = date.getTime();
   
  function setItemWithExpireTime(keyName, keyValue){
	  let obj = {
		"value": keyValue, 
		"expire": tomorrow 
	  };
	  
	  let objString = JSON.stringify(obj); 
	  localStorage.setItem(keyName, objString);
  }
  
  $(() => {
    let calendarEl = document.getElementById('calendar');
    let calendar = new FullCalendar.Calendar(calendarEl, {  
        events: async function(){
          let response = await fetch("/usr/attendance/list");
          let jsonfile = await response.json();  
          //let attendanceList=[];
          //$.each(jsonfile, function(i, item){  
          //	 attendanceList.push({
          //		 title: item.title,
          //		 start: item.start, 
          //	 })
          //})  
          return jsonfile;
      	},
        initialView: 'dayGridMonth',
        height: 500,                  		//머리글과 바닥글을 포함하여 전체 달력의 높이를 설정
        //contentHeight: 300              	//달력의 보기 영역의 높이
        //aspectRatio: 2,               	//너비가 높이의 2배
        fixedWeekCount: false,            	//ture : 6주짜리 달력, false : 달마다 다르게 4-6주 적용
        
        customButtons: {                	// 출석체크 버튼 생성
          myCustomButton: {
            text: '출석체크',
            click: function() { 
            	if(memberId <= 0 || memberId ==null){
            		alert("회원만 이용가능합니다");
                	return;
            	}
            	
            	const localStorageKey = "check__attendance__member__"+memberId; 
            	const getItem = localStorage.getItem(localStorageKey);
            	const getItemJson = JSON.parse(getItem);
            	if(!getItem || getItemJson.expire <= now ){
            		localStorage.removeItem(localStorageKey)
            	} else {            		
            		alert("이미 출석하셨습니다.");
                	return;
            	}
            	
            	$.ajax({
                  url: "/usr/attendance/check",
                  type: "POST",
                  data:data,
                  success: function(e) {  
                    setItemWithExpireTime(localStorageKey, "true"); 
                    calendar.refetchEvents();	
                  }
                })
            },
          }
        },
        
        headerToolbar: {
          left: 'myCustomButton',
          center: 'title',
          right: 'prev,next'              	// 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        
        
      /*dateClick: function(info) {         // 날짜 클릭
        console.log(info);
          alert('Clicked on: ' + info.dateStr);
          //alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
          alert('Current view: ' + info.view.type);
          // change the day's background color just for fun
          info.dayEl.style.backgroundColor = 'red';
        }
        events: [
          {
            title  : 'event1',
            start  : '2022-08-01'
          },
          {
            title  : 'event2',
            start  : '2022-08-05',
            end    : '2022-08-07'
          },
          {
            title  : '출석',
            start  : '2022-08-09T08:30:00',
            allDay : false // will make the time show
          },
          {
            title  : '퇴근',
            start  : '2022-08-09T18:30:00',
            allDay : false // will make the time show
          }
        ], 
        eventSources: [ 
            {
              //data,
              color: 'yellow',    // an option!
              textColor: 'black'  // an option!
            }  
        ],
        */ 
    }); 

    calendar.render();
    
  });
</script>

<div id='calendar'></div>

 
<%@ include file="../common/tail.jspf"%>
