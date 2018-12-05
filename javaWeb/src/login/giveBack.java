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

public class giveBack extends HttpServlet {

	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		//��ʼ��
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		//��ȡ����
		String stuno = request.getParameter("stuno");
		//�������ݿ����st
		Statement st;
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//������ѯ����
				st = conn.createStatement();
				System.out.println("����giveBack�ɹ�");
				
				//���ӳɹ���ʼ��ѯ
				
				List<Map> list = new ArrayList<Map>();//����list�������ڴ���map�ļ�ֵ�Լ���
				//д��ѯ���
				String sql = "select bookid,bookname,isbnName,bookNumber,price,del,barcode,author,translator from borrow join bookinfo on borrow.bookid = bookinfo.id where readerid='"+(stuno)+"' and ifback=0";
				//��ȡ���
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()){
					String bookid = rs.getString("bookid");
					String bookname = rs.getString("bookname");//��ȡͼ������
					String author = rs.getString("author");//��ȡ����
					String translator = rs.getString("translator");//��ȡ������
					String isbnName = rs.getString("isbnName");//��ȡ������
					String bookNumber = rs.getString("bookNumber");//��ȡʣ��ͼ������
					String price = rs.getString("price");//��ȡͼ��۸�
					String del = rs.getString("del");//��ȡ�Ƿ��¼�
					String barcode = rs.getString("barcode");//��ȡ��������
					//����Map
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

					list.add(map);//�����map�������list
				}
				JSONArray jsonArray = JSONArray.fromObject(list);
				System.out.print(jsonArray);
				PrintWriter out = response.getWriter();
				out.println(jsonArray);
				out.close();
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("����giveBack����2");
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("����giveBack����1");
		}
		
	}
	
	
	
	
	
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		this.doPost(request, response);
	}
}
