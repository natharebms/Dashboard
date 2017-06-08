/****************************************************************************************************/
/*	Creted By : DANIEL
/*	Created Date : 18-05-2017
/****************************************************************************************************/

	$(document).ready(function(){

	/*		Common Date Picker function	
			Date Picker Documentation - https://bootstrap-datepicker.readthedocs.io/en/latest/
			Add class="datepicker" in input field to use this plugin	*/
	
	/*	START OF DATE PICKER FUNCTION	*/
		$('.datepicker').datepicker({
			format: 'dd-M-yyyy',
			todayHighlight: false,
			autoclose: true,
		});
	/*	END OF DATE PICKER FUNCTION	*/

	/*		Common Select Picker function	
			Date Select Documentation - https://github.com/HemantNegi/jquery.sumoselect
			Add class="single-select" in select ( single select ) field to use this plugin
			Add class="multi-select" in select ( multiple select ) field to use this plugin			*/
	
	/*	START OF SELECT PICKER FUNCTION	*/	  
		$('.single-select').SumoSelect({
			search: true,
			searchText: 'Search'
		});

		$('.multi-select').SumoSelect({
			csvDispCount: 3,
			okCancelInMulti: true,
			captionFormatAllSelected: "Selected All",
			selectAll: true,
			search: true,
			searchText: 'Search',
			up: false
		});
	/*	END OF SELECT PICKER FUNCTION	*/
	
	/*	START OF BODY STYLE	*/
		setTimeout( function() {
			$("body").css("overflow", "auto");
		}, 3000);
	/*	END OF BODY STYLE	*/
		
    })
	
	
