<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title><spring:message code="admin.passwdFind.title" /></title>
	<jsp:include page="../cmmn/import.jsp"></jsp:include>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/cmmn.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/login.css'/>"/>
	<script type="text/javaScript">
		window.onload = function(){

			let ipt1 = document.getElementById("pwfind-input1");
			const btnFind = document.getElementById("btn-find");
			const btnPrev = document.getElementById("btn-prev");

			ipt1.style.display = "block";

			/* 찾기 버튼 클릭*/
			btnFind.onclick = function(){
				let ipt2 = document.getElementById("pwfind-input2");
				let ipt3 = document.getElementById("pwfind-input3");

				let userId = document.getElementById("userId").value;

				if(ipt1.style.display == "block"){
					/* 아이디 로 비밀번호 찾기 퀴즈 조회 */
					if(nullChk(userId)){
						gfnAlert("아이디를 입력해주세요");
						return;
					} else {
						let url = '/cmmn/selectPwFindQuiz';
						let data = {id : userId};

						ajaxLoad(url, data, "text", function(result){
							if(nullChk(result)){
								gfnAlert("일치하는 계정이 없습니다.");
								return;
							}
							document.getElementById("quiz").value = result;

							ipt1.style.display = "none";
							ipt2.style.display = "block";
						});
					}
				} else if (ipt2.style.display == "block"){
					/* 아이디 로 비밀번호 찾기 퀴즈 답변으로 비밀번호 찾기 */
					let answer = document.getElementById("answer").value;

					let url = '/cmmn/selectPwFind';
					let data = { id : userId
					           , answer : answer};

					ajaxLoad(url, data, "text", function(result){
						if(nullChk(result)){
							gfnAlert("답변이 일치하지 않습니다.");
							return;
						}
						document.getElementById("password").value = result;

						ipt2.style.display = "none";
						ipt3.style.display = "block";
						btnFind.style.display ="none";
					});
				}
			};

			/* 취소 버튼 클릭 */
			btnPrev.onclick = function () {
				location.href = "/admin";
			}
		}
	</script>
</head>
<body>
		<div class="container">
			<div class="header regi-header">
				<div class="header-title">
					<h1 class="header-title-main font70"><a href="/admin">CMS</a></h1>
					<h2 class="header-title-sub">Contents Management System</h2>
				</div>
			</div>
			<div class="pwfind-form">
				<h2 class="pwfind-title h2-title">비밀번호 찾기</h2>
				<div class="pwfind-contents">
					<div class="pwfind-input" id="pwfind-input1">
						<input type="text" id="userId" placeholder="아이디를 입력해주세요."/>
					</div>
					<div class="pwfind-input" id="pwfind-input2">
						<div class="ipt-quiz">
							<label>Q :</label>
							<input type="text" id="quiz" readonly="readonly" value=""/>
						</div>
						<div class="ipt-answer">
							<label>A :</label>
							<input type="text" id="answer" placeholder="비밀번호 찾기 답변"/>
						</div>
					</div>
					<div class="pwfind-input" id="pwfind-input3">
						<label>현재 비밀번호는</label>
						<input type="text" id="password" readonly="readonly" value=""/>
						<label>입니다.</label>
					</div>
					<div class="pwfind-btn">
						<input id="btn-find" class="btn-cmmn" type="button" value="찾기"/>
						<input id="btn-prev" class="btn-cmmn" type="button" value="취소"/>
					</div>
				</div>
			</div>
		</div>
</body>
</html>
