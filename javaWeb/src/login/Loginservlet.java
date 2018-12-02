package login;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
public class Loginservlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException,IOException{
		response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		String name = request.getParameter("name");
		String psd = request.getParameter("pwd");

 
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				String sql = "select * from manager where name=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, name);
				ResultSet rs = ps.executeQuery();
				String mima = "";
				while(rs.next()){
					//数据库取pwd这一列的值
					mima = rs.getString("pwd").trim();
				}
				if(mima.equals(psd)) {
					HttpSession session = request.getSession();
					session.setAttribute("name", name);
					//登录成功
					request.getRequestDispatcher("main.jsp").forward(request,response); 
				}else {
					//登录失败
					request.setAttribute("error", "您输入的管理员账号或密码不正确");
					request.getRequestDispatcher("index.jsp").forward(request,response); 
				}
				System.out.println("连接成功");
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println("连接错误2");
			}
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接错误1");
		}
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
		throws ServletException,IOException{
			this.doGet(request,response);
		}
}
