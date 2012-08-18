$(document).ready ->

	#
	# MODALS
	#

	$("#modal-form-center").modal
		show:false

	$("#modal-form-system").modal
		show:false

	$("#modal-form-linpack").modal
		show:false

	$("#modal-form-component").modal
		show:false

	#

	$("#button-new-center").click ->
		$("#modal-form-center").modal("show")

	$("#button-new-system").click ->
		$("#modal-form-system").modal("show")

	$("#button-new-linpack").click ->
		$("#modal-form-linpack").modal("show")

	$("#button-new-component").click ->
		$("#modal-form-component").modal("show")

	#
	# BUTTONS
	#

	$("#button-save-center").button()

	#
	# LOGOUT
	#

	$("#logout").click ->

		$.ajax
			url: "/api/auth/logout"
			type: "POST"
			statusCode:
				200:(data) -> # SUCCESSFUL LOGOUT
					$(location).attr("href","/ingresar") #REDIRECT

				401:(xhr) ->  # user and password not found
					data= JSON.parse(xhr.responseText)
					alert(data.message)
		true

	#
	# FORM CENTER
	#
	
	$("#button-save-center").click ->
		button = $(this)

		button.button("loading")

		$.ajax
			data:$("#form-center").serialize()
			url: $("#form-center").attr("action")
			type:$("#form-center").attr("method")
			statusCode:
				200:(data) -> # CENTER CREATED SUCCESSFUL
					center = data.data
					$("#tbody-center").append(centerTR(center))
					$("#modal-form-center").modal("hide")
					$("#table-center").show() # REVIEW !!!
					$("#tbody-center").find("a.center").each ->
						$(this).click ->
							clickCenter($(this))
					$("#form-center").each ->
						this.reset()
					button.button("reset")

				400:(xhr) ->  # INVALID PARAMETERS
					data= JSON.parse(xhr.responseText)
				401:(xhr) ->  # NOT AUTHENTICATED
					data= JSON.parse(xhr.responseText)
				500:(xhr) ->  # INTERNAL ERROR

	#
	# FORM SYSTEM
	#

	$("#button-save-system").click ->
		button = $(this)

		button.button("loading")

		$.ajax
			data:$("#form-system").serialize()
			url: $("#form-system").attr("action")
			type:$("#form-system").attr("method")
			statusCode:
				200:(data) -> # cluster created successful
					system = data.data
					$("#tbody-systems").append(systemTR(system))
					$("#modal-form-system").modal("hide")
					$("#form-system").each ->
						this.reset()
					button.button("reset")

				400:(xhr) ->  # invalid parameters
					data= JSON.parse(xhr.responseText)
				401:(xhr) ->  # not authenticated
					data= JSON.parse(xhr.responseText)
				500:(xhr) ->  # internal error
		false

	#
	# FORM LINPACK
	#

	$("#button-save-linpack").click ->
		$.ajax
			data:$("#form-linpack").serialize()
			url: $("#form-linpack").attr("action")
			type:$("#form-linpack").attr("method")
			statusCode:
				200:(data) -> # cluster created successful
				400:(xhr) ->  # invalid parameters
					data= JSON.parse(xhr.responseText)
				401:(xhr) ->  # not authenticated
					data= JSON.parse(xhr.responseText)
				500:(xhr) -> # internal error
		false

	#
	# FORM COMPONENTS
	#

	$("#button-save-component").click ->
		$.ajax
			data:$("#form-component").serialize()
			url: $("#form-component").attr("action")
			type:$("#form-component").attr("method")
			statusCode:
				200: (data) -> # cluster created successful
				400: (xhr) ->  # invalid parameters
					data= JSON.parse(xhr.responseText)
				401: (xhr) ->  # not authenticated
					data= JSON.parse(xhr.responseText)
				500: (xhr) ->  # internal error
		false

	#
	# CENTER
	#

	actionsDIV = ->
		"""
		<div class="btn-group">
			<button class="btn btn-mini dropdown-toggle", data-toggle="dropdown">
			<span class="caret">
				<ul class="dropdown-menu">
					<li>
						<a href="#">
							<i class="icon-pencil">
								<span> Editar</span>
							</i>
						</a>
					</li>
					<li>
						<a href="#">
							<i class="icon-remove">
								<span> Eliminar</span>
							</i>
						</a>
					</li>
				</ul>
			</span>
		</div>
		"""

	centerTR = (data) ->
		"""
		<tr>
			<td>
				<a href="javascript:;" class="center" center-id="#{data.id}">#{data.name}</a>
			</td>
			<td>#{data.acronym}</td>
			<td>
				<span class="badge badge-info">#{data.segment}</span>
			</td>
			<td>#{data.country}</td>
			<td>#{data.city}</td>
			<td>#{actionsDIV()}</td>
		</tr>
		"""

	systemTR = (data) ->
		"""
		<tr>
			<td>
				<a href="javascript:;" class="center" center-id="#{data.id}">#{data.name}</a>
			</td>
			<td>
				<span class="badge badge-info">#{data.status}</span>
			</td>
			<td>#{data.area}</td>
			<td>#{data.vendor}</td>
			<td>#{data.installation}</td>
			<td>#{actionsDIV()}</td>
		</tr>
		"""

	clickCenter = (a)->

		center = a.attr("center-id")

		$.ajax
			url : "/api/submissions/centers/#{center}"
			type: "GET"
			statusCode:
				200: (json) ->
					data = json.data
					$("#system-now").html(" / #{data.description.acronym}")
					for system in data.systems
						$("#tbody-systems").append(systemTR(system))
					$("#centers").hide()
					$("#systems").show()
					$("#input-center").val(center)
				404: (xhr) ->
				500: (xhr) ->
		false

	$("a.center").click ->
		clickCenter($(this))

	$("#back-centers").click ->
		$("#systems").hide()
		$("#centers").show()
		$("#tbody-systems").html("")
