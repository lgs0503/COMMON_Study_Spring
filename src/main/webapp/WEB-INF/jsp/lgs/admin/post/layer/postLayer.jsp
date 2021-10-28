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
            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
            callbacks: { /* 서머노트 이미지 업로드 */
                onImageUpload : function(files) {
                    uploadSummernoteImageFile(files[0], this);
                },
                onPaste: function (e) {
                    var clipboardData = e.originalEvent.clipboardData;
                    if (clipboardData && clipboardData.items && clipboardData.items.length) {
                        var item = clipboardData.items[0];
                        if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
                            e.preventDefault();
                        }
                    }
                }
            }
        });

        $content.summernote('reset');

        comboLoad("combo-poststatus-layer", "P001", "SELECT");
        comboLoad("combo-bbs-layer", "BBS", "SELECT");

        let layerType = "I";

        const btnSave = document.getElementById("btn-save");
        const btnDelete = document.getElementById("btn-delete");
        const btnComment = document.getElementById("btn-comment");
        const comboBbs = document.getElementById("combo-bbs-layer");
        const iptfile1 = document.getElementById("file1");
        const iptfile2 = document.getElementById("file2");

        const eleId = [ "post", "bbs", "post-title", "poststatus", "post-file1", "post-file2"];

        iptfile1.value = "";
        iptfile2.value = "";

        /* 상세정보 일 경우 */
        if(type == "U"){
            btnDelete.style.display = "inline-block";

            layerType = type;

            let data = {post: param};
            let url = '/admin/post/read';

            ajaxLoad(url, data, "json", function(result){

                const resultData = [ result.post[0].POST_NO
                    , result.post[0].BBS_NO
                    , result.post[0].POST_TITLE
                    , result.post[0].POST_STATUS
                    , result.post[0].FILE_NO
                    , result.post[0].FILE_NO2];

                eleId.forEach(function (value, index) {
                    if(!nullChk(resultData[index])){
                        document.getElementById(value).value = resultData[index];
                    }
                });

                $content.summernote('code', result.post[0].POST_CONTENT);

                setTimeout(function(){
                    selectOption("combo-bbs-layer", result.post[0].BBS_NO, "value");
                    selectOption("combo-poststatus-layer", result.post[0].POST_STATUS, "value");

                    let file = comboBbs.options[comboBbs.selectedIndex].dataset.file;
                    let comment = comboBbs.options[comboBbs.selectedIndex].dataset.comment;

                    const fileFrm = document.getElementById("file-form");

                    if(file == 'Y'){
                        fileFrm.style.display = "block";
                    } else {
                        fileFrm.style.display = "none";
                    }

                    if(comment == 'Y'){
                        btnComment.style.display ="inline-block";
                    } else {
                        btnComment.style.display= "none";
                    }

                    comboBbs.disabled = true;
                }, 200);
            });
        } else { /* 신규 */
            btnDelete.style.display = "none";
            btnComment.style.display= "none";
            document.getElementById("combo-bbs-layer").disabled = false;

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

                    /* promise를 이용한 비동기 통신 */
                    new Promise(function(resolve, reject){
                        /* 첫파일 저장 */
                        if(!nullChk(iptfile1.value)){
                            /* 프로필 사진 업로드*/
                            let url = '/fileUpload';
                            let data = new FormData();
                            data.append("file", iptfile1.files[0]);

                            ajaxLoad(url, data, "text", function(result){
                                resolve(result);
                            }, false, false);
                        } else {
                            resolve();
                        }

                    }).then(function(resolve) {
                        /* 두번째 파일 저장 */
                        if (!nullChk(iptfile1.value)) {
                            document.getElementById("post-file1").value = resolve;
                        }

                        new Promise(function(resolve2, reject){
                            if(!nullChk(iptfile2.value)){
                                /* 프로필 사진 업로드*/
                                let url = '/fileUpload';
                                let data = new FormData();
                                data.append("file", iptfile2.files[0]);

                                ajaxLoad(url, data, "text", function(result){
                                    resolve2(result);
                                }, false, false);
                            } else {
                                resolve2();
                            }
                        }).then(function(resolve){
                            if (!nullChk(iptfile2.value)) {
                                document.getElementById("post-file2").value = resolve;
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

        /*게시판 콤보박스 체인지이벤트*/
        comboBbs.onchange = function(){
            iptfile1.value = "";
            iptfile2.value = "";

            let file = comboBbs.options[comboBbs.selectedIndex].dataset.file;

            const fileFrm = document.getElementById("file-form");

            if(file == 'Y'){
                fileFrm.style.display = "block";
            } else {
                fileFrm.style.display = "none";
            }
        }

        /* 게시글 보기 버튼 클릭 */
        btnComment.onclick = function(){
            location.href = "/admin/comment?post="+document.getElementById("post").value;
        }

        //$('#layer-member').draggable({handle: ".layer-header"});
        openLayer("layer-form");
    };

    /*유효성 체크*/
    function validate(){
        // input 태그
        const validationInputChkId = ["post-title","post-content"];
        const validationInputChkIdText = ["게시글 제목", "게시글 내용"];

        // select 태그
        const validationComboChkId = ["combo-bbs-layer", "combo-poststatus-layer"];
        const validationComboChkIdText = ["게시판", "타입"];

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
        for(let i = 0 ; i < validationComboChkId.length ; i++){
            let ele = document.getElementById(validationComboChkId[i]);
            let inputVal =  ele.value;

            if(nullChk(inputVal)){
                gfnAlert("("+validationComboChkIdText[i]+ ")는 필수 선택 값 입니다.",function () {
                    ele.focus();
                });
                return -1;
            }
        }
    }
</script>
<form id="post-form">
    <input type="hidden" name="postFileOne" id="post-file1">
    <input type="hidden" name="postFileTwo" id="post-file2">
    <input type="hidden" name="post" id="post">
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
                    <input type="text" name="postTitle" id="post-title" placeholder="게시글제목" maxlength="15">
                </div>
                <div class="layer-tr-post">
                    <textarea id="post-content" name="postContent" maxlength="100"></textarea>
                </div>
                <div class="layer-tr-post">
                    <input type="hidden" name="bbs" id="bbs">
                    <label>게시판</label>
                    <select id="combo-bbs-layer"></select>
                </div>
                <div class="layer-tr-post">
                    <input type="hidden" name="postStatus" id="poststatus">
                    <label>타입</label>
                    <select id="combo-poststatus-layer"></select>
                </div>
                <div class="layer-tr-post layer-tr-post-file" id="file-form">
                    <label>파일</label>
                    <input type="file" name="file1" id="file1" >
                    <input type="file" name="file2" id="file2" >
                </div>
            </div>
        </div>
        <div class="layer-btn">
            <input id="btn-comment" class="btn-cmmn" type="button" value="댓글확인">
            <input id="btn-save" class="btn-cmmn" type="button" value="저장">
            <input id="btn-delete" class="btn-cmmn" type="button" value="삭제">
        </div>
    </div>
</form>
<div class="backgnd-block-layer" id="backgnd-block-layer"></div>