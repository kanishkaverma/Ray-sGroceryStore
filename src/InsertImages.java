import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertImages {


        public static void main(String[] argv) throws Exception {
            String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
            String uid = "kverma";
            String pw ="41062175";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection con = DriverManager.getConnection(url, uid, pw);) {

                for (int i = 1; i < 30; i++) {
                    File imgfile = new File("C:\\Users\\kanishka\\Desktop\\304_lab7\\WebContent\\img\\" + i + "_a" + ".jpg");
                    FileInputStream fin = new FileInputStream(imgfile);
                    PreparedStatement pre = con.prepareStatement("UPDATE Product SET productImage = ? WHERE ProductId = ?;");
                    System.out.println(fin);
                    //pre.setInt(1, 5);
                    //pre.setString(2, "A");
                    pre.setBinaryStream(1, fin, (int) imgfile.length());
                    pre.setInt(2,i);
                    pre.executeUpdate();
                }
            } catch (SQLException e ) {e.printStackTrace();
            }

        }


}
