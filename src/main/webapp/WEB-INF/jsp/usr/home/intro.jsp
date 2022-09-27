<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
  <title>포트폴리오</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="/resource/common.js" defer="defer"></script>
  <style>
  body {
    font: 400 15px Lato, sans-serif;
    line-height: 1.8;
    color: #818181;
  }
  h2 {
    font-size: 24px;
    text-transform: uppercase;
    color: #303030;
    font-weight: 600;
    margin-bottom: 30px;
  }
  h4 {
    font-size: 19px;
    letter-spacing:-0.0625rem;
    line-height: 1.6;
    color: #303030;
    font-weight: 400;
    margin-bottom: 30px;
  }  
  .jumbotron {
    background-color: #0e484d; /* 대표 */
    color: #fff;
    padding: 100px 25px;
    font-family: Montserrat, sans-serif;
  }
  .container-fluid {
    padding: 60px 50px;
  }
  .bg-grey {
    background-color: #f6f6f6;
  }
  .logo-small {
    color: #0e484d;
    font-size: 50px;
  }
  .logo {
    color: #0e484d;
    font-size: 200px;
  }
  .thumbnail {
    padding: 0 0 15px 0;
    border: none;
    border-radius: 0;
  }
  .thumbnail img {
    width: 100%;
    height: 100%;
    margin-bottom: 10px;
  }
  .carousel-control.right, .carousel-control.left {
    background-image: none;
    color: #0e484d;
  }
  .carousel-indicators li {
    border-color: #0e484d;
  }
  .carousel-indicators li.active {
    background-color: #0e484d;
  }
  .item h4 {
    font-size: 19px;
    line-height: 1.375em;
    font-weight: 400;
    font-style: italic;
    margin: 70px 0;
  }
  .item span {
    font-style: normal;
  }
  .panel {
    border: 1px solid #0e484d; 
    border-radius:0 !important;
    transition: box-shadow 0.5s;
  }
  .panel:hover {
    box-shadow: 5px 0px 40px rgba(0,0,0, .2);
  }
  .panel-footer .btn:hover {
    border: 1px solid #0e484d;
    background-color: #fff !important;
    color: #0e484d;
  }
  .panel-heading {
    color: #fff !important;
    background-color: #0e484d !important;
    padding: 25px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
    border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
  }
  .panel-footer {
    background-color: white !important;
  }
  .panel-footer h3 {
    font-size: 32px;
  }
  .panel-footer h4 {
    color: #aaa;
    font-size: 14px;
  }
  .panel-footer .btn {
    margin: 15px 0;
    background-color: #0e484d;
    color: #fff;
  }
  .navbar {
    margin-bottom: 0;
    background-color: #0e484d;
    z-index: 9999;
    border: 0;
    font-size: 12px !important;
    line-height: 1.42857143 !important;
    letter-spacing: 4px;
    border-radius: 0;
    font-family: Montserrat, sans-serif;
  }
  .navbar li a, .navbar .navbar-brand {
    color: #fff !important;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
    color: #0e484d !important;
    background-color: #fff !important;
  }
  .navbar-default .navbar-toggle {
    border-color: transparent;
    color: #fff !important;
  }
  footer .glyphicon {
    font-size: 20px;
    margin-bottom: 20px;
    color: #0e484d;
  }
  .slideanim {visibility:hidden;}
  .slide {
    animation-name: slide;
    -webkit-animation-name: slide;
    animation-duration: 1s;
    -webkit-animation-duration: 1s;
    visibility: visible;
  }
  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
  }
  @media screen and (max-width: 768px) {
    .col-sm-4 {
      text-align: center;
      margin: 25px 0;
    }
    .btn-lg {
      width: 100%;
      margin-bottom: 35px;
    }
  }
  @media screen and (max-width: 480px) {
    .logo {
      font-size: 150px;
    }
  }
  </style>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#myPage">💕</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right"> 
        <li><a href="#portfolio">PORTFOLIO</a></li> 
        <li><a href="#contact">CONTACT</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="jumbotron text-center">
  <h2 style="color:white; line-height:1.5; font-weight:500">안녕하세요.<br/>남예지 포트폴리오입니다.</h2>  
</div>

<!-- Container (portfolio Section) -->
<div id="portfolio" class="container-fluid">
  <div class="row"> 
    <div class="col-sm-6">
      <img style="width:100%" src="/resource/img/portfolio_1.jpg" alt="포트폴리오_블로그_스트링부트" title="포트폴리오_블로그" />
    </div>
    <div class="col-sm-6">
      <h2>Blog</h2> 
      <h4>
       JAVA 사용경험과 숙련도 향상을 위해 수업으로 만든 결과물에 부족한 기능을 추가하면서 만든 첫 사이트입니다. 
       </h4> 
      <p>
      작업기간 : 2022. 07 - 2022. 08 <br />
      - JAVA, Spring Boot <br />
      - GIT <a link="https://github.com/dkdlelql123/blog" target="_blank" class="btn btn-xs btn-default" >바로가기</a><br />
      - MySQL, MariaDB <br />
      - Nginx, Tomcat <br />
      - HTML, CSS, JS <br />
      - TailwindCSS, DaisyUI
      </p>
      <br><a href="https://blog.yeji.967.be" target="_blank" class="btn btn-default btn-lg">Go 👉</a>
    </div>
  </div>
