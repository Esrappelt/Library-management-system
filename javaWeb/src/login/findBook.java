package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import java.util.*;
public class findBook extends HttpServlet {

	
	 
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";

		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				System.out.println("连接findBook成功");
				
				List<Map> list = new ArrayList<Map>();//创建list集合用于存入map的键值对集合
				
				Enumeration paramNames = request.getParameterNames();//获取全部的参数
				while(paramNames.hasMoreElements()){
					//获取参数名
					String paramName = (String)paramNames.nextElement();
					//获取值
					String paramValue = request.getParameter(paramName);
					//值解码
					paramValue = URLDecoder.decode(paramValue,"utf-8");
				    System.out.println(paramName + " " + paramValue );
				    //查询语句
				    String sql = "select * from bookinfo where "+(paramName)+" like '%"+(paramValue)+"%'";
				    PreparedStatement ps = conn.prepareStatement(sql);
				    //开始查询
				    ResultSet rs = ps.executeQuery();
				    
				    //获取结果
				    while(rs.next()){
				    	String bookid = rs.getString("id");
						String bookname = rs.getString("bookname");//获取图书名字
						String author = rs.getString("author");//获取作者
						String translator = rs.getString("translator");//获取翻译者
						String isbnName = rs.getString("isbnName");//获取出版社
						String bookNumber = rs.getString("bookNumber");//获取剩余图书数量
						String price = rs.getString("price");//获取图书价格
						String del = rs.getString("del");//获取是否下架
						String barcode = rs.getString("barcode");//获取是条形码

						Map map = new HashMap();
						map.put("bookid", bookid);
						map.put("bookname", bookname);
						map.put("author", author);
						map.put("translator", translator);
						map.put("isbnName", isbnName);
						map.put("bookNumber", bookNumber);
						map.put("price", price);
						map.put("del", del);
						map.put("barcode", barcode);
						
						list.add(map);//将这个map对象放入list
					}
				}
				//转为Json格式
				JSONArray jsonArray = JSONArray.fromObject(list);
				System.out.print(jsonArray);
				PrintWriter out = response.getWriter();
				out.println(jsonArray);
				out.close();
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println("连接findBook错误2");
			}
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接findBook错误1");
		}
		
		
	}

}
