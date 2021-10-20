<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	window.onload = function(){

		comboLoad("combo-gender", "1", "SELECT");
		searchList();

	}

	function searchList(){

		/* 로그인 계정정보 조회 (프로필사진, 아이디) */
		let url = '/admin/member/list';
		ajaxLoad(url, null, "json", function(result){
			gfnAlert(result);

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
				<input type="text">
			</div>
			<div class="content-serach-item">
				<label>성명</label>
				<input type="text">
			</div>
			<div class="content-serach-item">
				<label>성별</label>
				<select id="combo-gender">
				</select>
			</div>
			<input class="btn-cmmn btn-search" type="button" value="조회">
		</div>
		<div class="content-btn">
			<input class="btn-cmmn btn-content" type="button" value="신규">
		</div>
		<div class="content-work">
			<table>
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
				<tbody>
					<tr>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
					</tr>
					<tr>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
					</tr>
					<tr>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
						<td>데이터1</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>