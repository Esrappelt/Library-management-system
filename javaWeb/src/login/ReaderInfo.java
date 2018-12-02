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
				
				//先获取参数
				String stuno = request.getParameter("stuno");
				System.out.println("获取的参数为：" + stuno);
				
				List<Map> list = new ArrayList<Map>();//创建list集合用于存入map的键值对集合
				//写查询语句
				String sql = "select *from reader where id = "+(stuno)+"";
				//获取结果
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()){
					String name = rs.getString("name");//获取姓名
					String sex = rs.getString("sex");//获取性别
					String barcode = rs.getString("barcode");//获取条形码
					String vocation = rs.getString("vocation");//获取职业
					String paperType = rs.getString("paperType");//获取证件类型
					String idCard = rs.getString("idCard");//获取身份证号
					String tel = rs.getString("tel");//获取电话
					String email = rs.getString("email");//获取邮箱
					String borrownumber = rs.getString("borrownumber");//获取借书数量
					
					//创建Map
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
					System.out.println(map);//输出这个map，看一下
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
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
		throws ServletException,IOException{
			this.doGet(request,response);
		}
}
