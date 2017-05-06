<%@ page import="java.util.*,
	comp9321.assignment1.dblp.DocumentBean"%>
<!--Content Data-->
<%
	ArrayList<HashMap<String, String>> document_list = new ArrayList<HashMap<String, String>>();
	boolean display_next_button = (Boolean) request
			.getAttribute("display_next_button");
	boolean no_match = (Boolean) request.getAttribute("results_match");
	document_list = (ArrayList<HashMap<String, String>>) request
			.getAttribute("results");

	boolean display_previous_button = (Boolean) request
			.getAttribute("display_previous_button");

	if (no_match) {
%>
<div class="col-md-12">
	<h5>Sorry, no matching datasets found!</h5>
</div>
<%
	}
%>
<%
	int document_counter = 0;
	for (HashMap<String, String> article : document_list) {
		DocumentBean document = new DocumentBean(article);
		document_counter++;

		if (document_counter > 12)
			break;

		String type = document.getType();
		String mdate = document.getModifiedDate();
		String mkey = document.getKey();
		String year = document.getYear();
		String title_value = document.getTitle();
		int hashcode = Math.abs(article.hashCode());
%>

<!-- Item -->
<div class="col-md-3">
	<!-- Item -->
	<div class="panel panel-primary">
		<!--Panel Definition-->
		<div class="panel-heading">
			<button id="myBtn_<%=hashcode%>"
				class="btn btn-primary  btn-block btn-sm"
				onclick="modal_open(<%=hashcode%>)">
				<%=title_value%></button>
		</div>
		<!--Panel heading-->
		<div class="panel-body">
			<!--Panel Body-->
			<table class="table table-striped">
				<tr>
					<th>Key</th>
					<td><%=mkey%></td>
				</tr>
				<tr>
					<th>Type</th>
					<td><%=type%></td>
				</tr>
				<tr>
					<th>Modified Date</th>
					<td><%=mdate%></td>
				</tr>
				<tr>
					<th>Year</th>
					<td><%=year%></td>
				</tr>
			</table>
		</div>
		<!--Panel body end-->
	</div>
	<!--Panel Definition end-->
</div>
<!--Item End-->

<!-- The Modal -->
<div id="myModal_<%=hashcode%>" class="modal col-md-4">

	<!-- Modal content -->
	<div class="modal-content">
		<span class="close_<%=hashcode%> close"
			onclick="close_modal(<%=hashcode%>)">x&nbsp;</span>

		<div class="panel panel-primary">
			<!--Panel Definition-->

			<div class="panel-heading"><%=title_value%></div>
			<!--Panel heading-->

			<div class="panel-body">
				<!--Panel Body-->
				<form name="cart<%=hashcode%>" method="post" action="cart"
					onsubmit="addToCart(<%=hashcode%>); return false;">
					<table class="table table-striped">
						<input type="hidden" name="title_<%=hashcode%>"
							value="<%=title_value%>" id="title_<%=hashcode%>" />
						<%
							for (String key : article.keySet()) {
									if (!key.equals("title")) {
										String header_value = key;
										String data_value = article.get(key);
						%>
						<tr>
							<th><%=header_value%></th>
							<td><%=data_value%></td>
							<input type="hidden" name="<%=header_value%>_<%=hashcode%>"
								value="<%=data_value%> id=" <%=header_value%> _ <%=hashcode%>"/>
						</tr>
						<%
							}
								}
						%>
					</table>
					<input type="hidden" name="form_action" value="add_cart" /> <input
						class="btn btn-primary btn-xs" type="submit" value="Add to Cart"
						id="item_add"></input>
				</form>
			</div>
			<!--Panel body end-->
		</div>
		<!--Panel Definition end-->
	</div>
	<!--Item End-->

</div>

<%
	}
%>
<div class="col-md-12">
	<%
		if (display_next_button) {
	%>
	<form method="post" action="next">
		<input type="hidden" name="action" value="next" /> <input
			type="submit" class="btn btn-primary btn-sm next" value="Next&nbsp;>">
	</form>

	<%
		}
	%>

	<%
		if (display_previous_button) {
	%>

	<form method="post" action="previous">
		<input type="hidden" name="action" value="previous" /> <input
			type="submit" class="btn btn-primary btn-sm previous" value="<&nbsp;Previous">
	</form>

	<%
		}
	%>
</div>

