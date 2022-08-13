<%-- 
    Document   : feedback
    Created on : Jun 3, 2022, 2:27:41 AM
    Author     : To Quyen Phan
--%>

<%@page import="dto.FeedbackTypeDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Feedback Page</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="CSS/oldstyle.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body class="body-feedback-page">
        <div class="container-feedback-page">
            <div class="wrapper-feedback-page">
                <p class="text-feedback-page">How Would You Rate This Website?</p>
                <div class="emoji">
                    <div>🥺</div>
                    <div>🙁</div>
                    <div>😌</div>
                    <div>😊</div>
                    <div>😍</div>
                </div>
                <br>
                <%
                    String message = (String) request.getAttribute("MESSAGE");
                    if (message != null) {
                %>
                <%= message%>
                <%
                    }
                %>
            </div>
            <form class="form-feedback-page" action="MainController">
                <h3>Send us your feedback!</h3>
                <div class="select-group">

                    <label class="label-for-feedback-type" for="button">What do you give feedback for?</label>
                    <button id="button" class="button">
                        <span id="select-label">- please select one -</span>
                        <div id="arrow" class="arrow"></div>
                    </button>
                    <%
                        String messageFeedback = (String) request.getAttribute("MESSAGE_FOR_FEEDBACK_TYPE");
                        if (messageFeedback != null) {
                    %>
                    <h4 class="h4-feedback-page" id="message"><%= messageFeedback%></h4>
                    <%
                        }
                    %>
                    <div class="dropdown hidden" id="dropdown">
                        <%
                            List<FeedbackTypeDTO> listAllFeedbackTypes = (List<FeedbackTypeDTO>) request.getAttribute("LIST_ALL_FEEDBACK_TYPE");
                            if (listAllFeedbackTypes != null) { //chỉ hiển thị khi người dùng đã đăng nhập
                                if (listAllFeedbackTypes.size() > 0) {
                                    for (FeedbackTypeDTO feedbackType : listAllFeedbackTypes) {
                        %>
                        <input type="radio" id="<%= feedbackType.getFeedbackTypeID()%>" name="where" value="<%= feedbackType.getFeedbackTypeID()%>" class="option">
                        <label for="<%= feedbackType.getFeedbackTypeID()%>" class="select-item"><%= feedbackType.getFeedbackName()%></label>
                        <%
                                    }
                                }
                            }
                        %>
                        <!--<input type="radio" id="select-student" name="where" value="2" class="option">
                        <label for="select-student" class="select-item">About Student</label>

                        <input type="radio" id="select-mentor" name="where" value="3" class="option">
                        <label for="select-mentor" class="select-item">About Mentor</label>-->
                    </div>

                </div>
                <h4 class="label-for-feedback-type">Description:</h4>
                <textarea class="textarea-feedback-page" id="" cols="30" rows="4" placeholder="Write your description ..." name="description"></textarea>
                <a style="text-decoration: none;" href="MainController?action=GetList">Cancel</a>
                <input type="submit" name="action" value="Send">
            </form>
        </div> 
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script>
            const container = document.querySelector('.container-feedback-page');
            const emoji = document.querySelector('.emoji');
            const form = document.querySelector('.form-feedback-page');

            emoji.addEventListener('click', (e) => {
                if (e.target.className.includes('emoji'))
                    return;
                form.classList.add('form-feedback-page--active');
            });


            const button = document.querySelector('#button');
            const select = document.querySelector("#dropdown");
            const options = document.querySelectorAll(".option");
            const selectLabel = document.querySelector('#select-label');
            const h4 = document.getElementById("message");

            button.addEventListener("click", function (e) {
                e.preventDefault();
                toggleHidden();
            });

            function toggleHidden() {
                select.classList.toggle("hidden");
            }

            options.forEach(function (option) {
                option.addEventListener("click", function (e) {
                    setSelectTitle(e);
                    h4.style.display = "none";
                });
            });

            function setSelectTitle(e) {
                const labelElement = document.querySelector('input[name="where"]:checked').value;
                switch (labelElement) {
                    case '1':
                        selectLabel.innerText = "About System";
                        break;
                    case '2':
                        selectLabel.innerText = "About Student";
                        break;
                    case '3':
                        selectLabel.innerText = "About Mentor";
                        break;
                }
                
                toggleHidden();
            }
            ;
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
