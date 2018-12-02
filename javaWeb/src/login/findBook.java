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
				System.out.println("���ӳɹ�");
				
				List<Map> list = new ArrayList<Map>();//����list�������ڴ���map�ļ�ֵ�Լ���
				
				Enumeration paramNames = request.getParameterNames();//��ȡȫ���Ĳ���
				while(paramNames.hasMoreElements()){
					//��ȡ������
					String paramName = (String)paramNames.nextElement();
					//��ȡֵ
					String paramValue = request.getParameter(paramName);
					//ֵ����
					paramValue = URLDecoder.decode(paramValue,"utf-8");
				    System.out.println(paramName + " " + paramValue );
				    //��ѯ���
				    String sql = "select * from bookinfo where "+(paramName)+" like '%"+(paramValue)+"%'";
				    PreparedStatement ps = conn.prepareStatement(sql);
				    //��ʼ��ѯ
				    ResultSet rs = ps.executeQuery();
				    
				    //��ȡ���
				    while(rs.next()){
						String bookname = rs.getString("bookname");//��ȡͼ������
						String author = rs.getString("author");//��ȡ����
						String translator = rs.getString("translator");//��ȡ������
						String isbnName = rs.getString("isbnName");//��ȡ������
						String bookNumber = rs.getString("bookNumber");//��ȡʣ��ͼ������
						String price = rs.getString("price");//��ȡͼ��۸�
						String del = rs.getString("del");//��ȡ�Ƿ��¼�
						String barcode = rs.getString("barcode");//��ȡ��������

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
				}
				//תΪJson��ʽ
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

}
