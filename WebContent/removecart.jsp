<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Get the current list of products
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    if (productList == null)
    {	// No products currently in list.  Create a list.
        out.print("Cart is Empty. Can't Remove.");
        productList = new HashMap<String, ArrayList<Object>>();
    }

// Add new product selected
// Get product information
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String quantity =  request.getParameter("qty");
    int qty = Integer.parseInt(quantity);
    ArrayList<Object> product = new ArrayList<Object>();
    if (qty > 1) {


        product.add(id);
        product.add(name);
        product.add(price);
        product.add(qty-1);
    }else {
        product.remove(id);
        product.remove(name);
        product.remove(price);
      //  product.add(qty-1);

    }


// Update quantity if add same item to order again
    if (productList.containsKey(id))
    {	product = (ArrayList<Object>) productList.get(id);
        int curAmount = ((Integer) product.get(3)).intValue();
        product.set(3, new Integer(curAmount-1));
    }
    else
        productList.put(id,product);

    session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />