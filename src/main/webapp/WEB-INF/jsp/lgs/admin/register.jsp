<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scalle=1">
    <title><spring:message code="admin.register.title" /></title>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/cmmn.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/login.css'/>"/>
	<jsp:include page="../cmmn/import.jsp"></jsp:include>
	<!-- 다음(카카오) 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javaScript">

		window.onload = function(){
			const btnRegister = document.getElementById("btn-register");
			const btnPrev = document.getElementById("btn-prev");
			const iptImage = document.getElementById("image");
			const btnLoaction = document.getElementById("btn-loaction");
			const comboQuiz = document.getElementById("combo-quiz");
			const iptId = document.getElementById("id");
			const iptBirthday = document.getElementById("birthday");

			/* 콤보박스 코드 로드 */
			comboLoad("combo-gender", "1", "SELECT");
			comboLoad("combo-quiz", "4", "SELECT");

			/* input 태그 숫자만 입력되게 */
			inputOnlyNumber("phonenum");

			/* input 글자 길이 유효성 체크 */
			lengthMaxMinValidate("id", 15, 5, "아이디");
			lengthMaxMinValidate("passwd", 15, 6, "비밀번호");

			/* 가입버튼 클릭 */
			btnRegister.onclick = function(){

				if(confirm("가입 하시겠습니까?")) {

					/*유효성 체크 결과값 이 실패면 종료*/
					if (validate() == -1) {
						return;
					}

					/* promise를 이용한 비동기 통신 */
					new Promise(function(resolve, reject){
						/* 프로필 사진 업로드*/
						/* 프로필 사진 업로드*/
						let url = '/fileUpload';
						let data = new FormData();
						data.append("file", iptImage.files[0]);

						ajaxLoad(url, data, "text", function(result){
							resolve(result);
						}, false, false);
					}).then(function(resolve){
						document.getElementById("memberImageNo").value = resolve;

						let url = '/cmmn/registerProcess';
						let data = $("#regi-form").serialize();

						ajaxLoad(url, data, "json", function(){
							alert("회원가입완료");
							location.href = "/admin";
						});
					});
				}
			}

			/* 뒤로가기 버튼 클릭 */
			btnPrev.onclick = function(){
				location.href="/admin";
			}

			/* 프로필 사진 데이터 체인지 될 경우 섬네일 화면 수정*/
			iptImage.onchange = function(e){
				readImage(e.target, "preview-image");
			}

			/* 주소 찾기 버튼 클릭 */
			btnLoaction.onclick = function(){
				//카카오 주소
				new daum.Postcode({
					oncomplete: function(data) { //선택시 입력값 세팅
						document.getElementById("location").value = data.address; // 주소 넣기
						document.querySelector("input[name=locationDtl]").focus(); //상세입력 포커싱
					}
				}).open();

			}

			/* 질문 클릭시 답변 리셋 */
			comboQuiz.onchange = function(){
				const pwfind = document.getElementById("pwfind");
				pwfind.value = "";
			}

			/* 아이디 체인지 - 중복확인 */
			iptId.onchange = function(){

				let url = '/cmmn/overlapId';
				let data = {id : this.value};

				ajaxLoad(url, data, "text", function(data){
					if(data == 1){
						alert("중복 된 계정이 있습니다.");
						iptId.value = "";
						iptId.focus();
					}
				});
			}

			/* 데이터 피커 값 (-) 하이푼 제거후 히든 인풋에 저장 */
			iptBirthday.onchange = function(){
				let hiddenVal = document.getElementById("hidden-birthday");
				hiddenVal.value = fncDateToStr(iptBirthday.value);
			}
		}

		/*유효성 체크*/
		function validate(){
			/* 개인정보 동의 체크 */
			const termsChk = document.getElementsByName("terms");

			if(termsChk[1].checked == true){
				alert("개인정보 동의를 해야 가입을 할 수 있습니다.");
				return -1;
			}

			// input 태그
			const validationInputChkId = ["id", "passwd", "pwfind", "name", "birthday", "phonenum", "location", "locationDtl", "email"];
			const validationInputChkIdText = ["아이디", "비밀번호", "비밀번호 답변", "이름", "생년월일", "연락처", "주소", "상세주소", "이메일"];

			// select 태그
			const validationComboChkId = ["combo-quiz", "combo-gender"];
			const validationComboChkIdText = ["비밀번호 질문", "성별"];

			/* 필수값 체크 */
			for(let i = 0 ; i < validationInputChkId.length ; i++){
				let ele = document.getElementById(validationInputChkId[i]);
				let inputVal =  ele.value;

				if(nullChk(inputVal)){
					alert("("+validationInputChkIdText[i]+ ")는 필수 입력 값 입니다.");
					ele.focus();
					return -1;
				}
			}

			for(let i = 0 ; i < validationComboChkId.length ; i++){
				let ele = document.getElementById(validationComboChkId[i]);
				let inputVal =  ele.value;

				if(nullChk(inputVal)){
					alert("("+validationComboChkIdText[i]+ ")는 필수 선택 값 입니다.");
					ele.focus();
					return -1;
				}
			}

			/* 비밀번호 같은지 체크 */
			const passwd = document.getElementById("passwd").value;
			const passwdChk = document.getElementById("passwdchk").value;

			if(passwd != passwdChk){
				alert("비밀번호 가 일치 하지 않습니다.");
				return -1;
			}
		}

		/* input 태그 최대 최소 length 유효성 체크 */
		function lengthMaxMinValidate(inputId, max, min, name){
			const ipt = document.getElementById(inputId);

			ipt.onchange = function(){

				const len = ipt.value.length;
				if(len > max){
					alert("("+name+")은 "+max+": 길이를 초과 할 수 없습니다.");
					ipt.value = "";
				}
				if(len < min){
					alert("("+name+")은 "+min+"글자 이상 입력 하세요.");
					ipt.value = "";
				}
				ipt.focus();
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
		<div class="regi-content">
			<div class="terms">
				<h2 class="terms-title h2-title"><i class="fas fa-circle"></i>개인정보 동의</h2>
				<div class="terms-content">
					<p>본인은 귀사에 이력서를 제출함에 따라 [개인정보 보호법] 제15조 및 제17조에 따라
						아래의 내용으로 개인정보를 수집, 이용 및 제공하는데 동의합니다.</p><br>
					<p><strong>□ 개인정보의 수집 및 이용에 관한 사항</strong>
						- 수집하는 개인정보 항목 (이력서 양식 내용 일체) : 성명, 주민등록번호, 전화번호, 주소, 이메일, 가족관계, 학력사항, 경력사항, 자격사항 등과 그 外 이력서 기재 내용
						일체<br>
						- 개인정보의 이용 목적 : 수집된 개인정보를 사업장 신규 채용 서류 심사 및 인사서
						류로 활용하며, 목적 외의 용도로는 사용하지 않습니다.</p><br>
					<p><strong>□ 개인정보의 보관 및 이용 기간</strong>
						- 귀하의 개인정보를 다음과 같이 보관하며, 수집, 이용 및 제공목적이 달성된 경우
						[개인정보 보호법] 제21조에 따라 처리합니다.    </p><br>
					<p>
					</p>
				</div>
				<div class="terms-idchk">
					<label><input type="radio" name="terms" value="Y"/>예</label>
					<label><input type="radio" name="terms" value="N" checked="checked"/>아니오</label>
				</div>

				<form id="regi-form">
					<input type="hidden" id="memberImageNo" name="memberImageNo">
					<div class="regi-form">
						<h2 class="regi-title h2-title"><i class="fas fa-circle"></i>회원가입</h2>
						<div class="regi-input">
								<div>
									<div class="regi-tr">
										<label>아이디</label>
										<input type="text" name="id" id="id" placeholder="아이디" maxlength="15">
									</div>
									<div class="regi-tr">
										<label>비밀번호</label>
										<input type="password" name="passwd" id="passwd" placeholder="비밀번호" maxlength="15">
									</div>
									<div class="regi-tr">
										<label>비밀번호 확인</label>
										<input type="password" name="passwdchk" id="passwdchk" placeholder="비밀번호 확인" maxlength="15">
									</div>
									<div class="regi-tr">
										<input type="hidden" name="quiz" id="quiz">
										<label>비밀번호 질문</label>
										<select id="combo-quiz">
										</select>
									</div>
									<div class="regi-tr">
										<label>답변</label>
										<input type="pwfind" name="pwfind" id="pwfind" placeholder="비밀번호 찾기 답변" maxlength="50">
									</div>
									<div class="regi-tr">
										<label>성명</label>
										<input type="text" name="name" id="name" placeholder="성명">
									</div>
								</div>
								<div>
									<div class="regi-tr">
										<input type="hidden" name="gender" id="gender">
										<label>성별</label>
										<select id="combo-gender">
										</select>
									</div>
									<div class="regi-tr">
										<label>생년월일</label>
										<input type="hidden" name="birthday" id="hidden-birthday">
										<input type="date" id="birthday" placeholder="생년월일">
									</div>
									<div class="regi-tr">
										<label>연락처</label>
										<input type="text" name="phonenum" id="phonenum" placeholder="연락처 (-) 제외 입력">
									</div>
									<div class="regi-tr">
										<label>주소</label>
										<input type="text" name="location" id="location" placeholder="주소">
										<input class="btn-cmmn btn-size" id="btn-loaction" type="button" value="주소찾기">
									</div>
									<div class="regi-tr">
										<label>상세 주소</label>
										<input type="text" name="locationDtl" id="locationDtl" placeholder="상세 주소">
									</div>
									<div class="regi-tr">
										<label>이메일</label>
										<input type="text" name="email" id="email" placeholder="이메일">
									</div>
									<div class="regi-tr">
										<form id="fileForm" enctype="multipart/form-data">
											<label>프로필 사진</label>
											<input type="file" name="image" id="image" accept="image/png, image/jpeg">
										</form>
									</div>
								</div>
								<div class="picture-form">
									<label>이미지 미리보기</label>
									<img class="picture" id="preview-image" src="/images/lgs/noimage.gif">
								</div>
						</div>
						<div class="regi-btn">
							<input id="btn-register" class="btn-cmmn btn-size" type="button" value="가입">
							<input id="btn-prev" class="btn-cmmn btn-size" type="button" value="취소">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
