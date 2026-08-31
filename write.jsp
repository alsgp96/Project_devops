<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>새 글 작성</title>

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

<section class="write-section">

    <div class="write-inner">


        <div class="write-header">

            <h1>
                새 글 작성
            </h1>

            <p>
                프로젝트 진행 내용이나 기술 기록을 작성할 수 있습니다.
            </p>

        </div>


        <form
            method="post"
            action="/write_process.jsp"
            class="write-form">


            <div class="form-group">

                <label for="title">
                    제목
                </label>

                <input
                    type="text"
                    id="title"
                    name="title"
                    maxlength="200"
                    placeholder="게시글 제목을 입력하세요"
                    required>

            </div>


            <div class="form-group">

                <label for="writer">
                    작성자
                </label>

                <input
                    type="text"
                    id="writer"
                    name="writer"
                    maxlength="50"
                    placeholder="작성자 이름을 입력하세요"
                    required>

            </div>


            <div class="form-group">

                <label for="content">
                    내용
                </label>

                <textarea
                    id="content"
                    name="content"
                    rows="14"
                    placeholder="내용을 입력하세요"
                    required></textarea>

            </div>


            <div class="write-actions">

                <a href="/board.jsp"
                   class="cancel-button">

                    취소

                </a>


                <button
                    type="submit"
                    class="submit-button">

                    게시글 등록

                </button>

            </div>

        </form>


    </div>

</section>

</main>

</body>

</html>
