$(document).ready () ->

	#
	# MODALS
	#

	$("#modal-form-login").modal
		show: false

	$("#modal-form-register").modal
		show: false

	$("#modal-form-activate").modal
		show: false

	$("#modal-form-project").modal
		show: false

	$("#modal-form-cluster").modal
		show: false

	$("#modal-form-linpack").modal
		show: false

	$("#modal-form-component").modal
		show: false

	#

	$("#button-login").click () ->
		$("#modal-form-login").modal("show")

	$("#button-register").click () ->
		$("#modal-form-register").modal("show")

	$("#button-activate").click () ->
		$("#modal-form-activate").modal("show")

	$("#button-new-project").click () ->
		$("#modal-form-project").modal("show")

	$("#button-new-cluster").click () ->
		$("#modal-form-cluster").modal("show")

	$("#button-new-linpack").click () ->
		$("#modal-form-linpack").modal("show")

	$("#button-new-component").click () ->
		$("#modal-form-component").modal("show")

	#
	# BUTTONS
	#

	$("#form-login").find("button").button()

	$("#form-register").find("button").button()

	#
	# OPENS
	#

	$(".open-login").click ->
		id = $(this).attr("now")
		$(id).hide()
		$("#login").show()

	$(".open-register").click ->
		id = $(this).attr("now")
		$(id).hide()
		$("#register").show()

	$(".open-activate").click ->
		id = $(this).attr("now")
		$(id).hide()
		$("#activate").show()

	#
	# FORM LOGIN
	#

	$("#form-login").submit () ->
		$(this).find('button').button('loading')

		$.ajax
			data: $("#form-login").serialize()
			url : $("#form-login").attr("action")
			type: $("#form-login").attr("method")
			statusCode:
				200: (data) -> # successful login
					# REDIRECT
					$(location).attr("href", "/")

				400: (xhr) ->  # invalid parameters
					data = JSON.parse(xhr.responseText)

					$("#login").find(".code-400").show()

					for error in data.errors
						$("#ctrl-login-#{error.param}").addClass("warning")

					# RESET BUTTON
					$("#form-login").find('button').button("reset")

				404: (xhr) ->  # user and password not found
					data = JSON.parse(xhr.responseText)
					# RESET BUTTON
					$("#form-login").find('button').button("reset")

				500: (xhr) ->  # internal error
					# RESET BUTTON
					$("#form-login").find('button').button("reset")

		false

	#
	# FORM REGISTER
	#

	$("#form-register").submit () ->

		$(this).find("button").button("loading")

		$.ajax
			data: $("#form-register").serialize()
			url : $("#form-register").attr("action")
			type: $("#form-register").attr("method")
			statusCode:
				200: (data) -> # successful registration
					$("#register").hide()
					$(".opens").hide()
					$("#activate").show()
					$("#activate").find(".code-200").show()
				400: (xhr) -> # invalid parameters
					data = JSON.parse(xhr.responseText)

					$("#register").find(".code-400").show()

					for error in data.errors
						$("#ctrl-register-#{error.param}").addClass("warning")
				410: (xhr) ->  # email is already in use
					data = JSON.parse(xhr.responseText)
				500: (xhr) -> # internal error

		$(this).find('button').button("reset")

		false

	#
	#	FORM ACTIVATE
	#

	$("#form-activate").submit () ->

		$(this).find("button").button("loading")

		$.ajax
			data: $("#form-activate").serialize()
			url : $("#form-activate").attr("action")
			type: $("#form-activate").attr("method")
			statusCode:
				200: (data) -> # activation successful
					$("#activate").hide()
					$("#login").show()
					$("#login").find(".opens").hide()
					$("#login").find(".code-200").show()
				400: (xhr) ->  # invalid key
					data = JSON.parse(xhr.responseText)
					$("#activate").find(".code-400").show()
					$("#form-activate").each ->
						this.reset()
					for error in data.errors
						$("#ctrl-activate-#{error.param}").addClass("warning")
				404: (xhr) ->  # key not found
					data = JSON.parse(xhr.responseText)
				500: (xhr) ->  # internal error

		$(this).find('button').button("reset")

		false

	#
	# FORM PROJECTS
	#
	
	$("#button-save-project").click () ->
		$.ajax
			data: $("#form-project").serialize()
			url : $("#form-project").attr("action")
			type: $("#form-project").attr("method")
			statusCode:
				200: (data) -> # cluster created successful
				400: (xhr) ->  # invalid parameters
					data = JSON.parse(xhr.responseText)
				401: (xhr) ->  # not authenticated
					data = JSON.parse(xhr.responseText)
				500: (xhr) ->  # internal error
		false

	#
	#	FORM CLUSTERS
	#

	$("#button-save-cluster").click () ->
		$.ajax
			data: $("#form-cluster").serialize()
			url : $("#form-cluster").attr("action")
			type: $("#form-cluster").attr("method")
			statusCode:
				200: (data) -> # cluster created successful
				400: (xhr) ->  # invalid parameters
					data = JSON.parse(xhr.responseText)
				401: (xhr) ->  # not authenticated
					data = JSON.parse(xhr.responseText)
				500: (xhr) ->  # internal error
		false

	#
	# FORM LINPACKS
	#

	$("#button-save-linpack").click () ->
		$.ajax
			data: $("#form-linpack").serialize()
			url : $("#form-linpack").attr("action")
			type: $("#form-linpack").attr("method")
			statusCode:
				200: (data) -> # cluster created successful
				400: (xhr) ->  # invalid parameters
					data = JSON.parse(xhr.responseText)
				401: (xhr) ->  # not authenticated
					data = JSON.parse(xhr.responseText)
				500: (xhr) -> # internal error
		false

	#
	# FORM COMPONENTS
	#

	$("#button-save-component").click () ->
		$.ajax
			data: $("#form-component").serialize()
			url : $("#form-component").attr("action")
			type: $("#form-component").attr("method")
			statusCode:
				200: (data) -> # cluster created successful
				400: (xhr) ->  # invalid parameters
					data = JSON.parse(xhr.responseText)
				401: (xhr) ->  # not authenticated
					data = JSON.parse(xhr.responseText)
				500: (xhr) ->  # internal error
		false
