$(document).ready ->

	#
	# MODALS
	#

	$("#modal-form-center").modal
		show:false

	$("#modal-form-cluster").modal
		show:false

	$("#modal-form-linpack").modal
		show:false

	$("#modal-form-component").modal
		show:false

	#


	$("#button-new-center").click ->
		$("#modal-form-center").modal("show")

	$("#button-new-cluster").click ->
		$("#modal-form-cluster").modal("show")

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
					tr = """
							<tr>
								<td>
									<a href="javascript:;">#{center.name}</a>
								</td>
								<td>#{center.acronym}</td>
								<td>
									<span class="badge badge-info">#{center.segment}</span>
								</td>
								<td>#{center.country}</td>
								<td>#{center.city}</td>
								<td>
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
								</td>
							</tr>
						"""
					$("#tbody-center").append(tr)
					$("#modal-form-center").modal("hide")
					$("#table-center").show()
					$("#form-center").each ->
						this.reset()
					button.button("reset")

				400:(xhr) ->  # INVALID PARAMETERS
					data= JSON.parse(xhr.responseText)
				401:(xhr) ->  # NOT AUTHENTICATED
					data= JSON.parse(xhr.responseText)
				500:(xhr) ->  # INTERNAL ERROR
		false

	#
	# FORM CLUSTERS
	#

	$("#button-save-cluster").click ->
		$.ajax
			data:$("#form-cluster").serialize()
			url: $("#form-cluster").attr("action")
			type:$("#form-cluster").attr("method")
			statusCode:
				200:(data) -> # cluster created successful
				400:(xhr) ->  # invalid parameters
					data= JSON.parse(xhr.responseText)
				401:(xhr) ->  # not authenticated
					data= JSON.parse(xhr.responseText)
				500:(xhr) ->  # internal error
		false

	#
	# FORM LINPACKS
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
				200:(data) -> # cluster created successful
				400:(xhr) ->  # invalid parameters
					data= JSON.parse(xhr.responseText)
				401:(xhr) ->  # not authenticated
					data= JSON.parse(xhr.responseText)
				500:(xhr) ->  # internal error
		false
