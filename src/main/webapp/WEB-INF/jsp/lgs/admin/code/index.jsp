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
		/* 코드 트리 리스트 조회 */
		let url = "/admin/code/list";

		comboLoad("combo-useyn-list", "8", "SELECT");
		comboLoad("combo-useyn", "8", "SELECT");

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
					"items": function ($node) {
						return {
							"Create": {
								"separator_before": false,
								"separator_after": false,
								"label": "신규코드",
								"action": function (obj) {
									let sNode = $jstree.jstree(true).get_selected(true)[0];
									if (sNode.original.id == undefined) {
										alert("코드를 등록할 수 없습니다.");
									} else {
										$node = $jstree.jstree(true).create_node($node);
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
										alert("최상위 노드는 삭제할 수 없습니다.");
									} else if (sNode.children.length > 0) {
										alert("하위 코드가 존재합니다.\n\n하위 코드부터 삭제 후 다시 시도하세요.");
									} else {
										gfnConfirm("선택하신 코드를 삭제 하시겠습니까?", function(result){
											if(result){

												/* 삭제 ajax */



											}
										});
									}
								}
							}
						};
					}
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
					document.getElementById("btn-save").disable = true;
				} else {
					document.getElementById("btn-save").disable = false;
				}
			});

			/* 트리 노드 생성 이벤트 */
			$jstree.bind('create_node.jstree', function (e, data) {
				fn_setForm(data);
			});
		});

		const iptCode = document.getElementById("code");

		iptCode.onchange = function(){
			let url = '/code/overlapCode';
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
	}
	/* 코드 상세 데이터 변경 */
	function fn_setForm(data){
		if(data.node.original.id == null){
			document.getElementById("code").value = "";
			document.getElementById("code-name").value = "";
			document.getElementById("code-sort").value = "";

			selectOption("combo-useyn-list", "y", "value");
		} else {
			document.getElementById("code").value = data.node.original.code;
			document.getElementById("code-name").value = data.node.original.text;
			if(!nullChk(data.node.original.sort_ordr)){
				document.getElementById("code-sort").value = data.node.original.sort_ordr;
			} else {
				document.getElementById("code-sort").value = 0;
			}

			selectOption("combo-useyn-list", data.node.original.use_at, "value");
		}
	}
</script>
<body>
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
				<input id="user-id" type="text">
			</div>
			<div class="content-serach-item">
				<label>코드번호</label>
				<input id="user-name" type="text">
			</div>
			<div class="content-serach-item">
				<label>사용여부</label>
				<select id="combo-useyn"></select>
			</div>
			<input id="btn-search" class="btn-cmmn btn-search" type="button" value="조회">
		</div>
		<div class="content-top">
			<div class="list-cnt">
				<strong id="list-cnt">0</strong>개 조회
			</div>
			<div class="content-btn">
				<input id="btn-save" class="btn-cmmn btn-content" type="button" value="저장">
			</div>
		</div>
		<div class="content-work flex">
			<div class="work-master" id="jstree_div"></div>
			<div class="work-detail">

				<div class="detail-label">
					상세정보
				</div>
				<div class="row">
					<label>코드</label>
					<input type="text" id="code" placeholder="코드">
				</div>
				<div class="row">
					<label>코드이름</label>
					<input type="text" id="code-name" placeholder="코드이름">
				</div>
				<div class="row">
					<label>정렬</label>
					<input type="text" id="code-sort" placeholder="정렬">
				</div>
				<div class="row">
					<label>사용여부</label>
					<select id="combo-useyn-list"></select>
				</div>
			</div>
		</div>
	</div>
</body>