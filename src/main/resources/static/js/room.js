$(function(){
	// toggle safe delete modal popup
	$('a[data-toggle="modal"]').click(function(){
		var id = $(this).data('id');
		var form = $('.modal #delete');
		form.html(form.html().replace('{id}',id));
	});
	// enable quantity field on td click
	$('td.count').click(function() {
		$('input[id="'+this.id+'"]').removeAttr('disabled');
		$('input[id="'+this.id+'"]').focus();
	});
	// register submit, disable, and focus actions on count fields
	$('input[name="count"]').focus(function() {
		this.onblur = function() {this.setAttribute('disabled', true)}
		this.onchange = function() {$('form[id="count_' + this.id + '"]').submit()}
	});
});