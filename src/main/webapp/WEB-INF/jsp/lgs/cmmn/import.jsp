<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Open+Sans&family=Roboto&display=swap" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="/css/lgs/reset.css"/>
<link type="text/css" rel="stylesheet" href="/css/lgs/custom.css"/>
<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/lgs/cmmn.js?v=<%=System.currentTimeMillis() %>" defer></script>

<!-- 공통 커스텀 알림창 -->
<style>
    .backgnd-block{
        position: fixed;
        top: 0;
        left: 0;
        z-index: 100;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
        display: none;
    }
    .alert-cmmn{
        position: fixed;
        top: 50%;
        left: 50%;
        z-index: 200;
        transform: translate(-50%, -50%);
        background-color:var(--form-color);
        border-radius: 5px;
        display: none;
    }
    .alert-text{
        color:var(--title-color);
        font-size:20px;
        font-weight: bold;
        padding: 30px 30px 15px 30px;
        border-bottom: 1px solid var(--title-color);
        text-align: center;
        line-height: 30px;
    }
    .alert-btn{
        padding: 15px 30px 15px 30px;
        text-align: center;
    }
    .alert-btn > input{
        padding : 5px 20px;
    }
</style>
<div class="alert-cmmn" id="alert-cmmn">
    <div class="alert-text" id="alert-text">
        알림창
    </div>
    <div class="alert-btn">
        <input id="btn-ok" class="btn-cmmn" type="button" value="확인">
        <input id="btn-close" class="btn-cmmn" type="button" value="취소">
    </div>
</div>
<div class="backgnd-block" id="backgnd-block">
</div>