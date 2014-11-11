$(function() {
	// toggle safe delete modal popup
	$('a[data-toggle="modal"]').click(function(){
		var id = $(this).data('id');
		var form = $('.modal #delete');
		form.html(form.html().replace('{id}',id));
	});
});