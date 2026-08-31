<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>

<%

    request.setCharacterEncoding("UTF-8");


    String idParam =
        request.getParameter("id");


    if (idParam == null) {

        response.sendRedirect(
            "/board.jsp"
        );

        return;

    }


    int id = 0;


    try {

        id =
            Integer.parseInt(idParam);

    } catch(NumberFormatException e) {

        response.sendRedirect(
            "/board.jsp"
        );

        return;

    }


    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;


    String title = null;
    String writer = null;
    String content = null;
    Timestamp regDate = null;


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
            "SELECT id, title, writer, content, reg_date " +
            "FROM board " +
            "WHERE id = ?";


        pstmt =
            conn.prepareStatement(sql);


        pstmt.setInt(
            1,
            id
        );


        rs =
            pstmt.executeQuery();


        if(rs.next()) {


            title =
                rs.getString("title");


            writer =
                rs.getString("writer");


            content =
                rs.getString("content");


            regDate =
                rs.getTimestamp("reg_date");


        } else {


            response.sendRedirect(
                "/board.jsp"
            );


            return;

        }


    } catch(Exception e) {


        out.println(
            "게시글 조회 중 오류 발생: "
            + e.getMessage()
        );


        return;


    } finally {


        try {

            if(rs != null) {
                rs.close();
            }

        } catch(Exception ignored) {}


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


<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title><%= title %></title>

    <link rel="stylesheet" href="/css/style.css">

</head>

<body>


<header class="site-header">

    <div class="header-inner">

        <div class="logo">
            TEAM 1 FINAL PROJECT
        </div>


        <nav class="nav-menu">

            <a href="/index.jsp">
                Home
            </a>

            <a href="/report.jsp">
                Report
            </a>

            <a href="/board.jsp">
                Board
            </a>

        </nav>

    </div>

</header>


<main>


<section class="view-section">


    <div class="view-inner">


        <div class="view-header">

            <h1>
                <%= title %>
            </h1>


            <div class="view-meta">

                <span>
                    작성자
                    <strong>
                        <%= writer %>
                    </strong>
                </span>


                <span>
                    <%= regDate %>
                </span>

            </div>


        </div>


        <div class="view-content">

            <%= content
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\r\n", "<br>")
                .replace("\n", "<br>") %>

        </div>


        <div class="view-actions">

            <a href="/board.jsp"
               class="cancel-button">

                목록으로

            </a>

        </div>


    </div>


</section>


</main>

</body>

</html>
