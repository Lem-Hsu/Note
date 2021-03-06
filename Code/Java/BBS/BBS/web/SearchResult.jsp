<%-- 
    Document   : SearchResult
    Created on : Jun 25, 2018, 5:28:29 PM
    Author     : hsu
--%>

<%@page import="java.util.Date"%>
<%@page import="DAO.MessageDaoConn"%>
<%@page import="Model.Message"%>
<%@page import="java.util.List"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=request.getParameter("cata")%>版</title>
        <script type="text/javascript">
        </script>
        <style type="text/css">
            .message_wrap{
                width: 960px;
                margin: 10px auto;
            }
        </style>
        <script>
            function checkNewPost() {
                var flag = <%=session.getAttribute("sessionAccount")%>;
                if (flag == null) {
                    var returnVal = window.confirm("未登录或登录已失效！请登录！", "提示");
                    if (returnVal) {
                        location.href = 'Login.jsp';
                    }
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <div class="topNav">
            <jsp:include page="/top.jsp"></jsp:include>
            </div>
            <div class="message_wrap">
            <%
                int maxNum = 10;//每页容纳最大帖子数
                long count = 0;//帖子数
                int firstPage = 1; //首页
                int lastPage = 1; // 尾页
                int pageNo = 1; //当前页号
                if (request.getParameter("pageNo") == null || request.
                        getParameter("pageNo").equals("")) {
                    pageNo = 1;
                } else {
                    pageNo = Integer.parseInt(request.getParameter("pageNo"));
                }

                MessageDaoConn messageDaoConn = new MessageDaoConn();
                String keywords = request.getParameter("keys");

                if (null == keywords || "" == keywords) {
                    response.sendRedirect("index.jsp");
                }

                String[] keys = keywords.split(" ");
                List<Message> messageList = messageDaoConn.searchMessageByKeyword(keys);
                count = messageList.size();

                lastPage = (int) Math.ceil((double) count / maxNum);//向上取整获得尾页
                int firstMessageId = 1 + (pageNo - 1) * maxNum; //本页首个帖子id

                for (int i = 0; i < maxNum; i++) {
                    int MessageId = firstMessageId + i - 1;//帖子索引
                    //板块索引大于count时说明已经没有板块了
                    if (count <= MessageId) {
                        break;
                    }
                    Message m = messageList.get(MessageId);
                    String message_title = m.getMessage_title();
                    String message_account_name = m.getMessage_account_name();
                    long message_id = m.getMessage_id();
                    Date message_date = m.getMessage_date();
                    long revert_num = m.getRevert_num();
            %>
            <table>
                <tr>
                    <td width="500" rowspan="3">
                        <a href="details.jsp?message=<%=message_title%>&id=<%=message_id%>"><%=message_title%></a>
                    </td>
                    <td>
                        发帖人:<%=message_account_name%>
                    </td>
                </tr>
                <tr>
                    <td>
                        发帖时间:<%=message_date%>
                    </td>
                </tr>
                <tr>
                    <td>
                        回复数:<%=revert_num%>
                    </td>
                </tr>
            </table>
            <%
                }
            %>
            <a href="newpost.jsp?cata=<%=request.getParameter("cata")%>&id=<%=request.getParameter("id")%>"  onclick="return checkNewPost();">发个新帖?</a>
            <div class="page">  
                <p>当前页:  <%=pageNo%> 总页数:  <%=lastPage%></p>
                <form action="./MessagePageServlet" >
                    <table>
                        <tr>
                            <td><a href="message.jsp?pageNo=<%=firstPage%>&cata=<%=request.getParameter("cata")%>&id=<%=request.getParameter("id")%>">【首页】</a></td>
                            <td><a href="message.jsp?pageNo=<%=pageNo - 1%>&cata=<%=request.getParameter("cata")%>&id=<%=request.getParameter("id")%>">【上一页】</a></td>
                            <td><a href="message.jsp?pageNo=<%=pageNo + 1%>&cata=<%=request.getParameter("cata")%>&id=<%=request.getParameter("id")%>">【下一页】</a></td>
                            <td><a href="message.jsp?pageNo=<%=lastPage%>&cata=<%=request.getParameter("cata")%>&id=<%=request.getParameter("id")%>">【尾页】</a></td>
                            <td>输入页号: <select name="selectPage" style="width:70px;height:24px;border-radius:0;border: 1px solid silver;">
                                    <option value="0">请选择</option>
                                    <%
                                        for (int i = 0; i < lastPage; i++) {
                                            out.println("<option value=\"" + (i
                                                    + 1) + "\">" + (i + 1)
                                                    + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                            <td>
                                <input name="keys" hidden="hidden" value="<%=request.getParameter("keys")%>">
                                <input type="submit" value="GO">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>