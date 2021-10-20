<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	window.onload = function(){

		comboLoad("combo-gender", "1", "SELECT");
		searchList();

		const btnSearch = document.getElementById("btn-search");
		const btnInsert = document.getElementById("btn-insert");

		/* 조회 버튼 클릭 */
		btnSearch.onclick = function(){
			searchList();
		}

		/* 신규 버튼 클릭 */
		btnInsert.onclick = function(){
			loadLayer();
		}
	}

	/* 회원 조회 */
	function searchList(){

		let data = { id : document.getElementById("user-id").value
			       , name : document.getElementById("user-name").value
		           , gender : document.getElementById("combo-gender").value};

		/* 로그인 계정정보 조회 (프로필사진, 아이디) */
		let url = '/admin/member/list';
		ajaxLoad(url, data, "json", function(result){

			let memberBody = document.getElementById("memeberBody");

			memberBody.innerHTML = "";

			if(result.memberCnt != null){
				document.getElementById("list-cnt").innerHTML = result.memberCnt;
			}

			if(result.memberList.length == 0){
				let colData = document.createElement("tr");
				let rowData = document.createElement("td");
				rowData.colSpan = 6;
				rowData.innerText = "조회된 데이터가 없습니다.";
				colData.append(rowData);
				memberBody.append(colData);
			}

			result.memberList.forEach(function(value){

				let colData = document.createElement("tr");

				let rowData = document.createElement("td");
				rowData.innerText = value.MEMBER_NO;
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.MEMBER_ID;
				rowData.className = "list-dtl";
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.MEMBER_NAME;
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.MEMBER_GENDER;
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.MEMBER_PHONENUM;
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.INSERT_DATE;
				colData.append(rowData);

				memberBody.append(colData);
			});

			let listDtl = document.getElementsByClassName("list-dtl");

			for(let i = 0 ; i < listDtl.length ; i++){
				listDtl[i].onclick = function () {
					loadLayer("U", this.innerText);
				}
			}
		});
	}
</script>
<body>
	<div class="content">
		<div class="content-title">
			<i class="fas fa-caret-right"></i>
			<h2>회원관리</h2>
			<div class="title-info">
				<h2>시스템관리 <i class="fas fa-caret-right"></i> 회원관리</h2>
			</div>
		</div>
		<div class="content-serach-form">
			<div class="content-serach-item">
				<label>아이디</label>
				<input id="user-id" type="text">
			</div>
			<div class="content-serach-item">
				<label>성명</label>
				<input id="user-name" type="text">
			</div>
			<div class="content-serach-item">
				<label>성별</label>
				<select id="combo-gender"></select>
			</div>
			<input id="btn-search" class="btn-cmmn btn-search" type="button" value="조회">
		</div>
		<div class="content-top">
			<div class="list-cnt">
				<strong id="list-cnt">0</strong>개 조회
			</div>
			<div class="content-btn">
				<input id="btn-insert" class="btn-cmmn btn-content" type="button" value="신규">
			</div>
		</div>
		<div class="content-work">
			<table>
				<colgroup>
					<col width="40px">
					<col width="200px">
					<col width="100px">
					<col width="100px">
					<col width="200px">
					<col width="200px">
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>아이디</th>
						<th>성명</th>
						<th>성별</th>
						<th>전화번호</th>
						<th>가입일</th>
					</tr>
				</thead>
				<tbody id="memeberBody"></tbody>
			</table>
		</div>
	</div>
</body>
<!-- 회원 상세 신규 레이어 팝업-->
<jsp:include page="/WEB-INF/jsp/lgs/admin/member/layer/memberLayer.jsp"></jsp:include>