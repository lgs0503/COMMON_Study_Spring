<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title><spring:message code="client.main.title" /></title>
    <!-- fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <!-- 구글 폰트  -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/reset.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/lgs/mainbackup.css'/>"/>
    <!-- 구글맵스 -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB99EEL6J_xb4f0OETUzU3WTAXRqacx574&callback=initMap&region=kr"></script>
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
  			integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  			crossorigin="anonymous"></script>
    <script type="text/javaScript" language="javascript" defer="defer" src="/js/lgs/main.js"></script>
</head>
<body>
	<div class="container">
		<div class="backimg">
	    </div>
        <div class="header">
       		<div class="title">
       			<img src="<c:url value='/images/lgs/증명사진.jpg'/>"></img>
       			<h1>포트폴리오</h1>
       		</div>
       		<div class="header-text">
       			<p>안녕하세요 2년차 웹 개발자 27살 <strong>이광석</strong>입니다. 서버 개발에 참여하여 다양한 경험을 하였습니다 
       			   주된 업무로는 JAVA, Spring Framewrok, Javascript, JQuery, Nexacro, Oracle, MYSQL, MSSQL, WAS, 등
       			   의 기술을 사용하여 신규 서비스 구축 및 유지보수 업무를 담당하였습니다.
       			 </p><br><p>
       			 신규 서비스를 구축하여 내가만든 사이트를 편리하게 이용하는 고객들을 보며 즐거움을 느꼇으며 
       			 유지보수 및 인수인계 받은 프로젝트에서는 SQL튜닝을 통한 속도 개선을 진행하여 성장가능성을 느꼇습니다.
       			 </p><br><p>
       			 회사 업무 특성상 크로스플랫폼 Nexacro를 의존하여 프로트 구현을 많이 하였고 
       			 이직시 불이익이 발생할 것 으로 판단하여 따로 JSP 학습을 통해 JSP 프로젝트도 경험 하였습니다. 
       			 </p>
       		</div>
        </div>
        <div class="contents">
        	<div class="content-stack"> <!-- 기술 스택 -->
        	    <div class="content-title">
        	    	<h1><i class="fas fa-angle-right"></i>&nbsp;보유기술</h1>
        	    </div>
	        	<a id="btn-perv"><i class="fas fa-caret-left"></i></a>
        	    <div class="content-stack-work">
	        		<div class="content-stack-data">
	        			<h1>Language & Framework</h1>
	       				<p>JAVA, Spring Framework, Nexacro</p>
	       				<div class="content-stack-img">
	       					<img src="/images/lgs/java.png" />
	       					<img src="/images/lgs/spring.png" />
	       					<img src="/images/lgs/nexacro.jpg" />
	       				</div>
	        		</div>
	        		<div class="content-stack-data">
	        			<h1>WEB Server</h1>
	       				<p>Tomcat, Apache, JEUS, WebtoB</p>
	       				<div class="content-stack-img">
	       					<img src="/images/lgs/tomcat.png" />
	       					<img src="/images/lgs/apache.png" />
	       					<img src="/images/lgs/jeus.png" />
	       					<img src="/images/lgs/webtob.png" />
	       				</div>
	        		</div>
	        		<div class="content-stack-data">
	        			<h1>OPerating System</h1>
	       				<p>Windows Server 2012, CentoOS 7</p>
	       				<div class="content-stack-img">
	       					<img src="/images/lgs/windows.jpg" />
	       					<img src="/images/lgs/centos.jpg" />
	       				</div>
	        		</div>
	        		<div class="content-stack-data">
	        			<h1>DataBase</h1>
	       				<p>Oracle, MSSQL, MySQL</p>
	       				<div class="content-stack-img">
	       					<img src="/images/lgs/oracle.png" />
	       					<img src="/images/lgs/mssql.png" />
	       					<img src="/images/lgs/mysql.png" />
	       				</div>
	        		</div>
	        		<div class="content-stack-data">
	        			<h1>Configuration Tool & IDE</h1>
	       				<p>SVN, Eclipse, eGovFrame</p>
	       				<div class="content-stack-img">
	       					<img src="/images/lgs/svn.jpg" />
	       					<img src="/images/lgs/eclipse.jpg" />
	       					<img src="/images/lgs/egov.png" />
	       				</div>
	        		</div>
        	    </div>
	        	<a id="btn-next"><i class="fas fa-caret-right"></i></i></a>
        	</div>
        	<div class="content-jobs"> <!--  -->
        	    <div class="content-title">
        	    	<h1><i class="fas fa-angle-right"></i>&nbsp;학력 및 경력사항</h1>
        	    </div>
        	    <div class="content-jobs-table">
        	    	<table>
						<colgroup>
							<col width="100px"/>
							<col width="150px"/>
							<col width="150px"/>
							<col width="200px"/>
							<col width="*"/>
						</colgroup>
        	    		<thead>
        	    			<tr>
        	    				<th>구분</th>
        	    				<th>학교명, 직장명</th>
        	    				<th>전공, 직책(부서)</th>
        	    				<th>기간</th>
        	    				<td class="table-td-none">비고</td>
        	    			</tr>
        	    		</thead>
        	    		<tbody>
        	    			<tr>
        	    				<td>학력</td>
        	    				<td>오산대학교</td>
        	    				<td>스마트IT과</td>
        	    				<td>2017.03 ~ 2019.02</td>
        	    				<td class="table-td-none">학점 4.3</td>
        	    			</tr>
        	    			<tr>
        	    				<td>학력</td>
        	    				<td>경남관광고등학교</td>
        	    				<td>관광조리과</td>
        	    				<td>2011.03 ~ 2014.02</td>
        	    				<td class="table-td-none"></td>
        	    			</tr>
        	    			<tr>
        	    				<td>경력</td>
        	    				<td>(주)바구반소프트</td>
        	    				<td>주임(공공사업팀)</td>
        	    				<td>2019.04 ~ 2021.03</td>
        	    				<td class="table-td-none">JAVA 솔루션 개발 및 서비스 유지보수</td>
        	    			</tr>
        	    			<tr>
        	    				<td>경력</td>
        	    				<td>(주)앤토스</td>
        	    				<td>연구원(개발1팀)</td>
        	    				<td>2018.09 ~ 2019.02</td>
        	    				<td class="table-td-none">C++ 간단한 유지보수 및 문서작성 </td>
        	    			</tr>
        	    		</tbody>
        	    	</table>
        	    </div>
        	</div>
        	<div class="content-project"> <!-- 경력 및 참여 프로젝트 -->
        	    <div class="content-title">
        	    	<h1><i class="fas fa-angle-right"></i>&nbsp;참여 프로젝트</h1>
        	    </div>
        	    <div class="content-project-work">
        	    	<div class="content-project-data">
        	    		<div class="content-project-title">
        	    			<a><i class="fas fa-circle"></i>&nbsp;화성시 사회적 경제기업 정보관리 시스템</a>
        	    			<span class="lcon-leg">JAVA</span>
        	    			<span class="lcon-frame">eGovFrame</span>
        	    			<span class="lcon-ui">Nexacro</span>
        	    			<span class="lcon-db">Oracle</span>
        	    			<span class="lcon-was">JEUS</span>
        	    			<span class="lcon-svn">SVN</span>
        	    			<span class="lcon-os">Windows</span>
        	    		</div>
        	    		<div class="content-project-text">
        	    			<div class="content-project-text-title">개발 기간 : 2019.06 ~ 2020.01&nbsp;&nbsp;유지보수 : ~ 2020.05</div>
        	    			<p>화성시 기업  관리 시스템 구축 및 유지보수</p>
        	    		</div>
        	    	</div>
        	    	
        	    	<div class="content-project-data">
        	    		<div class="content-project-title">
        	    			<a><i class="fas fa-circle"></i>&nbsp;프로스포츠 협회 데이터 포털</a>
        	    		    <span class="lcon-leg">JAVA</span>
        	    			<span class="lcon-frame">eGovFrame</span>
        	    			<span class="lcon-ui">JSP</span>
        	    			<span class="lcon-jq">JQuery</span>
        	    			<span class="lcon-db">MySQL</span>
        	    			<span class="lcon-was">Tomcat</span>
        	    			<span class="lcon-svn">SVN</span>
        	    			<span class="lcon-os">CentOS</span>
        	    		</div>
        	    		<div class="content-project-text">
        	    			<div class="content-project-text-title">개발 기간 : 2019.10 ~ 2020.03</div>
        	    			<p>축구, 야구, 농구, 등 여러 스포츠의 정보 및 데이터 통계 관리하는 사이트 구축 및 유지보수</p><br>
        	    			<p>이용 API : ClipReport, AmchartAPI</p>
        	    		</div>
        	    	</div>
        	    	
        	    	<div class="content-project-data">
        	    		<div class="content-project-title">
        	    			<a><i class="fas fa-circle"></i>&nbsp;충북학사 정보관리 시스템</a>
        	    		    <span class="lcon-leg">JAVA</span>
        	    			<span class="lcon-frame">eGovFrame</span>
        	    			<span class="lcon-ui">Nexacro</span>
        	    			<span class="lcon-db">MSSQL</span>
        	    			<span class="lcon-was">Tomcat</span>
        	    			<span class="lcon-svn">SVN</span>
        	    			<span class="lcon-os">Windows</span>
        	    		</div>
        	    		<div class="content-project-text">
        	    			<div class="content-project-text-title">개발 기간 : 2020.04 ~ 2020.12&nbsp;&nbsp;유지보수 : ~ 2021.03</div>
        	    			<p>본 개발예정 인원의 퇴사로 개발초기단계 인수인계 받아 충북학사 기숙사 입사관리, 학생관리 시스템 구현 </p><br>
        	    			<p>이용 API : ClipReport</p>
        	    		</div>
        	    	</div>
        	    	
        	    	<div class="content-project-data">
        	    		<div class="content-project-title">
        	    			<a><i class="fas fa-circle"></i>&nbsp;충북학사 출입관리 시스템</a>
        	    		    <span class="lcon-leg">C#</span>
        	    			<span class="lcon-frame">.NET</span>
        	    			<span class="lcon-db">MSSQL</span>
        	    			<span class="lcon-os">Windows</span>
        	    		</div>
        	    		<div class="content-project-text">
        	    			<div class="content-project-text-title">개발 기간 : 2020.04 ~ 2020.05&nbsp;&nbsp;유지보수 : ~ 2021.03</div>
        	    			<p>개발예정 인원의 퇴사로 당장 인원보충이 힘들어 기술스택에 없는 C#, .NET 을 구글링을 통해 개발</p>
        	    		</div>
        	    	</div>
        	    	
        	    	<div class="content-project-data">
        	    		<div class="content-project-title">
        	    			<a><i class="fas fa-circle"></i>&nbsp;농촌지능청 흙토람 ActiveX 플러그인 제거</a>
        	    		    <span class="lcon-leg">JAVA</span>
        	    			<span class="lcon-frame">Servlet</span>
        	    			<span class="lcon-ui">JSP</span>
        	    			<span class="lcon-jq">JQuery</span>
        	    			<span class="lcon-db">TiberoDB</span>
        	    			<span class="lcon-was">JEUS</span>
        	    			<span class="lcon-os">CentOS</span>
        	    		</div>
        	    		<div class="content-project-text">
        	    			<div class="content-project-text-title">개발 기간 : 2020.04 ~ 2020.05&nbsp;&nbsp;유지보수 : ~ 2021.03</div>
        	    			<p>ActiveX 서비스 중지로 인하여 기 운영되던 사이트 에서 ActiveX 로 구현되어있는 출력물 및 사이트 화면 을 HTML5로 재구현 <br>
							ActiveX에서 HTML5 로 변경함에 따라 지원하지 않는 기능 발생에 따라 별도 API를 사용하여 ActiveX와 동일한 기능 HTML5에서 사용가능하게끔 구현</p><br>
        	    			<p>이용 API : CrownixReport, PDFBoxAPi</p>
        	    		</div>
        	    	</div>
        	    	
        	    	<div class="content-project-data">
        	    		<div class="content-project-title">
        	    			<a><i class="fas fa-circle"></i>&nbsp;경기주택도시공사 보증금 이자지원 사업</a>
        	    		    <span class="lcon-leg">JAVA</span>
        	    			<span class="lcon-frame">eGovFrame</span>
        	    			<span class="lcon-ui">JSP</span>
        	    			<span class="lcon-ui">Nexacro</span>
        	    			<span class="lcon-jq">JQuery</span>
        	    			<span class="lcon-db">TiberoDB</span>
        	    			<span class="lcon-was">JEUS</span>
        	    			<span class="lcon-os">CentOS</span>
        	    		</div>
        	    		<div class="content-project-text">
        	    			<div class="content-project-text-title">개발 기간 : 2020.04 ~ 2020.05&nbsp;&nbsp;유지보수 : ~ 2021.03</div>
        	    			<p>기 운영되던 청약사이트에서 이자지원부분 파트 구현  <br>
        	    			보증금 이자지원 신청 및 신청의 조건에 대해 얼마 지원 해줄수있는지 지원금 계산 및 문자발송 데이터관리 사이트<br>
        	    			사용자 고객 이자지원 신청 화면은 JSP로 프론트 화면 구성<br>
        	    			아지지원 신청 관리 화면은 Nexacro 프론트 화면 구성 </p>
        	    			<p>이용 API : 인포뱅크 문자서비스, CrownixReport</p>
        	    		</div>
        	    	</div>
        	    </div>
        	</div>
        	<div class="content-file"> <!-- 자소서 이력서 포폴 파일 -->
        	    <div class="content-title">
        	    	<h1><i class="fas fa-angle-right"></i>&nbsp;이력서 및 자소서 기타 자료</h1>
        	    </div>
        	    <div class="content-file-work">
        	    	<div class="content-file-data">
        	    		이력서<br></br>
        	    		<i class="far fa-id-card"></i>
        	    	</div>
        	    	<div class="content-file-data">
        	    		자기소개서<br></br>
        	    		<i class="far fa-file-alt"></i>
        	    	</div>
        	    	<div class="content-file-data">
        	    		경력인증서<br></br>
        	    		<i class="fas fa-file-pdf"></i>
        	    	</div>
        	    </div>
        	</div>
        	<div class="content-maps"> <!-- 구글 api maps -->
        	    <div class="content-title">
        	    	<h1><i class="fas fa-angle-right"></i>&nbsp;사는곳</h1>
        	    </div>
        	    <div id="map"></div>
        	</div>
        	<div class="content-bbs"> <!-- 참조 링크 및 게시판 형식-->
        	    <div class="content-title">
        	    	<h1><i class="fas fa-angle-right"></i>&nbsp;참조링크 및 게시판</h1>
        	    </div>
        	    <div class="content-bbs-serach">
        	    	<input class="content-bbs-search-text" type="text" placeholder="제목입력..."></input>
        	    	<input class="content-bbs-search-btn" type="button" value="검색"></input>
        	    </div>
        	    <div class="content-bbs-table">
        	    	<table>
						<colgroup>
							<col width="50px"/>
							<col width="80px"/>
							<col width="*"/>
							<col width="150px"/>
						</colgroup>
        	    		<thead>
        	    			<tr>
        	    				<th>NO</th>
        	    				<th>구분</th>
        	    				<th>제목</th>
        	    				<th class="table-td-none">등록일</th>
        	    			</tr>
        	    		</thead>
        	    		<tbody>
        	    			<tr onclick="javascript:showPopup()">
        	    				<td>1</td>
        	    				<td>링크</td>
        	    				<th>화성시 경제기업 정보관리 시스템</th>
        	    				<td class="table-td-none">2021.05.16</td>
        	    			</tr>
        	    			<tr onclick="javascript:showPopup()">
        	    				<td>2</td>
        	    				<td>링크</td>
        	    				<td>충북학사 기숙사시스템 학생웹</td>
        	    				<td class="table-td-none">2021.05.16</td>
        	    			</tr>
        	    			<tr onclick="javascript:showPopup()">
        	    				<td>3</td>
        	    				<td>링크</td>
        	    				<td>농촌지능청 흙토람</td>
        	    				<td class="table-td-none">2021.05.16</td>
        	    			</tr>
        	    			<tr onclick="javascript:showPopup()">
        	    				<td>4</td>
        	    				<td>링크</td>
        	    				<td>경기주택도시공사 청약센터 이자지원신청</td>
        	    				<td class="table-td-none">2021.05.16</td>
        	    			</tr>
        	    			<tr onclick="javascript:showPopup()">
        	    				<td>5</td>
        	    				<td>게시물</td>
        	    				<td>테스트 게시물입니다.</td>
        	    				<td class="table-td-none">2021.05.16</td>
        	    			</tr>
        	    		</tbody>
        	    	</table>
        	    </div>
        	    <div class="content-bbs-page">
        	    	<span><i class="fas fa-angle-left"></i></span>
        	    	<span>1</span>
       	    		<span>2</span>
       	    		<span>3</span>
       	    		<span>4</span>
       	    		<span>5</span>
        	    	<span><i class="fas fa-angle-right"></i></span>
        	    </div>
        	</div>
        </div>
       	<div class="footer">
       		<div class="footer-left">
	       		본 홈페이지는 취업준비기간 포토폴리오 준비 및 개발능력 보존을 위해 구축 홈페이지 입니다. <br><br>
       		</div>
       		<div class="footer-right">
	       		<div class="footer-admin-btn">ADMIN PAGE</div>
	       		<div>Copyright 2021. 이광석 All pictures cannot be copied without permission. </div>
       		</div>
       	</div>
   </div>
   <!-- bbs 팝업 -->
   <div class="contents-bbs-popup hide">
	  <div class="content">
	    <p>
	      여기에 팝업창 내용이 나타납니다.
	    </p>
	    <button onclick="closePopup()">닫기</button>
	  </div>
   </div>
</body>
</html>
