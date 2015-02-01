$(function() {
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
		this.onblur = function() {this.setAttribute('disabled', true)};
		this.onchange = function() {$('form[id="count_' + this.id + '"]').submit()}
	});
	// enable labor field on td click
	$('td[id="laborHours"]').click(function() {
		$('input[id="laborHours"]').removeAttr('disabled');
		$('input[id="laborHours"]').focus();
	});
	// register submit, disable, and focus actions on labor field
	$('input[name="laborHours"]').focus(function() {
		this.onblur = function() {this.setAttribute('disabled', true)};
		this.onchange = function() {$('form[id="laborForm"]').submit()}
	});
});