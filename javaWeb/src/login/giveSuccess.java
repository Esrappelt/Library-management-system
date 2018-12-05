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
import java.util.*;
import java.util.*;
public class giveSuccess extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		//初始化
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		//获取参数
		String bookid = request.getParameter("bookid");
		String readerid = request.getParameter("stuno");	
		String backTime = request.getParameter("backTime");
		String operator = request.getParameter("operator");
		operator = URLDecoder.decode(operator,"utf-8");
		System.out.println(backTime);
		//获取的当前时间

		//创建数据库对象st
		Statement st;
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//创建查询对象
				st = conn.createStatement();
				System.out.println("连接giveSuccess成功");
				
				//连接成功后开始查询
				
				//写查询语句
				//图书的数量增加1
				String bookBackSql = "update bookinfo set bookNumber=bookNumber+1 where id='"+(bookid)+"'";
				//读者的借阅数量增加1
				String update2Sql = "update reader set borrownumber=borrownumber+1 where id='"+(readerid)+"'";
				//借书表更新读者已归还
				String givedSql = "update borrow set ifback=1 where readerid='"+(readerid)+"' and bookid='"+(bookid)+"'";
				//插入到归还表里面
				String backdSql = "insert into giveback values('"+(readerid)+"','"+(bookid)+"','"+(backTime)+"','"+(operator)+"');";
				//执行结果
				
				st.execute(bookBackSql);
				st.execute(update2Sql);
				st.execute(givedSql);
				st.execute(backdSql);
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("连接giveSuccess错误2");
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接giveSuccess错误1");
		}
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
