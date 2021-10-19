<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="contents">
	<div class="content-title">상세정보</div>
	<div class="content-work">
		<div class="content-table-detail">
			<table>
				<colgroup>
					<col width="100px"></col>
					<col width="*"></col>
				</colgroup>
				<tbody>
					<tr>
						<th>일련번호</th>
						<td id="idx">${MEMBER.IDX}</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${MEMBER.ID}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${MEMBER.NAME}</td>
					</tr>
					<tr>
						<th>사이트 명</th>
						<td>${MEMBER.SITE_NAME}</td>
					</tr>
					<tr>
						<th>사이트 정보</th>
						<td>${MEMBER.SITE_INFO}</td>
					</tr>
					<tr>
						<th>등록여부</th>
						<td>${MEMBER.IDX}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="content-detail-btn">
			<input id= "btn-listretrunpage" class="btn btn-color1" type="button" value="나가기">
			<input id= "btn-updatepage" class="btn btn-color1" type="button" value="수정">
			<input id= "btn-delete" class="btn btn-color1" type="button" value="삭제">
		</div>
	</div>
</div>
<script type="text/javaScript" language="javascript" defer="defer" src="/js/lgs/member.js"></script>