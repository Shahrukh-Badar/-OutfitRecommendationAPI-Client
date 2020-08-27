<!DOCTYPE html >
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style type="text/css">
.form-style-1 {
	margin: 10px auto;
	max-width: 400px;
	padding: 20px 12px 10px 20px;
	font: 13px "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}

.form-style-1 li {
	padding: 0;
	display: block;
	list-style: none;
	margin: 10px 0 0 0;
}

.form-style-1 label {
	margin: 0 0 3px 0;
	padding: 0px;
	display: block;
	font-weight: bold;
}

.form-style-1 input[type=text], .form-style-1 input[type=date],
	.form-style-1 input[type=datetime], .form-style-1 input[type=number],
	.form-style-1 input[type=search], .form-style-1 input[type=time],
	.form-style-1 input[type=url], .form-style-1 input[type=email],
	textarea, select {
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	border: 1px solid #BEBEBE;
	padding: 7px;
	margin: 0px;
	-webkit-transition: all 0.30s ease-in-out;
	-moz-transition: all 0.30s ease-in-out;
	-ms-transition: all 0.30s ease-in-out;
	-o-transition: all 0.30s ease-in-out;
	outline: none;
}

.form-style-1 input[type=text]:focus, .form-style-1 input[type=date]:focus,
	.form-style-1 input[type=datetime]:focus, .form-style-1 input[type=number]:focus,
	.form-style-1 input[type=search]:focus, .form-style-1 input[type=time]:focus,
	.form-style-1 input[type=url]:focus, .form-style-1 input[type=email]:focus,
	.form-style-1 textarea:focus, .form-style-1 select:focus {
	-moz-box-shadow: 0 0 8px #88D5E9;
	-webkit-box-shadow: 0 0 8px #88D5E9;
	box-shadow: 0 0 8px #88D5E9;
	border: 1px solid #88D5E9;
}

.form-style-1 .field-divided {
	width: 49%;
}

.form-style-1 .field-long {
	width: 100%;
}

.form-style-1 .field-select {
	width: 100%;
}

.form-style-1 .field-textarea {
	height: 100px;
}

.form-style-1 input[type=submit], .form-style-1 input[type=button] {
	background: #4B99AD;
	padding: 8px 15px 8px 15px;
	border: none;
	color: #fff;
}

.form-style-1 input[type=submit]:hover, .form-style-1 input[type=button]:hover
	{
	background: #4691A4;
	box-shadow: none;
	-moz-box-shadow: none;
	-webkit-box-shadow: none;
}

.form-style-1 .required {
	color: red;
}

.ui-menu .ui-menu-item a, .ui-menu .ui-menu-item a.ui-state-hover,
	.ui-menu .ui-menu-item a.ui-state-active {
	font-weight: normal;
	margin: -1px;
	text-align: left;
	font-size: 14px;
}

.ui-autocomplete-loading {
	
}
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.10.3/themes/flick/jquery-ui.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>

<script type="text/javascript">
	jQuery(function() {
		jQuery("#f_elem_city")
				.autocomplete(
						{
							source : function(request, response) {
								jQuery
										.getJSON(
												"https://secure.geobytes.com/AutoCompleteCity?key=7c756203dbb38590a66e01a5a3e1ad96&callback=?&q="
														+ request.term,
												function(data) {
													response(data);
												});
							},
							minLength : 3,
							select : function(event, ui) {
								var selectedObj = ui.item;
								jQuery("#f_elem_city").val(selectedObj.value);
								//getcitydetails(selectedObj.value);
								return false;
							},
							open : function() {
								jQuery(this).removeClass("ui-corner-all")
										.addClass("ui-corner-top");
							},
							close : function() {
								jQuery(this).removeClass("ui-corner-top")
										.addClass("ui-corner-all");
							}
						});
		jQuery("#f_elem_city").autocomplete("option", "delay", 100);
	});

	function getReccomendation() {
		var cityName = document.getElementById("f_elem_city").value;

		cityName = cityName.split(",")[0];
		var url80 = '${home}/myReccomendation/' + cityName;

		//alert(cityName);
		if (!cityName) {
			alert('Please Enter City Name');
			$('#f_elem_city').focus();
			return false;
		}
		//alert(${home});
		$('#url80').val(url80);
		$.ajax({
			type : "GET",
			url : url80,
			dataType : "json",
			crossDomain : true,
			success : function(data) {
				if (data) {
					console.log(data);
					var resp = 'City Name: ' + cityName + '\n'
							+ 'Outfit level: ' + data.outfitLevel + '\n'
							+ 'Temperature in Celsius: ' + data.temperature;
					$('#field5').val(resp);
				} else
					$('#field5').val('City not found');

			},
			error : function(data) {
				$('#field5').val('ERROR: Please check URL ' + url80);
				console.log(data);
			}
		});

	}
</script>

</head>
<body>

	<form action="" method="post" name="form_citydetails"
		id="form_citydetails" enctype="multipart/form-data"
		onsubmit="return false;">
		<ul class="form-style-1">
			<li><label>Enter City Name <span class="required">*</span></label>
				<input class="ff_elem  field-long" type="text" name="ff_nm_from[]"
				value="" id="f_elem_city" />
			<li><label>Details </label> <textarea name="field5" id="field5"
					class="field-long field-textarea" disabled></textarea></li>
			<li><label>Requested URL</label><input class="field-long"
				type="text" name="urlReq" value="" id="url80" disabled /></li>
			<li><input type="button" value="Submit"
				onclick="getReccomendation()" /></li>
		</ul>
	</form>

</body>
</html>