</div>

<div class="container-fluid bg-grey">
  <div class="row">
    <div class="col-sm-6">
      <img style="width:100%" src="/resource/img/portfolio_2.jpg" alt="포트폴리오_댓글게시판" title="포트폴리오_댓글게시판" />
    </div>
    <div class="col-sm-6">
      <h2>기본 댓글형 게시판</h2> 
      <h4>
        JAVA 개발자로 취업하기 위해서는 전자정부프레임워크에 대해 공부해야겠다고 생각했습니다.
        <a href="https://youtu.be/0FwIIiDSvho" target="_blank" >YOUTUBE</a>를 참고하여서 제작하는 중입니다.
       </h4> 
      <p>
      작업기간 : 2022. 09 ~ <br />
      - 윈도우 64bit 환경 / 전자정부 프레임워크 4.x 실행환경<br />
      - JAVA 11.0.16<br />
      - GIT <a link="https://github.com/dkdlelql123/eGov_web_pratice" target="_blank" class="btn btn-xs btn-default">바로가기</a><br />
      - 개발환경 - 4.x 다운로드<br />
      - MySQL, XAMPP(v 3.3.0), SQLyog<br />
      - Tomcat <br />
      - HTML, CSS, JS <br />
      - Bootstrap
      </p>
      <br><a href="https://blog.yeji.967.be" target="_blank" class="btn btn-default btn-lg">Github 👉</a>
    </div>
  </div>
</div> 

<!-- Container (Contact Section) -->
<div id="contact" class="container-fluid bg-grey">
  <h2 class="text-center">CONTACT</h2>
  <div class="row">
    <div class="col-sm-5">
      <p>메일확인은 최대 1-2일 정도 걸릴 수 있습니다 :)</p>
      
      <p><span class="glyphicon glyphicon-heart"></span> 1996. 10. 07</p>
      <p><span class="glyphicon glyphicon-map-marker"></span> 대전</p>
      <!-- <p><span class="glyphicon glyphicon-phone"></span> +00 1515151515</p> -->
      <p><span class="glyphicon glyphicon-envelope"></span> dkdlelql123@naver.com</p>
    </div>
    <div class="col-sm-7 slideanim">
      <form onsubmit="mail__submitForm(this); return false;"> 
    
      <div class="row">
        <div class="col-sm-6 form-group">
          <input class="form-control" id="name" name="name" placeholder="Name" type="text" required>
        </div>
        <div class="col-sm-6 form-group">
          <input class="form-control" id="email" name="email" placeholder="Email" type="email" required>
        </div>
      </div>
      
      <textarea class="form-control" id="body" name="body" placeholder="Message" rows="5" required></textarea><br>
      
      <div> 
          <div class="text-right">
            <span class="num1"></span>
            +
            <span class="num2"></span>
            =
            <input type="text" name="calc" placeholder="?" class="form-control" style="display:inline; width: 120px" required/>
          </div>
      </div><br>
      
      <div class="row">
        <div class="col-sm-12 form-group">
          <button id="sendMail" class="btn btn-default pull-right" type="submit">Send</button>
        </div>
      </div>
      
      </form>
    </div>
  </div>
</div>
 

<footer class="container-fluid text-center">
    <h2><a href="#myPage" title="To Top">☝</a></h2>
  <br/>
  <p></p>
</footer>

<script>
$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})

// 메일
let submitWriterFormDone = false;
let num1 = Math.floor(Math.random() * 10);
let	num2 = Math.floor(Math.random() * 11) + 5;

$(function(){
	$(".num1").text(num1);
	$(".num2").text(num2);
});

async function mail__submitForm(form) { 
  if (submitWriterFormDone) {
  	alert("처리중이거나 이미 메일을 보낸상태입니다.");
  	return;
  }
  
  form.name.value =form.name.value.trim(); 
  if(form.name.value == null || form.name.value <= 0){
  	alert("이름을 입력해주세요.");
  	form.name.focus();
  	return;
  } 
  
  form.email.value =form.email.value.trim();
  if (form.email.value.length == 0) {
    alert('이메일을 입력해주세요.');
    form.email.focus();
    return;
  }
  
  if(validEmailCheck(form.email) == false){
      alert('올바른 이메일 주소를 입력해주세요.') 
      form.email.focus();
      return;
  }
  
  form.body.value = form.body.value.trim();
  if (form.body.value.length < 5) {
  alert("내용을 5글자 이상 작성해주세요."); 
  return; 
  }
  
  if(form.calc.value.trim() != (num2+num1)){
  	alert("덧셈 계산이 틀렸습니다.");
  	return;
  } 
  
  let url = "/usr/contact/send";
  let data = {
  	"name" :form.name.value,
  	"email" :form.email.value,
  	"body" :form.body.value,
  }
  
  $("#sendMail").html("메일 보내는 중..🏃‍♀️");
  let res = await $.post(url, data);
  $("#sendMail").html("완료").attr("disabled", true);
  
  submitWriterFormDone = true;
}
</script>

</body>
</html>
