$(document).ready ->

	#
	# BUTTONS
	#

	$("#form-login").find("button").button()

	$("#form-register").find("button").button()

	$("#form-activate").find("button").button()

	#
	# OPENS
	#

	$(".open-login").click ->
		id= $(this).attr("now")
		$(id).hide()
		$("#login").show()

	$(".open-register").click ->
		id= $(this).attr("now")
		$(id).hide()
		$("#register").show()

	$(".open-activate").click ->
		id= $(this).attr("now")
		$(id).hide()
		$("#activate").show()

	#
	# FORM LOGIN
	#

	$("#form-login").submit ->
		$(this).find('button').button('loading')

		$.ajax
			data:$("#form-login").serialize()
			url: $("#form-login").attr("action")
			type:$("#form-login").attr("method")
			statusCode:
				200:(data) -> # successful login
					#REDIRECT
					$(location).attr("href","/")

				400:(xhr) ->  # invalid parameters
					data= JSON.parse(xhr.responseText)

					$("#login").find(".code-400").show()

					for error in data.errors
						$("#ctrl-login-#{error.param}").addClass("warning")

					#RESET BUTTON
					$("#form-login").find('button').button("reset")

				404:(xhr) ->  # user and password not found
					data= JSON.parse(xhr.responseText)
					#RESET BUTTON
					$("#form-login").find('button').button("reset")

				500:(xhr) ->  # internal error
					#RESET BUTTON
					$("#form-login").find('button').button("reset")

		false

	#
	# FORM REGISTER
	#

	$("#form-register").submit ->

		$("#form-register").find("button").button("loading")

		$.ajax
			data:$("#form-register").serialize()
			url: $("#form-register").attr("action")
			type:$("#form-register").attr("method")
			statusCode:
				200:(data) -> # successful registration
					$("#register").hide()
					$(".opens").hide()
					$("#activate").show()
					$("#activate").find(".code-200").show()
					$("#form-register").find('button').button("reset")
				400:(xhr) -> # invalid parameters
					data= JSON.parse(xhr.responseText)
					$("#register").find(".code-400").show()
					for error in data.errors
						$("#ctrl-register-#{error.param}").addClass("warning")
					$("#form-register").find('button').button("reset")
				410:(xhr) ->  # email is already in use
					data= JSON.parse(xhr.responseText)
					$("#form-register").find('button').button("reset")
				500:(xhr) -> # internal error
					$("#form-register").find('button').button("reset")

		false

	#
	# FORM ACTIVATE
	#

	$("#form-activate").submit ->

		$("#form-activate").find("button").button("loading")

		$.ajax
			data:$("#form-activate").serialize()
			url: $("#form-activate").attr("action")
			type:$("#form-activate").attr("method")
			statusCode:
				200:(data) -> # activation successful
					$("#activate").hide()
					$("#login").show()
					$("#login").find(".opens").hide()
					$("#login").find(".code-200").show()
					$("#form-activate").find('button').button("reset")
				400:(xhr) ->  # invalid key
					data= JSON.parse(xhr.responseText)
					$("#activate").find(".code-400").show()
					$("#form-activate").each ->
						this.reset()
					for error in data.errors
						$("#ctrl-activate-#{error.param}").addClass("warning")
					$("#form-activate").find('button').button("reset")
				404:(xhr) ->  # key not found
					data= JSON.parse(xhr.responseText)
					$("#form-activate").find('button').button("reset")
				500:(xhr) ->  # internal error
					$("#form-activate").find('button').button("reset")

		false
