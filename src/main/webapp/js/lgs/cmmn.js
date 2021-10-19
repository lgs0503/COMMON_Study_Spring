/* 공통 ajax 통신 */
function ajaxLoad( url
                 , data
                 , dataType
                 , callbackFn
                 , processData = true
                 , contentType = 'application/x-www-form-urlencoded; charset=UTF-8') {

    let ajaxData = { url: url
        , type: 'POST'
        , processData : processData
        , contentType : contentType
        , dataType: dataType
        , success: callbackFn
        , error: function (request, status, error) {
            console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
        }};

    if(data != null){
        ajaxData.data = data;
    }

    $.ajax(ajaxData);
}

/* 바닐라 js json처리*/
function serialize(rawData) {
    let rtnData = {};
    for (let [key, value] of rawData) {
        let sel = document.querySelectorAll("[name=" + key + "]");
        // Array Values
        if (sel.length > 1) {
            if (rtnData[key] === undefined) {
                rtnData[key] = [];
            }
            rtnData[key].push(value);
        } // Other
        else {
            rtnData[key] = value;
        }
    }
    return rtnData;
}

/* 이미지 섬네일 읽기 */
function readImage(input, preview) {
    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {
        // 이미지 파일인지 검사 (생략)
        // FileReader 인스턴스 생성
        const reader = new FileReader()
        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById(preview);
            previewImage.src = e.target.result
        }
        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
}

/* input 태그 숫자만 입력 되게 */
function inputOnlyNumber(inputId){
    const ele = document.getElementById(inputId);

    ele.oninput = function () {
        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
    }
}

/* 콤보박스 로드 */
function comboLoad(selectId, upperCode, type){

    let url = '/selectCode';
    let data = {upperCodeNo : upperCode};

    ajaxLoad(url, data, "json", function(result){

        const sel = document.getElementById(selectId);
        let typeOption = document.createElement("option");

        if(type == "ALL"){
            typeOption.text = "전체";
        } else if(type == "SELECT"){
            typeOption.text = "선택";
        }

        if(type != null && type != ''){
            typeOption.value = "";
            sel.appendChild(typeOption);
        }

        result.codeList.forEach(function(value){
            let option = document.createElement("option");

            option.value = value["CODE_VAL"];
            option.text = value["CODE_NAME"];

            sel.appendChild(option);
        });

        /* 클릭이벤트 - 히든 데이터 넣어주기 */
        sel.onclick = function(){
            const hidden = document.getElementById(selectId.replace("combo-",""));
            hidden.value = this.value;
        }
    });
}

/* YYYY-MM-DD 형태의 문자를 YYYYMMDD 형태로 변환 (-)하이푼 제거 */
function fncDateToStr(argDate){
    let tmp = '';

    if(argDate !== undefined){
        let regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
        tmp = String(argDate).replace(/(^\s*)|(\s*$)/gi, '').replace(regExp, ''); // 공백 및 특수문자 제거
    }
    return tmp;
}

/* 쿠키 추가 */
function setCookie(cookieName, value, exdays){
    let exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    let cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

/* 쿠키 삭제 */
function deleteCookie(cookieName){
    let expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

/* 쿠키 찾기 */
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    let cookieData = document.cookie;
    let start = cookieData.indexOf(cookieName);
    let cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        let end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
/* 변수 널체크 */
function nullChk (data){
    if(data == null || data == '' || data == 'undifined' || data == 'none'){
        return true;
    } else {
        return false;
    }
}
/* base64 데이터 이미지 사용 하게 변경*/
function base64Img(base64str){
    return "data:image/png;base64,"+base64str;
}

