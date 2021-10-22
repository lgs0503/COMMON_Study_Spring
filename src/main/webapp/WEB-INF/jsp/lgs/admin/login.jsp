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
    <title><spring:message code="admin.login.title" /></title>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/cmmn.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/login.css'/>"/>
	<jsp:include page="../cmmn/import.jsp"></jsp:include>
    <script type="text/javaScript">
		window.onload = function(){
			/* 아이디 저장 쿠키 를 통한 구현 */
			let key = getCookie("key");
			let cookieId = document.getElementById('user-id');
			let chkId = document.getElementById("chk-id");

			if(key != null){
				cookieId.value = key;
			}

			if(cookieId.value != ""){
				chkId.checked = true;
			}

			chkId.onchange = function(){
				if(chkId.checked){
					setCookie("key", cookieId.value, 7);
				} else {
					deleteCookie("key");
				}
			}

			cookieId.onkeyup = function(){
				if(chkId.checked){
					setCookie("key", cookieId.value, 7);
				}
			}

			const btnLogin = document.getElementById('btn-login');
			const iptLogin = document.getElementsByClassName('login-ipt');

			/* 로그인 버튼 클릭 */
			btnLogin.onclick = function(){

				let userID = document.getElementById('user-id').value;
				let userPW = document.getElementById('user-pw').value;

				if(nullChk(userID)){
					gfnAlert("아이디를 입력해주세요.");
					return;
				} else if(nullChk(userPW)) {
					gfnAlert("패스워드를 입력해주세요.");
					return;
				}

				let url = '/cmmn/loginProcess';
				let data = { userID : userID ,
					         userPW : userPW };

				ajaxLoad(url, data, "text", function(data){
					console.log("success", data);
					if(data == "1"){
						location.href="/admin/main"
					} else {
						gfnAlert("아이디 및 비밀번호를 확인해주세요");
					}
				});
			}

			/* 엔터 조회 */
			let enterId = ["user-id", "user-pw"];

			enterId.forEach(function(value){
				addEnter(value, function(){
					btnLogin.click();
				});
			});
		}
	</script>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="header-title">
				<h1 class="header-title-main font70"><a href="/admin">CMS</a></h1>
				<h2 class="header-title-sub">Content ManageMent System</h2>
			</div>
		</div>
		<div class="contents">
			<div class="login-form">
				<div class="login-ipt">
					<div class="ipt-id">
						<i class="fas fa-user"></i>
						<input id="user-id" type="text" placeholder="아이디"/>
					</div>
					<div class="ipt-pw">
						<i class="fas fa-key"></i>
						<input id="user-pw" type="password" placeholder="비밀번호"/>
					</div>
				</div>
				<div class="login-idchk">
                    <input id="chk-id" type="checkbox"/>
                    <div class="chk-label">
                        아이디 저장
                    </div>
				</div>
				<div class="login-btn">
					<input id="btn-login" class="btn-cmmn" type="submit" value="로그인"/>
				</div>
			</div>
			<div class="other">
				<a href="/register">회원가입</a>
				<a href="/findpw">비밀번호 찾기</a>
			</div>
		</div>
	</div>
</body>
</html>
