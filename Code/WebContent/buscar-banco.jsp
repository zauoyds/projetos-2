<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="database.ConectaBD"%>
<%@page language="java" import="java.sql.*"%>
<%
	String cidade = request.getParameter("cidade");

	String cidadee = null;
%>
<head>
<title>Busca</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
	integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/r_busca.css">
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">Limpai!</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			</ul>
			<ul1 class="navbar-nav my-sm-0"> </ul1>
			<!--   <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form> -->
		</div>
	</nav>


	<div class="container">
		<div class="row">
			<div class="search">

				<form name="buscar" method="post" action="buscar-banco.jsp">
					<input name="cidade" type="text" class="form-control input-sm"
						maxlength="64" placeholder="Digite sua cidade" required autofocus />
					<button type="submit" class="btn btn-primary btn-sm">Buscar
						diaristas!</button>

				</form>
				<br> <br>


			</div>
		</div>
	</div>


	<div class="btn-group">
		<select class="form-control ">
			<option value="">Classificar por:</option>
			<option value="">A-Z</option>
			<option value="">Z-A</option>
			<option value="">Valor crescente</option>
			<option value="">Valor decrescente</option>
		</select>
	</div>

	<table class="table table-striped table-bordered">
		<thead>
			<tr>
				<th>Nome</th>
				<th>Cidade</th>
				<th>Telefone</th>
				<th>Servi�o</th>
				<th>Valor</th>
				<th></th>
			</tr>
		</thead>

		<%
			try {
				Connection con = ConectaBD.getConnection();

				String query = "select p.nome, l.cidade, p.telefone, s.descricao, d.val_diaria, p.idpessoa, d.iddomestico from pessoa  p, domestico d, logradouro l, servicos s where p.idpessoa=d.pessoa_idpessoa and p.idpessoa=l.pessoa_idpessoa and p.idpessoa=s.domestico_pessoa_idpessoa and l.cidade="
						+ "'" + cidade + "' ";

				PreparedStatement stmt = con.prepareStatement(query);
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()) {
		%>

		<tr>
			<td>
				<%
					out.println(rs.getString(1));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(2));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(3));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(4));
				%>
			</td>
			<td>
				<%
					out.println(rs.getString(5));
				%>
			</td>
			<td><script type="text/javascript">
				$(".me")
						.click(
								function() {
									var cells = $(this).closest("tr").children(
											"td");
									var cell1 = cells.eq(0).text();
									document.getElementById("diarista-nome").innerHTML = "Contratar "
											+ cell1;
									document.getElementById("diarista-nome2").innerHTML = cell1;
								});
				var cell1 = cells.eq(0).text();
			</script> <!-- Button trigger modal -->
				<button type="button" class="me btn-success btn-center"
					data-toggle="modal" data-target="#exampleModal">Contratar
					domestico</button> <!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">

								<h5 class="modal-title" id="diarista-nome">Contratar
									diarista</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<form method="post" action="contratar.jsp">
								<div class="modal-body">
									<label>Escolha uma data</label>
									<div class="form-group">
										<input type="date" class="form-control date" id="data"
											name="dataServico" placeholder="Data do servi�o" required>
									</div>
									<label>Hor�rio de Inicio</label>
									<div class="form-group">
										<input type="time" class="form-control date" id="hInicio"
											name="hInicio" placeholder="Data do servi�o" required>
									</div>
									<label>Hor�rio de T�rmino</label>
									<div class="form-group">
										<input type="time" class="form-control date" id="hFinal"
											name="hFinal" placeholder="Data do servi�o" required>
									</div>
									<div class="input-group control-group after-add-more">
										<input type="text" name="descricao" id="descricao"
											class="form-control"
											placeholder="Descri��o dos servi�os a serem executados.">
									</div>
									<input type="hidden" id="diarista-nome2" name="diarista-nome"></input>
								</div>
								<div class="modal-footer">
									<button type="submit">Contratar</button>
								</div>
							</form>
						</div>
					</div>
				</div></td>
		</tr>

		<%
			}
				// out.println(rs.getString(1));
				//out.println(rs.getString(2)); 
				//out.println(rs.getString(3));
				//out.println(rs.getString(4));
		%>
		</tbody>

	</table>

</body>
<%
	//response.sendRedirect("errou.jsp");

		con.close();

	} catch (Exception e) {
		out.println(e.toString());

	}
%>