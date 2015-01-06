$(function(){
	// delete item confirm logic
	$('a[id="delete-item"]').on('click', function(){
		var deleteItemConfirm = $('div[id="delete-item-confirm"]');
		deleteItemForm = deleteItemConfirm.children()[0];
		deleteItemForm.action = this.dataset.id;
		deleteItemConfirm.removeClass('hide');
		console.log(deleteItemForm.action);
	});
	// delete item confirm cancel/close logic
	$('div form button[id="delete-item-confirm-cancel"]').on('click', function(){
		var deleteItemConfirm = $('div[id="delete-item-confirm"]');
		deleteItemForm = deleteItemConfirm.children()[0];
		deleteItemForm.action = "";
		deleteItemConfirm.addClass('hide');
		console.log(deleteItemForm.action);
	});
});