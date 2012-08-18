// Generated by CoffeeScript 1.3.3
(function() {

  $(document).ready(function() {
    var actionsDIV, centerTR, clickCenter, systemTR;
    $("#modal-form-center").modal({
      show: false
    });
    $("#modal-form-system").modal({
      show: false
    });
    $("#modal-form-linpack").modal({
      show: false
    });
    $("#modal-form-component").modal({
      show: false
    });
    $("#button-new-center").click(function() {
      return $("#modal-form-center").modal("show");
    });
    $("#button-new-system").click(function() {
      return $("#modal-form-system").modal("show");
    });
    $("#button-new-linpack").click(function() {
      return $("#modal-form-linpack").modal("show");
    });
    $("#button-new-component").click(function() {
      return $("#modal-form-component").modal("show");
    });
    $("#button-save-center").button();
    $("#logout").click(function() {
      $.ajax({
        url: "/api/auth/logout",
        type: "POST",
        statusCode: {
          200: function(data) {
            return $(location).attr("href", "/ingresar");
          },
          401: function(xhr) {
            var data;
            data = JSON.parse(xhr.responseText);
            return alert(data.message);
          }
        }
      });
      return true;
    });
    $("#button-save-center").click(function() {
      var button, success;
      success = false;
      button = $(this);
      button.button("loading");
      $.ajax({
        data: $("#form-center").serialize(),
        url: $("#form-center").attr("action"),
        type: $("#form-center").attr("method"),
        async: false,
        statusCode: {
          200: function(data) {
            var center;
            center = data.data;
            $("#tbody-center").append(centerTR(center));
            $("#modal-form-center").modal("hide");
            $("#table-center").show();
            $("#tbody-center").find("a.center").each(function() {
              return $(this).click(function() {
                return clickCenter($(this));
              });
            });
            $("#form-center").each(function() {
              return this.reset();
            });
            button.button("reset");
            return success = true;
          },
          400: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          401: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          500: function(xhr) {}
        }
      });
      return success;
    });
    $("#button-save-system").click(function() {
      var button;
      button = $(this);
      button.button("loading");
      $.ajax({
        data: $("#form-system").serialize(),
        url: $("#form-system").attr("action"),
        type: $("#form-system").attr("method"),
        statusCode: {
          200: function(data) {
            var system;
            system = data.data;
            $("#tbody-systems").append(systemTR(system));
            $("#modal-form-system").modal("hide");
            $("#form-system").each(function() {
              return this.reset();
            });
            return button.button("reset");
          },
          400: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          401: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          500: function(xhr) {}
        }
      });
      return false;
    });
    $("#button-save-linpack").click(function() {
      $.ajax({
        data: $("#form-linpack").serialize(),
        url: $("#form-linpack").attr("action"),
        type: $("#form-linpack").attr("method"),
        statusCode: {
          200: function(data) {},
          400: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          401: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          500: function(xhr) {}
        }
      });
      return false;
    });
    $("#button-save-component").click(function() {
      $.ajax({
        data: $("#form-component").serialize(),
        url: $("#form-component").attr("action"),
        type: $("#form-component").attr("method"),
        statusCode: {
          200: function(data) {},
          400: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          401: function(xhr) {
            var data;
            return data = JSON.parse(xhr.responseText);
          },
          500: function(xhr) {}
        }
      });
      return false;
    });
    actionsDIV = function() {
      return "<div class=\"btn-group\">\n	<button class=\"btn btn-mini dropdown-toggle\", data-toggle=\"dropdown\">\n	<span class=\"caret\">\n		<ul class=\"dropdown-menu\">\n			<li>\n				<a href=\"#\">\n					<i class=\"icon-pencil\">\n						<span> Editar</span>\n					</i>\n				</a>\n			</li>\n			<li>\n				<a href=\"#\">\n					<i class=\"icon-remove\">\n						<span> Eliminar</span>\n					</i>\n				</a>\n			</li>\n		</ul>\n	</span>\n</div>";
    };
    centerTR = function(data) {
      return "<tr>\n	<td>\n		<a href=\"javascript:;\" class=\"center\" center-id=\"" + data.id + "\">" + data.name + "</a>\n	</td>\n	<td>" + data.acronym + "</td>\n	<td>\n		<span class=\"badge badge-info\">" + data.segment + "</span>\n	</td>\n	<td>" + data.country + "</td>\n	<td>" + data.city + "</td>\n	<td>" + (actionsDIV()) + "</td>\n</tr>";
    };
    systemTR = function(data) {
      return "<tr>\n	<td>\n		<a href=\"javascript:;\" class=\"center\" center-id=\"" + data.id + "\">" + data.name + "</a>\n	</td>\n	<td>\n		<span class=\"badge badge-info\">" + data.status + "</span>\n	</td>\n	<td>" + data.area + "</td>\n	<td>" + data.vendor + "</td>\n	<td>" + data.installation + "</td>\n	<td>" + (actionsDIV()) + "</td>\n</tr>";
    };
    clickCenter = function(a) {
      var center;
      center = a.attr("center-id");
      $.ajax({
        url: "/api/submissions/centers/" + center,
        type: "GET",
        statusCode: {
          200: function(json) {
            var data, system, _i, _len, _ref;
            data = json.data;
            $("#system-now").html(" / " + data.description.acronym);
            _ref = data.systems;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              system = _ref[_i];
              $("#tbody-systems").append(systemTR(system));
            }
            $("#centers").hide();
            $("#systems").show();
            return $("#input-center").val(center);
          },
          404: function(xhr) {},
          500: function(xhr) {}
        }
      });
      return false;
    };
    $("a.center").click(function() {
      return clickCenter($(this));
    });
    return $("#back-centers").click(function() {
      $("#systems").hide();
      $("#centers").show();
      return $("#tbody-systems").html("");
    });
  });

}).call(this);
