$(function() {
	// toggle safe delete modal popup
	$('a[data-toggle="modal"]').click(function(){
		var id = $(this).data('id');
		var form = $('.modal #jobDelete');
		form.html(form.html().replace('{id}',id));
	});
	// toggle safe delete modal popup
	$('a[data-toggle="modal"]').click(function(){
		var id = $(this).data('id');
		var form = $('.modal #roomDelete');
		form.html(form.html().replace('{id}',id));
	});
	// toggle safe delete modal popup
	$('a[data-toggle="modal"]').click(function(){
		var id = $(this).data('id');
		var form = $('.modal #itemDelete');
		form.html(form.html().replace('{id}',id));
	});
	$('tr.header').on('show.bs.collapse', function() {
		$('i[id="' + this.id + '"]').addClass('fa-rotate-90');
	});
	$('tr.header').on('hidden.bs.collapse', function() {
		$('i[id="' + this.id + '"]').removeClass('fa-rotate-90');
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
	// enable quantity field on td click
	$('td[id="laborHours"]').click(function() {
		$('input[id="laborHours"]').removeAttr('disabled');
		$('input[id="laborHours"]').focus();
	});
	// register submit, disable, and focus actions on count fields
	$('input[name="laborHours"]').focus(function() {
		this.onblur = function() {this.setAttribute('disabled', true)}
		this.onchange = function() {$('form[id="laborForm"]').submit()}
	});
});