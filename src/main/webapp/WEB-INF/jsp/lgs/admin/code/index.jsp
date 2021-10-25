<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<style>
	.vakata-context, .vakata-context u{
		z-index:500;
	}
</style>
<script type="text/javascript">
	window.onload = function(){

		comboLoad("combo-useyn", "U001", "SELECT");

		inputOnlyNumber("code-sort");

		serachCodeList();

		const iptCode = document.getElementById("code");
		const bntSave = document.getElementById("btn-save");
		const btnSearch = document.getElementById("btn-search");

		/* 엔터 조회 */
		addEnter("search-code-name", function(){
			btnSearch.click();
		});

		bntSave.disabled = true;

		/* 조회 버튼 클릭 */
		btnSearch.onclick = function(){
			let val = document.getElementById("search-code-name").value;
			$('#jstree_div').jstree(true).search(val);
		}

		/* 코드 에디터 박스 수정 (중복확인) */
		iptCode.onchange = function(){
			let url = '/admin/code/overlapCode';
			let data = {code : iptCode.value};

			ajaxLoad(url, data, "text", function(data){
				if(data == 1){
					gfnAlert("중복 된 코드이 있습니다.", function(){
						iptCode.value = "";
						iptCode.focus();
					});
				}
			});
		}

		/* 저장 버튼 클릭 */
		bntSave.onclick = function(){
			gfnConfirm("저장 하시겠습니까?", function (result) {
				if(result){

				    let code = document.getElementById("code").value;
				    let codeName = document.getElementById("code-name").value;
                    let useyn = document.getElementById("useyn").value;

                    if(nullChk(code)){
                        gfnAlert("코드를 입력해주세요");
                        return;
                    } else if(nullChk(codeName)) {
                        gfnAlert("코드명를 입력해주세요");
                        return;
                    } else if(nullChk(useyn)) {
                        gfnAlert("사용여부를 선택해주세요");
                        return;
                    }

					let status = document.getElementById("status").value;

					document.getElementById("code").disabled = false;

					let url = "";
					if(status == 'I'){ /* 신규 */
						url = "/admin/code/insert";
					} else if(status == "U"){ /* 수정 */
						url = "/admin/code/update";
					}

					let data = { code :code
						, codeName : codeName
						, codeSort : document.getElementById("code-sort").value
						, upperCode : document.getElementById("upper-code").value
						, codeVal : document.getElementById("code-val").value
						, useyn : useyn};

					ajaxLoad(url, data, "text", function () {
						document.getElementById("code").disabled = true;
						gfnAlert("저장 되었습니다.", function(){
							location.reload();
						});
					});
				}
			});
		}
	}

	/* 코드 트리 리스트 조회 */
	function serachCodeList(){
		let url = "/admin/code/list";

		ajaxLoad(url, null, "json", function (data) {

			document.getElementById("list-cnt").innerText = data.codeCnt;

			let $jstree = $('#jstree_div');

			/* jstree 설정 및 그리기 */
			$jstree.jstree({
				"core": {
					"check_callback": true,
					data: data.codeList
				},
				"themes": {
					"theme": "classic",
					"dots": true,
					"icons": true
				},
				"plugins": ["contextmenu", "search"],
				"contextmenu": {
					"items": function ($node) {  /* 마우스 우클릭 이벤트 */
						return {
							"Create": {
								"separator_before": false,
								"separator_after": false,
								"label": "신규코드",
								"action": function (obj) {
									let sNode = $jstree.jstree(true).get_selected(true)[0];
									if (sNode.original.id == undefined) {
										gfnAlert("코드를 등록할 수 없습니다.");
									} else {
										let newNode = { parent: sNode.original.id
											, text : "신규 코드"};

										$node = $jstree.jstree(true).create_node($node, newNode);
										$jstree.jstree(true).edit($node);
									}
								}
							},
							"Delete": {
								"separator_before": false,
								"separator_after": false,
								"label": "코드삭제",
								"action": function (obj) {
									let sNode = $jstree.jstree(true).get_selected(true)[0];
									if (sNode.original.id == undefined) {
										let ref = $.jstree.reference(obj.reference),
												sel = ref.get_selected();
										if (!sel.length) {
											return false;
										}
										ref.delete_node(sel);

									} else if (sNode.original.id == 0) {
										gfnAlert("최상위 노드는 삭제 할 수 없습니다.");
									} else if (sNode.children.length > 0) {
										gfnAlert("하위 코드가 존재합니다.\n\n하위 코드부터 삭제 후 다시 시도하세요.");
									} else {
										gfnConfirm("선택하신 코드를 삭제 하시겠습니까?", function(result){
											if(result){

												let url = "/admin/code/delete";
												let data = {code : sNode.original.id};

												/* 삭제 ajax */
												ajaxLoad(url, data, "text", function () {
													gfnAlert("삭제 되었습니다.", function () {
														location.reload();
													});
												});
											}
										});
									}
								}
							}
						};
					}
				},
				"search" : { "show_only_matches" : true
					       , "show_only_matches_children" : true,
				}
			});

			/* 트리 노드 선택 이벤트 */
			$jstree.bind("select_node.jstree", function(evt, data){

				if(data.node.original.id != 0){
					fn_setForm(data);
				} else {
					$("input:text").val("");
				}
				//버튼 노출 분기처리 - root 수정 제외
				if(data.node.original.id == 0){
					document.getElementById("btn-save").disabled = true;
				} else {
					document.getElementById("btn-save").disabled = false;
				}
			});

			/* 트리 노드 생성 이벤트 */
			$jstree.bind('create_node.jstree', function (e, data) {
				fn_setForm(data);
			});

			/* 트리 로드 이벤트 -- 모두 펼치기 */
			$jstree.bind("loaded.jstree", function (event, data) {
				$(this).jstree("open_all");
			});

			/* 트리 펼치기 */
			document.getElementById("btn-treeOpen").onclick = function(){
				$jstree.jstree("open_all");
			}

			/* 트리 접기 */
			document.getElementById("btn-treeClose").onclick = function(){
				$jstree.jstree("close_all");
			}
		});
	}

	/* 코드 상세 데이터 변경 */
	function fn_setForm(data){

		if(data.node.original.id == null){
			document.getElementById("code").disabled = false;
			document.getElementById("code").value = "";
			document.getElementById("code-name").value = "";
			document.getElementById("code-sort").value = "";
			document.getElementById("code-val").value = "";
			document.getElementById("upper-code").value = data.node.original.parent;

			selectOption("combo-useyn", "y", "value");
			document.getElementById("useyn").value = 'Y';

			document.getElementById("status").value = "I";
		} else {
			document.getElementById("code").disabled = true;
			document.getElementById("code").value = data.node.original.id;
			document.getElementById("code-name").value = data.node.original.text;
			document.getElementById("upper-code").value = data.node.original.parent;

			if(!nullChk(data.node.original.sort_ordr)){
				document.getElementById("code-sort").value = data.node.original.sort_ordr;
			} else {
				document.getElementById("code-sort").value = 0;
			}

			if(!nullChk(data.node.original.code)){
				document.getElementById("code-val").value = data.node.original.code;
			} else {
				document.getElementById("code-val").value = "";
			}

			selectOption("combo-useyn", data.node.original.use_yn, "value");
			document.getElementById("useyn").value = data.node.original.use_yn;

			document.getElementById("status").value = "U";
		}
	}
