/*팝업 보이기 */
function showPopup() {
	const popup = $(".contents-bbs-popup");
  
	popup.removeClass('hide');
}

/*팝업 숨기기 */
function closePopup() {
	const popup = $(".contents-bbs-popup");
	popup.addClass('hide');
}
	
window.onload = function(){
	/*구글maps api 초기화*/
	function initMap() {
		var home = { lat: 37.19840000076408 ,lng: 127.04233629422009 };
		var map = new google.maps.Map(
				document.getElementById('map'), {
					zoom: 14,
					center: home
				});
		const marker = new google.maps.Marker({
			position: home,
			map: map,
		});
	}

	initMap();

	const conpjt = $(".content-project");
	const projectlen = $(".content-project-work").children('div').length
	conpjt.css("height",64*projectlen);

	const slide = $(".content-stack-work");
	const target = slide.children('div:eq(0)');
	const len = slide.children('div').length;
	var width = target.css("width");
	width = parseInt(width)+5;
	var pos = $(".content-stack-work").css("left");
	pos = parseInt(pos);

	/* 왼쪽 슬라이드 버튼 */
	$("#btn-perv").click(function(){
		pos += width;

		var width_size = document.body.clientWidth;
		var limit = 0;

		if(pos > limit){
			pos = limit;
		}
		$(".content-stack-work").css("left", pos+"px");
	});


	/* 오른쪽 슬라이드 버튼 */
	$("#btn-next").click(function(){
		pos -= width;	

		var width_size = document.body.clientWidth;
		var limit = 0;

		if(width_size <= 460){
			limit = (-1) * ((width) * (len - 1));
		} else {
			limit = (-1) * ((width) * (len - 3));
		}

		if(pos < limit){
			pos = limit;
		}
		$(".content-stack-work").css("left", String(pos)+"px");

	});

	/* 브라우저 사이즈 체크 */
	$(window).resize(function (){
		$(".content-stack-work").css("left","0px");
	})

	/* 참여 프로젝트 타이틀 클릭 이벤트 슬라이드 처리*/
	$(".content-project-title").click(function() {

		const target = $(this).parent().children('div:eq(1)');
		var height = target.css("height");
		height = parseInt(height);

		const frame = $(this).parent().parent().parent();
		var frameHeight = frame.css("height");
		frameHeight = parseInt(frameHeight);
		
		if(height == 300){
			target.css("height","0px");
			frame.css("height",frameHeight-300+"px");
		} else if(height == 0){
			target.css("height","300px");
			frame.css("height",frameHeight+300+"px");
		}

	});
	
	/*footer 어드민 버튼 클릭이벤트*/
	$(".footer-admin-btn").click(function(){
		location.href="/admin"
	});

}