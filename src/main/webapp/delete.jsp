<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");

if (id == null || id.trim().isEmpty()) {
out.println("삭제할 게시글 번호가 없습니다.");
return;
}

String url = "jdbc:mariadb://prjdb.cvue06ago8n9.ap-northeast-2.rds.amazonaws.com:3306/prjdb?sslMode=trust";
String user = "admin";
String password = "password";

Connection conn = null;
PreparedStatement pstmt = null;

try {
Class.forName("org.mariadb.jdbc.Driver");


conn = DriverManager.getConnection(url, user, password);

String sql = "DELETE FROM board WHERE id = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setInt(1, Integer.parseInt(id));

pstmt.executeUpdate();

response.sendRedirect("board.jsp");


} catch (Exception e) {
out.println("<h3>게시글 삭제 중 오류가 발생했습니다.</h3>");
out.println("<pre>" + e.getMessage() + "</pre>");

} finally {
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>
