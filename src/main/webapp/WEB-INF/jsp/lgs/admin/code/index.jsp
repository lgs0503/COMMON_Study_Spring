<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript">
	window.onload = function(){
		$('#jstree_demo_div').on("changed.jstree", function (e, data) {
			if(data.selected.length) {
				alert('The selected node is: ' + data.instance.get_node(data.selected[0]).text);
			}
		}).jstree({
			'core' : {
				'data' : [
					{ "text" : "Root node", "children" : [
							{ "text" : "Child node 1" },
							{ "text" : "Child node 2" }
						]}
				]
			}
		});


		// ajax demo
		/*$('#ajax').jstree({
			'core' : {
				'data' : {
					"url" : "./root.json",
					"dataType" : "json" // needed only if you do not supply JSON headers
				}
			}
		});*/
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
			<h2>코드관리</h2>
			<div class="title-info">
				<h2>시스템관리 <i class="fas fa-caret-right"></i> 코드관리</h2>
			</div>
		</div>
		<div class="content-serach-form">
			<div class="content-serach-item">
				<label>코드명</label>
				<input id="user-id" type="text">
			</div>
			<div class="content-serach-item">
				<label>코드번호</label>
				<input id="user-name" type="text">
			</div>
			<div class="content-serach-item">
				<label>사용여부</label>
				<select id="combo-useyn"></select>
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
			<div id="jstree_demo_div"></div>


		</div>
	</div>
</body>