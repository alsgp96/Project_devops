<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>PROJECT BOARD</title>

    <link rel="stylesheet" href="/css/style.css">
</head>

<body>


<!-- =========================
     HEADER
========================= -->

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

<section class="board-section">

    <div class="board-inner">


        <!-- BOARD HEADER -->

        <div class="board-header">

            <h1>
                프로젝트 게시판
            </h1>

            <p>
                프로젝트 진행 과정과 기술 내용을 기록하고 공유합니다.
            </p>

        </div>


        <!-- TOOLBAR -->

        <div class="board-toolbar">

            <div class="board-search">

                <form method="get"
                      action="/board.jsp">

                    <input
                        type="text"
                        name="keyword"
                        placeholder="게시글 제목 검색"
                        value="<%= request.getParameter("keyword") != null
                            ? request.getParameter("keyword")
                            : "" %>">

                    <button type="submit">
                        검색
                    </button>

                </form>

            </div>


            <a href="/write.jsp"
               class="write-button">

                + 새 글 작성

            </a>

        </div>


        <!-- BOARD TABLE -->

        <div class="board-card">


            <div class="board-table-header">

                <div class="col-number">
                    번호
                </div>

                <div class="col-title">
                    제목
                </div>

                <div class="col-writer">
                    작성자
                </div>

                <div class="col-date">
                    작성일
                </div>

            </div>


            <div class="board-list">

<%

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {

        Class.forName(
            "org.mariadb.jdbc.Driver"
        );


        conn =
            DriverManager.getConnection(

                "jdbc:mariadb://prjdb.cvue06ago8n9.ap-northeast-2.rds.amazonaws.com:3306/boarddb",

                "admin",

                "password"

            );


        String keyword =
            request.getParameter("keyword");


        String sql;


        if (keyword != null &&
            !keyword.trim().isEmpty()) {


            sql =
                "SELECT id, title, writer, reg_date " +
                "FROM board " +
                "WHERE title LIKE ? " +
                "ORDER BY id DESC";


            pstmt =
                conn.prepareStatement(sql);


            pstmt.setString(
                1,
                "%" + keyword + "%"
            );


        } else {


            sql =
                "SELECT id, title, writer, reg_date " +
                "FROM board " +
                "ORDER BY id DESC";


            pstmt =
                conn.prepareStatement(sql);

        }


        rs =
            pstmt.executeQuery();


        boolean hasPost = false;


        while (rs.next()) {

            hasPost = true;

%>


                <div class="board-row">


                    <div class="col-number">

                        <%= rs.getInt("id") %>

                    </div>


                    <div class="col-title">

                        <a href="/view.jsp?id=<%= rs.getInt("id") %>">

                            <%= rs.getString("title") %>

                        </a>

                    </div>


                    <div class="col-writer">

                        <%= rs.getString("writer") %>

                    </div>


                    <div class="col-date">

                        <%= rs.getTimestamp("reg_date") %>

                    </div>


                </div>


<%

        }


        if (!hasPost) {

%>

                <div class="board-empty">

                    등록된 게시글이 없습니다.

                </div>

<%

        }


    } catch(Exception e) {

%>

                <div class="board-empty">

                    게시글을 불러오지 못했습니다.

                    <br>

                    <small>
                        <%= e.getMessage() %>
                    </small>

                </div>

<%

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

            </div>

        </div>


    </div>

</section>

</main>

</body>

</html>
