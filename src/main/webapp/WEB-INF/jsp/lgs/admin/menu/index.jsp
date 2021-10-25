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
		comboLoad("combo-gubun", "MG001", "SELECT");

		serachMenuList();

		const iptMenu = document.getElementById("menu");
		const bntSave = document.getElementById("btn-save");
		const btnSearch = document.getElementById("btn-search");

		/* 엔터 조회 */
		addEnter("search-menu-name", function(){
			btnSearch.click();
		});

		bntSave.disabled = true;

		/* 조회 버튼 클릭 */
		btnSearch.onclick = function(){
			let val = document.getElementById("search-menu-name").value;
			$('#jstree_div').jstree(true).search(val);
		}

		/* 메뉴 에디터 박스 수정 (중복확인) */
		iptMenu.onchange = function(){
			let url = '/admin/menu/overlapMenu';
			let data = {code : iptMenu.value};

			ajaxLoad(url, data, "text", function(data){
				if(data == 1){
					gfnAlert("중복 된 메뉴가 있습니다.", function(){
						iptMenu.value = "";
						iptMenu.focus();
					});
				}
			});
		}

		/* 저장 버튼 클릭 */
		bntSave.onclick = function(){
			gfnConfirm("저장 하시겠습니까?", function (result) {
				if(result){
					let status = document.getElementById("status").value;

					document.getElementById("menu").disabled = false;

					let url = "";
					if(status == 'I'){ /* 신규 */
						url = "/admin/menu/insert";
					} else if(status == "U"){ /* 수정 */
						url = "/admin/menu/update";
					}

					let data = { menu : document.getElementById("menu").value
						, menuName : document.getElementById("menu-name").value
						, url : document.getElementById("menu-url").value
						, upperMenu : document.getElementById("upper-menu").value
						, remark : document.getElementById("menu-remark").value
						, gubun : document.getElementById("gubun").value
						, useyn : document.getElementById("useyn").value};

					ajaxLoad(url, data, "text", function () {
						document.getElementById("menu").disabled = true;
						gfnAlert("저장 되었습니다.", function(){
							location.reload();
						});
					});
				}
			});
		}
	}

	/* 메뉴 트리 리스트 조회 */
	function serachMenuList(){
		let url = "/admin/menu/list";

		ajaxLoad(url, null, "json", function (data) {

			document.getElementById("list-cnt").innerText = data.menuCnt;

			let $jstree = $('#jstree_div');

			/* jstree 설정 및 그리기 */
			$jstree.jstree({
				"core": {
					"check_callback": true,
					data: data.menuList
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
								"label": "신규메뉴",
								"action": function (obj) {
									let sNode = $jstree.jstree(true).get_selected(true)[0];
									if (sNode.original.id == undefined) {
										gfnAlert("메뉴를 등록할 수 없습니다.");
									} else {
										let newNode = { parent: sNode.original.id
											, text : "신규 메뉴"};

										$node = $jstree.jstree(true).create_node($node, newNode);
										$jstree.jstree(true).edit($node);
									}
								}
							},
							"Delete": {
								"separator_before": false,
								"separator_after": false,
								"label": "메뉴삭제",
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
										gfnAlert("하위 메뉴가 존재합니다.\n\n하위 메뉴부터 삭제 후 다시 시도하세요.");
									} else {
										gfnConfirm("선택하신 메뉴를 삭제 하시겠습니까?", function(result){
											if(result){

												let url = "/admin/menu/delete";
												let data = {menu : sNode.original.id};

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

	/* 메뉴 상세 데이터 변경 */
	function fn_setForm(data){

		if(data.node.original.id == null){
			document.getElementById("menu").disabled = false;
			document.getElementById("menu").value = "";
			document.getElementById("menu-name").value = "";
			document.getElementById("menu-url").value = "";
			document.getElementById("menu-remark").value = "";
			document.getElementById("upper-menu").value = data.node.original.parent;

			selectOption("combo-gubun", "bbs", "value");
			selectOption("combo-useyn", "Y", "value");
			document.getElementById("useyn").value = 'Y';
			document.getElementById("gubun").value = 'bbs';
			document.getElementById("status").value = "I";
		} else {
			document.getElementById("menu").disabled = true;
			document.getElementById("menu").value = data.node.original.id;
			document.getElementById("menu-name").value = data.node.original.text;
			document.getElementById("upper-menu").value = data.node.original.parent;

			if(!nullChk(data.node.original.menu_url)){
				document.getElementById("menu-url").value = data.node.original.menu_url;
			} else {
				document.getElementById("menu-url").value = "";
			}

			if(!nullChk(data.node.original.remark)){
				document.getElementById("menu-remark").value = data.node.original.remark;
			} else {
				document.getElementById("menu-remark").value = "";
			}

			selectOption("combo-gubun", data.node.original.menu_gubun, "value");
			selectOption("combo-useyn", data.node.original.use_yn, "value");

			document.getElementById("useyn").value = data.node.original.use_yn;
	        document.getElementById("gubun").value = data.node.original.menu_gubun;

			document.getElementById("status").value = "U";
		}
	}
</script>
<body>
	<input type="hidden" id="status">
	<input type="hidden" id="upper-menu">
	<div class="content">
		<div class="content-title">
			<i class="fas fa-caret-right"></i>
			<h2>메뉴관리</h2>
			<div class="title-info">
				<h2>시스템관리 <i class="fas fa-caret-right"></i> 메뉴관리</h2>
			</div>
		</div>
		<div class="content-serach-form">
			<div class="content-serach-item">
				<label>메뉴명</label>
				<input id="search-menu-name" type="text">
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
					<div>메뉴</div>
					<div class="label-info">메뉴 우측 클릭시 추가 삭제 가능</div>
				</div>
				<div id="jstree_div"></div>
			</div>
			<div class="work-detail">
				<div class="detail-label">
					<div>상세정보</div>
				</div>
				<div class="row">
					<label>메뉴코드</label>
					<input type="text" id="menu" placeholder="메뉴코드">
				</div>
				<div class="row">
					<label>메뉴명</label>
					<input type="text" id="menu-name" placeholder="메뉴명">
				</div>
				<div class="row">
					<label>메뉴URL</label>
					<input type="text" id="menu-url" placeholder="메뉴URL">
				</div>
				<div class="row">
					<label>메뉴구분</label>
					<input type="hidden" name="gubun" id="gubun">
					<select id="combo-gubun"></select>
				</div>
				<div class="row">
					<label>비고</label>
					<input type="text" id="menu-remark" placeholder="비고">
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