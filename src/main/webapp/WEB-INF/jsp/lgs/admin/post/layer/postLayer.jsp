<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

    /* 레이어 로드 이벤트 대용 */
    function loadLayer(type = null, param = null){
        let layerType = "I";

        const btnSave = document.getElementById("btn-save");
        const btnDelete = document.getElementById("btn-delete");
        const iptBbs = document.getElementById("bbs");
        const btnPost = document.getElementById("btn-post");

        const eleId = [ "bbs", "bbs-name-layer", "bbstype"
                      , "useyn", "commentUseyn", "fileUseyn"
                      , "remark"];

        /* 상세정보 일 경우 */
        if(type == "U"){
            iptBbs.disabled = true;
            btnPost.style.display = "inline-block";
            btnDelete.style.display = "inline-block";

            layerType = type;

            let data = {bbs: param};
            let url = '/admin/bbs/read';

            ajaxLoad(url, data, "json", function(result){

                const resultData = [ result.bbs[0].BBS_NO
                                   , result.bbs[0].BBS_NAME
                                   , result.bbs[0].BBS_TYPE
                                   , result.bbs[0].USE_YN
                                   , result.bbs[0].COMMENT_USE_YN
                                   , result.bbs[0].FILE_USE_YN
                                   , result.bbs[0].REMARK ];

                eleId.forEach(function (value, index) {
                    if(!nullChk(resultData[index])){
                        document.getElementById(value).value = resultData[index];
                    }
                });

                setTimeout(function(){
                    selectOption("combo-useyn", result.bbs[0].USE_YN, "value");
                    selectOption("combo-commentUseyn", result.bbs[0].COMMENT_USE_YN, "value");
                    selectOption("combo-fileUseyn", result.bbs[0].FILE_USE_YN, "value");
                    selectOption("combo-bbstype-layer", result.bbs[0].BBS_TYPE, "value");
                }, 200);
            });
        } else { /* 신규 */
            iptBbs.disabled = false;
            btnDelete.style.display = "none";
            btnPost.style.display = "none";

            eleId.forEach(function (value) {
                document.getElementById(value).value = "";
            });
        }

        comboLoad("combo-useyn", "U001", "SELECT");
        comboLoad("combo-commentUseyn", "U001", "SELECT");
        comboLoad("combo-fileUseyn", "U001", "SELECT");
        comboLoad("combo-bbstype-layer", "B001", "SELECT");

        /* 게시판번호 체인지 - 중복확인 */
        iptBbs.onchange = function(){

            let url = '/admin/bbs/overlapBbs';
            let data = {bbs : this.value};

            ajaxLoad(url, data, "text", function(data){
                if(data == 1){
                    gfnAlert("중복 된 게시판번호가 있습니다.", function(){
                        iptBbs.value = "";
                        iptBbs.focus();
                    });
                }
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

                    iptBbs.disabled = false;

                    let url = "";

                    if(layerType == "I") { /* 신규 */
                        url = '/admin/bbs/insert';
                    } else if(layerType == "U") { /* 수정 */
                        url = '/admin/bbs/update';
                    }

                    let data = $("#bbs-form").serialize();

                    ajaxLoad(url, data, "text", function(){
                        gfnAlert("저장완료", function () {
                            iptBbs.disabled = true;

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
            gfnConfirm("정말 게시판 정보를 삭제 하시겠습니까?", function(result){
                if(result){
                    let data = {bbs: param};
                    let url = '/admin/bbs/delete';

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

        /* 게시글 보기 버튼 클릭 */
        btnPost.onclick = function(){
            location.href = "/admin/post?bbs="+iptBbs.value;
        }

        //$('#layer-member').draggable({handle: ".layer-header"});
        openLayer("layer-member");
    };


    /*유효성 체크*/
    function validate(){

        // input 태그
        const validationInputChkId = ["bbs", "bbs-name-layer"];
        const validationInputChkIdText = ["게시판번호", "게시판이름"];

        // select 태그
        const validationComboChkId = ["combo-bbstype-layer", "combo-useyn", "combo-commentUseyn", "combo-fileUseyn"];
        const validationComboChkIdText = ["게시판타입", "사용여부", "댓글사용여부", "파일사용여부"];

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

            if(nullChk(ele.value)){
                gfnAlert("("+validationComboChkIdText[i]+ ")는 필수 선택 값 입니다.", function () {
                    ele.focus();
                });
                return -1;
                break;
            }
        }
    }
</script>
<form id="bbs-form">
    <div class="layer-member" id="layer-member">
        <div class="layer-header">
            <div class="layer-title">게시글정보</div>
            <div class="later-close-btn" id="btn-layer-close">
                <i class="fas fa-times"></i>
            </div>
        </div>
        <div class="layer-work">
            <div class="layer-col">
                <div class="layer-tr">
                    <label>제목</label>
                    <input type="text" name="bbs" id="bbs" placeholder="게시판번호" maxlength="15">
                </div>
                <div class="layer-tr">
                    <label>내용</label>
                    <input type="text" name="bbsName" id="bbs-name-layer" placeholder="게시판이름" maxlength="15">
                </div>
                <div class="layer-tr">
                    <label>파일</label>
                    <input type="text" name="bbsName" id="file1" placeholder="게시판이름" maxlength="15">
                    <input type="text" name="bbsName" id="file2" placeholder="게시판이름" maxlength="15">
                </div>
            </div>
        </div>
        <div class="layer-btn">
            <input id="btn-post" class="btn-cmmn" type="button" value="게시물 보기">
            <input id="btn-save" class="btn-cmmn" type="button" value="저장">
            <input id="btn-delete" class="btn-cmmn" type="button" value="삭제">
        </div>
    </div>
</form>

<div class="backgnd-block-layer" id="backgnd-block-layer"></div>