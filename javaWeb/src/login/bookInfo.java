package login;

import java.io.IOException;
import java.io.PrintWriter;
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

public class bookInfo extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//初始化
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		//创建数据库对象st
		Statement st;
		//获取参数
		
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//创建查询对象
				st = conn.createStatement();
				System.out.println("连接成功");
				
				//连接成功后开始查询
				
				List<Map> list = new ArrayList<Map>();//创建list集合用于存入map的键值对集合
				//写查询语句
				String sql = "select * from bookinfo";
				//获取结果
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()){
					String bookname = rs.getString("bookname");//获取图书名字
					String author = rs.getString("author");//获取作者
					String translator = rs.getString("translator");//获取翻译者
					String isbnName = rs.getString("isbnName");//获取出版社
					String bookNumber = rs.getString("bookNumber");//获取剩余图书数量
					String price = rs.getString("price");//获取图书价格
					String del = rs.getString("del");//获取是否下架
					String barcode = rs.getString("barcode");//获取是条形码
					//创建Map
					Map map = new HashMap();
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
				JSONArray jsonArray = JSONArray.fromObject(list);
				System.out.print(jsonArray);
				PrintWriter out = response.getWriter();
				out.println(jsonArray);
				out.close();
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("连接错误2");
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接错误1");
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
