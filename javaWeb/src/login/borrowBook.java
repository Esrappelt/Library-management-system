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
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class borrowBook extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		//初始化
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		//创建数据库对象st
		Statement st;
		//获取参数
		String readerid = request.getParameter("readerid");
		String bookid = request.getParameter("bookid");
		String borrowtime = request.getParameter("borrowtime");
		String givebackTime = request.getParameter("givebackTime");
		String operator = request.getParameter("operator");
		operator = URLDecoder.decode(operator,"utf-8");
		System.out.print("operator=" + operator );
		System.out.print("readerid=" + readerid + ",bookid=" + bookid);
		System.out.print("givebackTime=" + givebackTime + ",borrowtime=" + borrowtime);
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//创建查询对象
				st = conn.createStatement();
				System.out.println("连接borrowBook成功");
				
				//连接成功后开始查询
				
				//写查询语句
				String sql = "select readerid,bookid from borrow where readerid='"+(readerid)+"' and bookid='"+(bookid)+"'";
				boolean flag = true;
				ResultSet rs = st.executeQuery(sql);
				
				System.out.print(rs);
				//获取结果
				
				while(rs.next()) {
					String getReaderid = rs.getString("readerid");
					String getBbookid = rs.getString("bookid");
					if(readerid.equals(getReaderid) && getBbookid.equals(bookid)) {
						System.out.print("已经借了这本书");
						flag = false;
						break;
					}
				}
				//如果没有这条信息,就加入到数据库
				if(flag){
					String newSql = "insert into borrow values('"+(readerid)+"','"+(bookid)+"','"+(borrowtime)+"','"+(givebackTime)+"','"+(operator)+"',0)";
					st.execute(newSql);
					out.println("true");
				}else {
					//已经借了这本书,不插入数据
					out.println("false");
				}
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println("连接borrowBook错误2");
			}
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接borrowBook错误1");
		}
		out.close();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
