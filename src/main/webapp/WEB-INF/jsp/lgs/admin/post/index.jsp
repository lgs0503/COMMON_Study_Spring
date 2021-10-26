<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	window.onload = function(){

		comboLoad("combo-poststatus", "B001", "SELECT");
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

		/* 엔터 조회 */
		let enterId = ["post-name", "combo-bbs", "combo-poststatus"];

		enterId.forEach(function(value){
			addEnter(value, function(){
				btnSearch.click();
			});
		});
	}

	/* 회원 조회 */
	function searchList(){

		let data = { name : document.getElementById("post-name").value
			       , type : document.getElementById("combo-bbs").value
			       , type : document.getElementById("combo-poststatus").value };

		/* 로그인 계정정보 조회 (프로필사진, 아이디) */
		let url = '/admin/post/list';
		ajaxLoad(url, data, "json", function(result){

			let postBody = document.getElementById("postBody");

			postBody.innerHTML = "";

			if(result.bbsCnt != null){
				document.getElementById("list-cnt").innerHTML = result.bbsCnt;
			}

			if(result.bbsList.length == 0){
				let colData = document.createElement("tr");
				let rowData = document.createElement("td");
				rowData.colSpan = 6;
				rowData.innerText = "조회된 데이터가 없습니다.";
				colData.append(rowData);
				bbsBody.append(colData);
			}

			result.bbsList.forEach(function(value){

				let colData = document.createElement("tr");

				let rowData = document.createElement("td");
				rowData.innerText = value.BBS_NO;
				rowData.className = "list-dtl";
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.BBS_NAME;
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.BBS_TYPE;
				colData.append(rowData);

				rowData = document.createElement("td");
				rowData.innerText = value.INSERT_DATE;
				colData.append(rowData);

				postBody.append(colData);
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
			<h2>게시글관리</h2>
			<div class="title-info">
				<h2>컨텐츠관리 <i class="fas fa-caret-right"></i> 게시글관리</h2>
			</div>
		</div>
		<div class="content-serach-form">
			<div class="content-serach-item">
				<label>게시판</label>
				<select id="combo-bbs"></select>
			</div>
			<div class="content-serach-item">
				<label>게시글명</label>
				<input id="post-name" type="text">
			</div>
			<div class="content-serach-item">
				<label>상태</label>
				<select id="combo-poststatus"></select>
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
					<col width="150px">
					<col width="200px">
					<col width="100px">
					<col width="200px">
				</colgroup>
				<thead>
					<tr>
						<th>게시글번호</th>
						<th>게시판명</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody id="postBody"></tbody>
			</table>
		</div>
	</div>
</body>
<!-- 회원 상세 신규 레이어 팝업-->
<jsp:include page="/WEB-INF/jsp/lgs/admin/post/layer/postLayer.jsp"></jsp:include>