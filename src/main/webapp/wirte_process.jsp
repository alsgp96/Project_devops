<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>

<%

    request.setCharacterEncoding("UTF-8");


    String title =
        request.getParameter("title");


    String writer =
        request.getParameter("writer");


    String content =
        request.getParameter("content");


    /*
     * 빈 값 검사
     */

    if (title == null ||
        title.trim().isEmpty() ||

        writer == null ||
        writer.trim().isEmpty() ||

        content == null ||
        content.trim().isEmpty()) {


        out.println(
            "<script>" +
            "alert('제목, 작성자, 내용을 모두 입력해주세요.');" +
            "history.back();" +
            "</script>"
        );


        return;

    }


    Connection conn = null;

    PreparedStatement pstmt = null;


    try {


        Class.forName(
            "org.mariadb.jdbc.Driver"
        );


        conn =
            DriverManager.getConnection(

                "jdbc:mariadb://43.202.63.190:3306/boarddb",

                "admin",

                "1234"

            );


        String sql =
            "INSERT INTO board " +
            "(title, writer, content) " +
            "VALUES (?, ?, ?)";


        pstmt =
            conn.prepareStatement(sql);


        pstmt.setString(
            1,
            title
        );


        pstmt.setString(
            2,
            writer
        );


        pstmt.setString(
            3,
            content
        );


        pstmt.executeUpdate();


        /*
         * 글 작성 완료 후
         * 게시판 목록으로 이동
         */

        response.sendRedirect(
            "/board.jsp"
        );


        return;


    } catch(Exception e) {


        out.println(
            "<h3>게시글 저장 중 오류가 발생했습니다.</h3>"
        );


        out.println(
            "<pre>" +
            e.getMessage() +
            "</pre>"
        );


    } finally {


        try {

            if(pstmt != null) {
                pstmt.close();
            }

        } catch(Exception ignored) {}


        try {

            if(conn != null) {
                conn.close();
            }

        } catch(Exception ignored) {}

    }

%>