</script>
<body>
	<input type="hidden" id="status">
	<input type="hidden" id="upper-code">
	<div class="content">
		<div class="content-title">
			<i class="fas fa-caret-right"></i>
			<h2>코드관리</h2>
			<div class="title-info">
				<h2>시스템관리 <i class="fas fa-caret-right"></i> 코드관리</h2>
			</div>
		</div>
		<div class="content-serach-form">
			<div class="content-serach-item">
				<label>코드명</label>
				<input id="search-code-name" type="text">
			</div>
			<input id="btn-search" class="btn-cmmn btn-search" type="button" value="조회">
		</div>
		<div class="content-top">
			<div class="list-cnt">
				<strong id="list-cnt">0</strong>개 조회
			</div>
			<div class="content-btn">
				<input id="btn-treeOpen" class="btn-cmmn btn-content" type="button" value="펼치기">
				<input id="btn-treeClose" class="btn-cmmn btn-content" type="button" value="접기">
				<input id="btn-save" class="btn-cmmn btn-content" type="button" value="저장">
			</div>
		</div>
		<div class="content-work flex">
			<div class="work-master" >
				<div class="detail-label">
					<div>코드</div>
					<div class="label-info">코드 우측 클릭시 추가 삭제 가능</div>
				</div>
				<div id="jstree_div"></div>
			</div>
			<div class="work-detail">
				<div class="detail-label">
					<div>상세정보</div>
				</div>
				<div class="row">
					<label>코드</label>
					<input type="text" id="code" placeholder="코드" maxlength="7">
				</div>
				<div class="row">
					<label>코드명</label>
					<input type="text" id="code-name" placeholder="코드명" maxlength="15">
				</div>
				<div class="row">
					<label>코드값</label>
					<input type="text" id="code-val" placeholder="코드값" maxlength="7">
				</div>
				<div class="row">
					<label>정렬</label>
					<input type="text" id="code-sort" placeholder="정렬" maxlength="5">
				</div>
				<div class="row">
					<label>사용여부</label>
					<input type="hidden" name="useyn" id="useyn">
					<select id="combo-useyn"></select>
				</div>
			</div>
		</div>
	</div>
</body>