<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="frm-update">
	<input type="hidden" id="idxurl" value="<c:out value="${MEMBER.IDX}"></c:out>">
	<div class="contents">
		<div class="content-title">회원수정</div>
		<div class="content-work">
			<div class="content-table-detail">
				<table>
					<colgroup>
						<col width="150px"></col>
						<col width="*"></col>
					</colgroup>
					<tbody>
						<tr>
							<th>일련번호</th>
							<td><input id="idx" name="idx" value="<c:out value="${MEMBER.IDX}"></c:out>" type="text" required></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input id="id" name="id" value="<c:out value="${MEMBER.ID}"></c:out>" type="text" required></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input id="pw" name="pw" value="<c:out value="${MEMBER.PW}"></c:out>" type="password" required></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input id="name" name="name" value="<c:out value="${MEMBER.NAME}"></c:out>" type="text" required></td>
						</tr>
						<tr>
							<th>사이트 명</th>
							<td><input id="sitename" name="sitename" value="<c:out value="${MEMBER.SITE_NAME}"></c:out>" type="text" required></td>
						</tr>
						<tr>
							<th>사이트 정보</th>
							<td><input id="siteinfo" name="siteinfo" value="<c:out value="${MEMBER.SITE_INFO}"></c:out>" type="text" required></td>
						</tr>
						<tr>
							<th>구글맵스-위도</th>
							<td><input type="number"></td>
						</tr>
						<tr>
							<th>구글맵스-경도</th>
							<td><input type="number"></td>
						</tr>
						<tr>
							<th>증명사진 파일</th>
							<td><input type="file"></td>
						</tr>
						<tr>
							<th>이력서 파일</th>
							<td><input type="file"></td>
						</tr>
						<tr>
							<th>자소서 파일</th>
							<td><input type="file"></td>
						</tr>
						<tr>
							<th>경력인증서 파일</th>
							<td><input type="file"></td>
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
				<input id= "btn-update" class="btn btn-color1" type="submit" value="저장">
			</div>
		</div>
	</div>
</form>
<script type="text/javaScript" language="javascript" defer="defer" src="/js/lgs/member.js"></script>