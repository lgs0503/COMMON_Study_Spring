<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="frm-write">
	<div class="contents">
		<div class="content-title">회원추가</div>
		<div class="content-work">
			<div class="content-table-detail">
				<table>
					<colgroup>
						<col width="150px"></col>
						<col width="*"></col>
					</colgroup>
					<tbody>
						<tr>
							<th>아이디</th>
							<td><input id="id" name="id" type="text" required></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input id="pw" name="pw" type="password" required></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input id="name" name="name" type="text" required></td>
						</tr>
						<tr>
							<th>사이트 명</th>
							<td><input id="sitename" name="sitename" type="text" required></td>
						</tr>
						<tr>
							<th>사이트 정보</th>
							<td><input id="siteinfo" name="siteinfo" type="text" required></td>
						</tr>
						<tr>
							<th>구글맵스-위도</th>
							<td><input type="number"></td>
						</tr>
						<tr>
							<th>구글맵스-경도</th>
							<td><input type="number"></td>
						</tr>
						<!-- <tr>
							<th>등록여부</th>
							<td><input type="text"></td>
						</tr> -->
					</tbody>
				</table>
			</div>
			<div class="content-detail-btn">
				<input id= "btn-retrunpage" class="btn btn-color1" type="button" value="나가기">
				<input id= "btn-insert" class="btn btn-color1" type="submit" value="저장">
			</div>
		</div>
	</div>
</form>
<script type="text/javaScript" language="javascript" defer="defer" src="/js/lgs/member.js"></script>