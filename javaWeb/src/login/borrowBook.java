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
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//创建查询对象
				st = conn.createStatement();
				
				//连接成功后开始查询
				
				//写查询语句
				String sql = "select ifback from borrow where readerid='"+(readerid)+"' and bookid='"+(bookid)+"'";
				//书的数量减少1
				String update1Sql = "update bookinfo set bookNumber=bookNumber-1 where id='"+(bookid)+"'";
				//学生可借阅量减少1
				String update2Sql = "update reader set borrownumber=borrownumber-1 where id='"+(readerid)+"'";
				ResultSet rs = st.executeQuery(sql);
				//判断有无数据
				if(rs.next()) {
					do{
						int ifback = rs.getInt("ifback");
						//没有归还就是0
						if(ifback == 0) {
							out.println("false");
							break;
						}else {
							out.println("true");
							//这里就是还了,那么把它的ifback设置为0
							String update3sql = "update borrow set ifback=0 where readerid='"+(readerid)+"' and bookid='"+(bookid)+"'";
							st.execute(update1Sql);
							st.execute(update2Sql);
							st.execute(update3sql);
						}
					}while(rs.next());
				} else {
					//没有借过书
					//插入到借阅表
					String newSql = "insert into borrow values('"+(readerid)+"','"+(bookid)+"','"+(borrowtime)+"','"+(givebackTime)+"','"+(operator)+"',0)";
					st.execute(update1Sql);
					st.execute(update2Sql);
					st.execute(newSql);
					out.println("true");
				}
				
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		out.close();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
