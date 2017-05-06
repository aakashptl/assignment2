<!--Side Navigation: Shopping Cart-->
<%@ page import="javax.servlet.http.HttpSession, java.util.*"%>
<div id="mySidenav" class="sidenav">
	<!--Shopping Cart Icon-->
	<div class="col-md-12 text-right">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	</div>
	<div class="col-md-12"></div>
	<div class="col-md-10">
		<div class="">
			<img src="images/Cart.png" height=50px width=50px />
			<div class="col-md-10">
				<h4>Shopping Cart</h4><br/><br/>
			</div>
			<div id="cart_content">
				<%
					session = request.getSession();
					ArrayList<HashMap<String,String>> cart = new ArrayList<HashMap<String,String>>();
					
					
					if(session.getAttribute("cart")==null)
						session.setAttribute("cart", cart);
					else
						cart = (ArrayList<HashMap<String,String>>)session.getAttribute("cart");
					

					if (cart.size()==0) {
				%>
				<div class="col-md-12 panel panel-primary" id="empty_cart">
					<div>
						<h6>Shopping Cart is Empty!</h6>

					</div>
				</div>
				<%
					} else {
						for (HashMap<String,String> item : cart) {
							String title = item.get("title");
							String hashcode = item.get("hashcode");
				%>
				<div class="col-md-12 panel panel-primary" id="cart_item<%=hashcode%>">
					<div>
						<h6>
							<%=title%> <br/>
							<button class="btn btn-warning btn-xs cart" onclick="removeCartItem('cart_item<%=hashcode%>','<%=title%>')">Remove</button>
						</h6><br/>

					</div>
				</div>
				<%
					}
					}
				%>
			</div>
		</div>
	</div>
</div>
