<%

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/imageuploadservelet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class imageuploadservelet extends HttpServlet {

// database connection settings
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
String uid = "kverma";
String pw ="41062175";

// gets values of text fields
String productID = request.getParameter("productID");
String Name = request.getParameter("productName");
String price = request.getParameter("price");
String desc = request.getParameter("desc");
String category = request.getParameter("category");


InputStream inputStream = null; // input stream of the upload file

// obtains the upload file part in this multipart request
Part filePart = request.getPart("image");
if (filePart != null) {
// prints out some information for debugging
System.out.println(filePart.getName());
System.out.println(filePart.getSize());
System.out.println(filePart.getContentType());

// obtains input stream of the upload file
inputStream = filePart.getInputStream();
}
// connection to the database
String message = null;  // message will be sent back to client

try (
Connection con = DriverManager.getConnection(url, uid, pw)) {

// constructs SQL statement
String sql = "INSERT INTO product (productName, productPrice, productImage,productDesc,categoryId) values (?, ?, ?,?,?)"; /*productId           INT IDENTITY,
productName         VARCHAR(40),
productPrice        DECIMAL(10,2),
productImageURL     VARCHAR(100),
productImage        VARBINARY(MAX),
productDesc         VARCHAR(1000),
categoryId          INT,*/
PreparedStatement x = con.prepareStatement(sql);

x.setString(1, Name);
x.setDouble(2,Double.parseDouble(price));
x.setString(4, desc);
x.setInt(5,Integer.parseInt(category));
if (inputStream != null) {
// fetches input stream of the upload file for the blob column
x.setBlob(3, inputStream);
}

// sends the statement to the database server
int row = x.executeUpdate();
if (row > 0) {
message = "File uploaded and saved into database";
}
}catch (SQLException ex) {
message = "ERROR: " + ex.getMessage();
ex.printStackTrace();
}



}%>
