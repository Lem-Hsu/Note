<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
	<title>登陆</title>
</head>
<body>
<center>
	<h1>留言管理</h1>
	<hr>
	<br>
	<%
		// 进行乱码处理
		request.setCharacterEncoding("UTF-8") ;
	%>
	<%
		if(session.getAttribute("uname")!=null)
		{
			// 用户已登陆
	%>
	<%!
		String dbURL = "jdbc:derby://localhost:1527/Message;create=true;user=Administrator;password=admin";
		Connection conn	 = null ;
		PreparedStatement pstmt	= null ;
		ResultSet rs = null ;
	%>
	<%
		// 声明一个boolean变量
		boolean flag = false ;

		// 接收参数
		String title = request.getParameter("title") ;
		String author = request.getParameter("author") ;
		String content = request.getParameter("content") ;
	%>
	<%
		// 现在note表中的主键是sequence生成
		String sql = "INSERT INTO message(title, author, content) VALUES(?,?,?)" ;
		try
		{
			Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
			conn = DriverManager.getConnection(dbURL) ;
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setString(1, title) ;
			pstmt.setString(2, author) ;
			pstmt.setString(3, content) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
			conn.close() ;
			// 如果插入成功，则肯定能执行到此段代码
			flag = true ;
		}
		catch(Exception e)
		{}
	%>
	<%
			response.setHeader("refresh","2;URL=list_notes.jsp") ;
			if(flag)
			{
	%>
				留言添加成功，两秒后跳转到留言列表页！！！<br>
				如果没有跳转，请按<a href="list_notes.jsp">这里</a>！！！
	<%
			}
			else
			{
	%>
				留言添加失败，两秒后跳转到留言列表页！！！<br>
				如果没有跳转，请按<a href="list_notes.jsp">这里</a>！！！
	<%
			}
	%>
	<%
		}
		else
		{
			// 用户未登陆，提示用户登陆，并跳转
			response.setHeader("refresh","2;URL=login.jsp") ;
	%>
			您还未登陆，请先登陆！！！<br>
			两秒后自动跳转到登陆窗口！！！<br>
			如果没有跳转，请按<a href="login.jsp">这里</a>！！！<br>
	<%
		}
	%>
</center>
</body>
</html>