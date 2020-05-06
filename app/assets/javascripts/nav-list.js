// ナビゲーションバー（カテゴリー）
$(function() {
	$(".login__main__bottom__left__ul__list1").hover(function() {
	$("ul.category1").toggle();
	});
	$(".login__main__bottom__left__ul__list1 li ul").hide();
	$(".login__main__bottom__left__ul__list1 li").hover(function() {
			$(">ul:not(:animated)", this).stop(true, true).slideDown("fast");
			$(">a", this).addClass("active");
	}, function() {
			$(">ul:not(:animated)", this).stop(true, true).slideUp("fast");
			$(">a", this).removeClass("active");
});
});