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
					//���ݿ�ȡpwd��һ�е�ֵ
					mima = rs.getString("pwd").trim();
				}
				if(mima.equals(psd)) {
					HttpSession session = request.getSession();
					session.setAttribute("name", name);
					//��¼�ɹ�
					String site = "main.jsp";
					request.getRequestDispatcher(site).forward(request,response); 
				}else {
					//��¼ʧ��
					request.setAttribute("error", "������Ĺ���Ա�˺Ż����벻��ȷ");
					request.getRequestDispatcher("index.jsp").forward(request,response); 
				}
				System.out.println("����Loginservlet�ɹ�");
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println("����Loginservlet����2");
			}
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("����Loginservlet����1");
		}
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
		throws ServletException,IOException{
			this.doGet(request,response);
		}
}
