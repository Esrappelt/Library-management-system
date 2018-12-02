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
		//��ʼ��
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=library";
		String user = "sa";
		String pwd = "160510111xyj";
		//�������ݿ����st
		Statement st;
		//��ȡ����
		
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//������ѯ����
				st = conn.createStatement();
				System.out.println("���ӳɹ�");
				
				//���ӳɹ���ʼ��ѯ
				
				List<Map> list = new ArrayList<Map>();//����list�������ڴ���map�ļ�ֵ�Լ���
				//д��ѯ���
				String sql = "select * from bookinfo";
				//��ȡ���
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()){
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
			System.out.println("���Ӵ���2");
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("���Ӵ���1");
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
