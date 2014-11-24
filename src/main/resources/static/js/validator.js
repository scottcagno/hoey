$(function(){

	var error = "";

	// validate each input function
	function validateInput(input) {
		if(input.required) {
			if(input.value.length == 0) {
				error = "*" + input.placeholder + " is required!";
				return false;
			}
			if(input.type == "number" && isNaN(input.value)) {
				error ="*" + input.placeholder + " is not a number!";
				return false;
			}
			if(input.type == "email") {
				var at = input.value.indexOf("@");
				var dot = input.value.lastIndexOf(".");
				if (at < 1 || dot < at + 2 || dot + 2 >= input.value.length) {
						error = "*" + input.placeholder + " does not contain a valid email address!";
					return false;
				}
			}
		}
		return true;
	}

	// main form validation function
	function formIsValid(formId) {
		var formInputList = $('form[id="'+formId+'"] input');
		for(var i = 0; i < formInputList.length; i++) {
			var inputIsValid = validateInput(formInputList[i]);
			if(!inputIsValid) return false;
		}
		error = "";
		return true;
	}

	// form submit hook
	$('form').on('submit', function(e){
		var isValid = formIsValid(this.id);
		if(!isValid) {
			e.preventDefault();
			//e.stopPropagation();
			window.location.search = "?formError=" + error;
			return false;
		}
		//$(this).submit();
	});

});