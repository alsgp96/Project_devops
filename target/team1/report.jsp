<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>최종 프로젝트 보고서</title>

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

    <section class="report-section">

        <div class="report-inner">


            <!-- 보고서 제목 -->

            <div class="report-header">

                <h2>
                    최종 프로젝트 보고서
                </h2>

                <p>
                    프로젝트 설계부터 구축 및 검증까지의 전체 과정을 확인할 수 있습니다.
                </p>

            </div>


            <!-- PDF VIEWER -->

            <div class="pdf-viewer">


                <div class="pdf-canvas-wrapper">

                    <canvas id="pdf-render"></canvas>

                </div>


                <div class="pdf-controls">


                    <button id="prev-page"
                            type="button">

                        ← PREVIOUS

                    </button>


                    <div class="page-info">

                        <span id="page-num">
                            1
                        </span>

                        <span class="page-divider">
                            /
                        </span>

                        <span id="page-count">
                            0
                        </span>

                    </div>


                    <button id="next-page"
                            type="button">

                        NEXT →

                    </button>


                </div>


            </div>


        </div>

    </section>

</main>


<script
    src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js">
</script>


<script>

    const url = '/rsc/final-project.pdf';


    pdfjsLib.GlobalWorkerOptions.workerSrc =
        'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';


    let pdfDoc = null;
    let pageNum = 1;
    let pageRendering = false;
    let pageNumPending = null;

    const scale = 1.5;


    const canvas =
        document.getElementById('pdf-render');


    const ctx =
        canvas.getContext('2d');


    function renderPage(num) {

        pageRendering = true;


        pdfDoc.getPage(num).then(function(page) {

            const viewport =
                page.getViewport({
                    scale: scale
                });


            canvas.width =
                viewport.width;

            canvas.height =
                viewport.height;


            const renderContext = {

                canvasContext: ctx,

                viewport: viewport

            };


            const renderTask =
                page.render(renderContext);


            renderTask.promise.then(function() {

                pageRendering = false;


                if (pageNumPending !== null) {

                    renderPage(pageNumPending);

                    pageNumPending = null;

                }

            });

        });


        document
            .getElementById('page-num')
            .textContent = num;

    }


    function queueRenderPage(num) {

        if (pageRendering) {

            pageNumPending = num;

        }

        else {

            renderPage(num);

        }

    }


    function previousPage() {

        if (!pdfDoc || pageNum <= 1) {
            return;
        }


        pageNum--;


        queueRenderPage(pageNum);

    }


    function nextPage() {

        if (!pdfDoc ||
            pageNum >= pdfDoc.numPages) {

            return;
        }


        pageNum++;


        queueRenderPage(pageNum);

    }


    document
        .getElementById('prev-page')
        .addEventListener(
            'click',
            previousPage
        );


    document
        .getElementById('next-page')
        .addEventListener(
            'click',
            nextPage
        );


    pdfjsLib
        .getDocument(url)
        .promise
        .then(function(pdf) {

            pdfDoc = pdf;


            document
                .getElementById('page-count')
                .textContent =
                pdf.numPages;


            renderPage(pageNum);

        })

        .catch(function(error) {

            console.error(
                'PDF Load Error:',
                error
            );

        });

</script>


</body>

</html>
