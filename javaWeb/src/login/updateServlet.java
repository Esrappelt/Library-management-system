package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class updateServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		String v1 = URLDecoder.decode(request.getParameter("v1"),"utf-8");
		String v2 = URLDecoder.decode(request.getParameter("v2"),"utf-8");
		String v3 = URLDecoder.decode(request.getParameter("v3"),"utf-8");
		String v4 = URLDecoder.decode(request.getParameter("v4"),"utf-8");
		String v5 = URLDecoder.decode(request.getParameter("v5"),"utf-8");
		String v6 = URLDecoder.decode(request.getParameter("v6"),"utf-8");
		String v7 = URLDecoder.decode(request.getParameter("v7"),"utf-8");
		String barcode = request.getParameter("barcode");
		int del = (v7.equals("已下架")) ? 1 : 0;
		Statement st;
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				st = conn.createStatement();
				String sql = "update bookinfo set bookname='"+(v2)+"',isbnName='"+(v3)+"',author='"+(v4)+"',price="+(v5)+",bookNumber="+(v6)+",del="+(del)+" where barcode='"+(barcode)+"'";
				st.execute(sql);
		}catch(SQLException e) {
			e.printStackTrace();
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
