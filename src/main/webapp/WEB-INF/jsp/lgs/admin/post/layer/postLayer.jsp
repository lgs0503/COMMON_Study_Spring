<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 서머노트 에디터 -->
<script src="/plugin/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/plugin/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/plugin/summernote-0.8.18-dist/summernote-lite.css">
<style>
    .note-modal-backdrop{
        z-index:50;
    }
    .note-editable{
        background-color:white;
    }
</style>
<script type="text/javascript">

    /* 레이어 로드 이벤트 대용 */
    function loadLayer(type = null, param = null){

        let $content = $('#post-content');
        $content.summernote({
            height: 200,
            minHeight: 200,
            maxHeight: 300,
            placeholder: '내용을 입력해주세요',
            lang: "ko-KR",
            focus : true,
            toolbar: [
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                ['color', ['forecolor','color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert',['picture','link','video']],
                ['view', ['codeview','fullscreen', 'help']]
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
        });

        $content.summernote('reset');

        let layerType = "I";

        const btnSave = document.getElementById("btn-save");
        const btnDelete = document.getElementById("btn-delete");

        const eleId = [ "post", "bbs", "post-title"];

        /* 상세정보 일 경우 */
        if(type == "U"){
            btnDelete.style.display = "inline-block";

            layerType = type;

            let data = {post: param};
            let url = '/admin/post/read';

            ajaxLoad(url, data, "json", function(result){

                const resultData = [ result.post[0].POST_NO
                                   , result.post[0].BBS_NO
                                   , result.post[0].POST_TITLE];

                eleId.forEach(function (value, index) {
                    if(!nullChk(resultData[index])){
                        document.getElementById(value).value = resultData[index];
                    }
                });

                $content.summernote('code', result.post[0].POST_CONTENT);
            });
        } else { /* 신규 */
            btnDelete.style.display = "none";

            eleId.forEach(function (value) {
                document.getElementById(value).value = "";
            });
        }

        /* 저장 버튼 클릭 */
        btnSave.onclick = function () {

            gfnConfirm("저장하시겠습니까?", function (result) {
                if(result){
                    /*유효성 체크 결과값 이 실패면 종료*/
                    if (validate() == -1) {
                        return;
                    }

                    let url = "";

                    if(layerType == "I") { /* 신규 */
                        url = '/admin/post/insert';
                    } else if(layerType == "U") { /* 수정 */
                        url = '/admin/post/update';
                    }

                    let data = $("#post-form").serialize();

                    ajaxLoad(url, data, "text", function(){
                        gfnAlert("저장완료", function () {

                            let btnClose = document.getElementById("btn-layer-close");
                            btnClose.click();

                            searchList();
                        });
                    });
                }
            });
        }

        /* 삭제 버튼 클릭 */
        btnDelete.onclick = function () {
            gfnConfirm("정말 게시글 을 삭제 하시겠습니까?", function(result){
                if(result){
                    let data = {post: param};
                    let url = '/admin/post/delete';

                    ajaxLoad(url, data, "text", function(result){
                        gfnAlert("삭제되었습니다.", function(){
                            let btnClose = document.getElementById("btn-layer-close");
                            btnClose.click();

                            searchList();
                        });
                    });
                }
            })
        }

        //$('#layer-member').draggable({handle: ".layer-header"});
        openLayer("layer-form");
    };

    /*유효성 체크*/
    function validate(){
        // input 태그
        const validationInputChkId = ["post-title","post-content"];
        const validationInputChkIdText = ["게시글 제목", "게시글 내용"];

        /* 필수값 체크 */
        for(let i = 0 ; i < validationInputChkId.length ; i++){
            let ele = document.getElementById(validationInputChkId[i]);

            if(nullChk(ele.value)){
                gfnAlert("("+validationInputChkIdText[i]+ ")는 필수 입력 값 입니다.", function () {
                    ele.focus();
                });
                return -1;
                break;
            }
        }
    }
</script>
<form id="post-form">
    <input type="hidden" name="post" id="post">
    <input type="hidden" name="bbs" id="bbs">
    <div class="layer-form" id="layer-form">
        <div class="layer-header">
            <div class="layer-title">게시글정보</div>
            <div class="later-close-btn" id="btn-layer-close">
                <i class="fas fa-times"></i>
            </div>
        </div>
        <div class="layer-work layer-post-work">
            <div class="layer-col-post">
                <div class="layer-tr-post">
                    <label>제목</label>
                    <input type="text" name="post-title" id="post-title" placeholder="게시글제목" maxlength="15">
                </div>
                <div class="layer-tr-post layer-tr-post-file">
                    <label>파일</label>
                    <input type="file" name="file1" id="file1" >
                    <input type="file" name="file2" id="file2" >
                </div>
                <div class="layer-tr-post">
                    <textarea id="post-content" name="post-content"></textarea>
                </div>
            </div>
        </div>
        <div class="layer-btn">
            <input id="btn-save" class="btn-cmmn" type="button" value="저장">
            <input id="btn-delete" class="btn-cmmn" type="button" value="삭제">
        </div>
    </div>
</form>
<div class="backgnd-block-layer" id="backgnd-block-layer"></div>