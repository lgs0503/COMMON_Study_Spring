/*팝업 보이기 */
function get(idx) {
	$("#frmSchoolJob").attr("action","/admin/schooljob/read/"+idx);
	$("#frmSchoolJob").submit();
}

window.onload = function(){
	
	/* validate API 메시지 */
	var validateMsg = {
		name : {required : "필수 입력 항목 입니다."},
		sub : {required : "필수 입력 항목 입니다."},
		begindate : {required : "필수 입력 항목 입니다."},
		enddate : {required : "필수 입력 항목 입니다."}
	};
	
	$(".gubun-chk").hide();
	
	const chkboxval = $("#chkbox-chk").val();
	$("#chkbox").val(chkboxval).attr("selected", "selected");

	const chkboxval2 = $("#chkbox-chk2").val();
	$("#chkbox2").val(chkboxval2).attr("selected", "selected");
	
	/*조회버튼 클릭 이벤트*/
	$("#btn-search").click(function(){
		$("#chk-keyword").val($("#keyword").val());
		$("#chk-chkbox").val($("#chkbox option:selected").val());
		$("#chk-chkbox2").val($("#chkbox2 option:selected").val());
		$("#frm-search").submit();
	});
	
	/*추가버튼 클릭 이벤트 화면*/
	$("#btn-insertpage").click(function(){
		location.href="/admin/schooljob/writePage"
	});
	
	/*추가 저장버튼 클릭 이벤트 로직*/
	$("#btn-insert").click(function(){
		var item = $("#chkbox-gubun option:selected").val();
		
		if(item == ""){
			alert("구분값을 선택해주세요");
			return;
		} else {
			$("#gubun").val(item);
		}
		
		var form = $("#frm-write");
		
		form.validate({
			messages : validateMsg,
			submitHandler: function() {
				/* 보낼 데이터 */
				var saveData = form.serialize();
				
				/*Ajax 통신 rest api post*/
				$.ajax({ url :'/admin/schooljobapi'
					   , type : 'post'
					   , dataType : 'text'//json 으로 받을꺼면 json 으로
				       , data : saveData
				       , success : function(data) {
				            console.log("success", data);
				            alert("저장되었습니다.");
							location.href="/admin/schooljob";
				       }
				       , error:function(request,status,error){
				    	   console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				       }
				});
			}
		});
	});
	
	/*수정 저장버튼 클릭 이벤트 화면*/
	$("#btn-updatepage").click(function(){
		location.href="/admin/schooljob/updatePage/"+$("#idx").text();
	});
	
	/*수정버튼 클릭 이벤트 로직*/
	$("#btn-update").click(function(){

		var form = $("#frm-update");
		
		form.validate({
			messages : validateMsg,
			submitHandler: function() {
				/* 보낼 데이터 */
				var saveData = form.serialize();
				
				/*Ajax 통신 rest api post*/
				$.ajax({ url :'/admin/schooljobapi'
					   , type : 'put'
					   , dataType : 'text'//json 으로 받을꺼면 json 으로
				       , data : saveData
				       , success : function(data) {
				            console.log("success", data);
				            alert("저장되었습니다.");
							location.href="/admin/schooljob/read/"+$("#idxurl").val();
				       }
				       , error:function(request,status,error){
				    	   console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				       }
				});
			}
		});
	});

	/*삭제버튼 클릭 이벤트 화면*/
	$("#btn-delete").click(function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			/*Ajax 통신 rest api post*/
			$.ajax({ url :'/admin/schooljobapi/'+$("#idx").text()
				   , type : 'delete'
				   , dataType : 'text'//json 으로 받을꺼면 json 으로
			       , success : function(data) {
			            console.log("success", data);
			            alert("삭제되었습니다.");
						location.href="/admin/schooljob";
			       }
			       , error:function(request,status,error){
			    	   console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			       }
			});
		}
	});
	
	/*나가기 버튼 클릭 이벤트*/
	$("#btn-retrunpage").click(function(){
		history.back();
	});

	/*리스트 페이지 뒤로가기 버튼*/
	$("#btn-listretrunpage").click(function(){
		location.href="/admin/schooljob";
	});

	/*구분 체크박스 체인지 이벤트*/
	$("#chkbox-gubun").change(function(){
		var item = $("#chkbox-gubun option:selected").val();
		
		if(item == ""){
			$(".gubun-chk").hide();
		} else {
			$(".gubun-chk").show();
			
			if(item == "school"){
				$("#label-name").text("학교명");
				$("#label-sub").text("전공명");
			} else {
				$("#label-name").text("회사명");
				$("#label-sub").text("부서명");
			}
		}
		
		$("#chkbox-gubun").children("input").val(null);
	});
}