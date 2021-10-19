/*팝업 보이기 */
function get(idx) {
	$("#frmStack").attr("action","/admin/stack/read/"+idx);
	$("#frmStack").submit();
}

window.onload = function(){
	
	/* validate API 메시지 */
	var validateMsg = {
		title : {required : "필수 입력 항목 입니다."},
		name1 : {required : "필수 입력 항목 입니다."}
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
		location.href="/admin/stack/writePage"
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
				$.ajax({ url :'/admin/stackapi'
					   , type : 'post'
					   , dataType : 'text'//json 으로 받을꺼면 json 으로
				       , data : saveData
				       , success : function(data) {
				            console.log("success", data);
				            alert("저장되었습니다.");
							location.href="/admin/stack";
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
		location.href="/admin/stack/updatePage/"+$("#idx").text();
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
				$.ajax({ url :'/admin/stackapi'
					   , type : 'put'
					   , dataType : 'text'//json 으로 받을꺼면 json 으로
				       , data : saveData
				       , success : function(data) {
				            console.log("success", data);
				            alert("저장되었습니다.");
							location.href="/admin/stack/read/"+$("#idxurl").val();
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
			$.ajax({ url :'/admin/stackapi/'+$("#idx").text()
				   , type : 'delete'
				   , dataType : 'text'//json 으로 받을꺼면 json 으로
			       , success : function(data) {
			            console.log("success", data);
			            alert("삭제되었습니다.");
						location.href="/admin/stack";
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
		location.href="/admin/stack";
	});
}