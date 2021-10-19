/*팝업 보이기 */
function get(idx) {
	$("#frmMember").attr("action","/admin/member/read/"+idx);
	$("#frmMember").submit();
}

window.onload = function(){
	
	/* validate API 메시지 */
	var validateMsg = {
		id : {required : "필수 입력 항목 입니다."},
		pw : {required : "필수 입력 항목 입니다."},
		name : {required : "필수 입력 항목 입니다."},
		sitename : {required : "필수 입력 항목 입니다."},
		siteinfo : {required : "필수 입력 항목 입니다."}
	};
	
	const chkboxval = $("#chkbox-chk").val();
	$("#chkbox").val(chkboxval).attr("selected", "selected");
	
	/*조회버튼 클릭 이벤트*/
	$("#btn-search").click(function(){
		$("#chk-keyword").val($("#keyword").val());
		$("#chk-chkbox").val($("#chkbox option:selected").val());
		$("#frm-search").submit();
	});
	
	/*추가버튼 클릭 이벤트 화면*/
	$("#btn-insertpage").click(function(){
		location.href="/admin/member/writePage"
	});
	
	/*추가 저장버튼 클릭 이벤트 로직*/
	$("#btn-insert").click(function(){

		var form = $("#frm-write");
		
		form.validate({
			messages : validateMsg,
			submitHandler: function() {
				/* 보낼 데이터 */
				var saveData = form.serialize();
				
				/*Ajax 통신 rest api post*/
				$.ajax({ url :'/admin/memberapi'
					   , type : 'post'
					   , dataType : 'text'//json 으로 받을꺼면 json 으로
				       , data : saveData
				       , success : function(data) {
				            console.log("success", data);
				            alert("저장되었습니다.");
							location.href="/admin/member";
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
		location.href="/admin/member/updatePage/"+$("#idx").text();
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
				$.ajax({ url :'/admin/memberapi'
					   , type : 'put'
					   , dataType : 'text'//json 으로 받을꺼면 json 으로
				       , data : saveData
				       , success : function(data) {
				            console.log("success", data);
				            alert("저장되었습니다.");
							location.href="/admin/member/read/"+$("#idxurl").val();
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
			$.ajax({ url :'/admin/memberapi/'+$("#idx").text()
				   , type : 'delete'
				   , dataType : 'text'//json 으로 받을꺼면 json 으로
			       , success : function(data) {
			            console.log("success", data);
			            alert("삭제되었습니다.");
						location.href="/admin/member";
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
		location.href="/admin/member";
	});
}