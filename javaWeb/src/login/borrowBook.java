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
		//��ʼ��
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		//�������ݿ����st
		Statement st;
		//��ȡ����
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
				//������ѯ����
				st = conn.createStatement();
				System.out.println("����borrowBook�ɹ�");
				
				//���ӳɹ���ʼ��ѯ
				
				//д��ѯ���
				String sql = "select readerid,bookid from borrow where readerid='"+(readerid)+"' and bookid='"+(bookid)+"'";
				boolean flag = true;
				ResultSet rs = st.executeQuery(sql);
				
				System.out.print(rs);
				//��ȡ���
				
				while(rs.next()) {
					String getReaderid = rs.getString("readerid");
					String getBbookid = rs.getString("bookid");
					if(readerid.equals(getReaderid) && getBbookid.equals(bookid)) {
						System.out.print("�Ѿ������Ȿ��");
						flag = false;
						break;
					}
				}
				//���û��������Ϣ,�ͼ��뵽���ݿ�
				if(flag){
					String newSql = "insert into borrow values('"+(readerid)+"','"+(bookid)+"','"+(borrowtime)+"','"+(givebackTime)+"','"+(operator)+"',0)";
					st.execute(newSql);
					out.println("true");
				}else {
					//�Ѿ������Ȿ��,����������
					out.println("false");
				}
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println("����borrowBook����2");
			}
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("����borrowBook����1");
		}
		out.close();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
