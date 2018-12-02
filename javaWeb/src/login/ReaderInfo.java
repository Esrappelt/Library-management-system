package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ReaderInfo extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) 
	throws ServletException,IOException{
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
				
				//�Ȼ�ȡ����
				String stuno = request.getParameter("stuno");
				System.out.println("��ȡ�Ĳ���Ϊ��" + stuno);
				
				List<Map> list = new ArrayList<Map>();//����list�������ڴ���map�ļ�ֵ�Լ���
				//д��ѯ���
				String sql = "select *from reader where id = "+(stuno)+"";
				//��ȡ���
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()){
					String name = rs.getString("name");//��ȡ����
					String sex = rs.getString("sex");//��ȡ�Ա�
					String barcode = rs.getString("barcode");//��ȡ������
					String vocation = rs.getString("vocation");//��ȡְҵ
					String paperType = rs.getString("paperType");//��ȡ֤������
					String idCard = rs.getString("idCard");//��ȡ���֤��
					String tel = rs.getString("tel");//��ȡ�绰
					String email = rs.getString("email");//��ȡ����
					String borrownumber = rs.getString("borrownumber");//��ȡ��������
					
					//����Map
					Map map = new HashMap();
					map.put("name", name);
					map.put("sex", sex);
					map.put("barcode", barcode);
					map.put("vocation", vocation);
					map.put("paperType", paperType);
					map.put("idCard", idCard);
					map.put("tel", tel);
					map.put("email", email);
					map.put("borrownumber", borrownumber);
					System.out.println(map);//������map����һ��
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
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
		throws ServletException,IOException{
			this.doGet(request,response);
		}
}
