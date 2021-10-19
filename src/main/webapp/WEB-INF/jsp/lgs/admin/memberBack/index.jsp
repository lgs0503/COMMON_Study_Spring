<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="frm-search" method="get" action="/admin/member">
	<input id="chk-keyword" name="keyword" type="hidden">
	<input id="chk-chkbox" name="chkbox" type="hidden">
</form>
<form id="frmMember" method="get"></form>
<input id="chkbox-chk" type="hidden" value='<c:out value="${CHKBOX}"></c:out>'>
<div class="contents">
	<div class="content-title">회원관리</div>
	<div class="content-work">
		<div class="content-serach">
			<select id="chkbox" >
				<option value="">선택</option>
				<option value="name">이름</option>
				<option value="idx">일련번호</option>
				<option value="id">아이디</option>
			</select>
			<input id="keyword" class="keyword" type="text" placeholder="입력해주세요..." value="<c:out value="${KEYWORD}"></c:out>">
			<input id="btn-search" class="btn btn-color1" type="button" value="조회">
			<input id="btn-insertpage" class="btn btn-color1" type="button" value="신규">
		</div>
		<div class="content-table">
			<table>
				<colgroup>
					<col width="50px"></col>
					<col width="200px"></col>
					<col width="150px"></col>
					<col width="*"></col>
					<col width="*"></col>
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>ID</th>
						<th>이름</th>
						<th>사이트명</th>
						<th>가입여부</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty MEMBER}">
						<tr>
							<td colspan="5">데이터가 존재 하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty MEMBER}">
						<c:forEach var="member" items="${MEMBER}" varStatus="status">
							<tr onclick="get('${member.IDX}');">
								<td>${member.IDX}</td>
								<td>${member.ID}</td>
								<td>${member.NAME}</td>
								<td>${member.SITE_NAME}</td>
								<td>${member.REGI_CHK}</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<!-- 페이징 처리 -->
    	<div class="content-page">
    		<c:if test="${paging.startPage != 1}">
    			<a href="/admin/member?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">
    				<span><i class="fas fa-angle-left"></i></span>
				</a>
			</c:if>
			
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage}">
    	   				<span>${p}</span>
					</c:when>
					<c:when test="${p != paging.nowPage}">
    	   				<span><a href="/admin/member?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a></span>
					</c:when>
				</c:choose>
			</c:forEach>
			
			<c:if test="${paging.endPage != paging.lastPage}">
    	  	  	<a href="/admin/member?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">
    	  	  		<span><i class="fas fa-angle-right"></i></span>
				</a>
			</c:if>
    	</div>
	</div>
</div>
<script type="text/javaScript" language="javascript" defer="defer" src="/js/lgs/member.js"></script>