<%@ page import="comp9321.assignment1.dblp.FormBuilder, java.util.*"%>
<%
	FormBuilder form = new FormBuilder();
	HashMap<String, String> form_fields = form.getFormFields();
%>
<div class="container-fluid" id="search" style="display: none;">

	<!--Search Query Form-->
	<form class="form-horizontal" action="search" method="post">
	<input type="hidden" name="action" value="advanced_search"/>
		<fieldset>
			<!--Form details begin-->
			<div class="col-md-12">
				<legend>
					<h4>
						<strong>Search</strong>
					</h4>
				</legend>
			</div>

			<%
				for (String key : form_fields.keySet()) {
			%>
			<!--Form Item 2 begin-->
			<div class="form-group col-md-6">
				<label name="<%=key%>_label" class="col-md-3 control-label"><%=form_fields.get(key)%></label>
				<div class="col-md-7">
					<input type="text" class="form-control" name="<%=key%>"
						placeholder="Enter the Search <%=form_fields.get(key)%>"></input>
				</div>
			</div>
			<%
				}
			%>
			<!--Form Item 2 end-->
			<!--Form Item 1 begin-->
			<div class="form-group col-md-6">
				<label for="select" class="col-md-3 control-label">Document
					Type</label>
				<div class="col-md-7">
					<select multiple="multiple" class="form-control" name="type">
						<option value="article">Article</option>
						<option value="inproceedings">Inproceedings</option>
						<option value="proceedings">Proceedings</option>
						<option value="book">Book</option>
						<option value="incollection">Incollection</option>
						<option value="phdthesis">PHD Thesis</option>
						<option value="mastersthesis">Masters Thesis</option>
						<option value="www">Web Resource</option>
					</select>
				</div>
			</div>
			<!--Form Item 1 end-->
			<br />
			<!--Form Heading-->
			<div class="form-group col-md-11">
				<div class="col-md-12 text-right">
					<button type="submit" class="btn btn-primary btn-sm">Search</button>
				</div>
			</div>
			<!--Form details end-->
		</fieldset>
	</form>
	<!--Search query form end-->

</div>