<!doctype html>
<html lang="en">
    <head>
        <title>Welcome ABF</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="CSS/oldstyle.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    </head>
    <body>
        <div class="body-welcome-page">
            <div class="header-welcome-page row">
                <div class="col-12 col-sm-3">
                    <img id="img" src="image/FPTU__3_-removebg-preview2png.png">
                </div>
                <div class="col-12 col-sm-9">
                    <input class="input-welcome-page" onclick="openForm(1)" type="button" id="login" value="Login">
                </div>
            </div>
            <div class="content-welcome-page">
                <h1>WELCOME TO FPT UNIVERSITY<br>ACADEMIC BLOG</h1>
            </div>
            <form class="popup-form-welcome-page" id="popupForm" action="MainController" method="POST">
                <h1>Login</h1>
                <div class="login-google-welcome-page">
                    <img src="image/104d91f71da1b56e29231059d85a1e93.jpg">
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/ABFRemake/LoginWithGoogleController&response_type=code
                       &client_id=669532097260-le7mkf9q59qpmmrtjgshdhhhctab780g.apps.googleusercontent.com&approval_prompt=force">Sign in with @fpt.edu.vn</a>
                </div>
                <div class="input-welcome-page">
                    <i class="fas fa-user-alt"></i>
                    <input type="text" placeholder="Email" name="email" required="">
                </div>
                <div class="input-welcome-page">
                    <i class="fas fa-lock"></i>
                    <input type="password" placeholder="Password" name="password" required>
                </div>
                <input class="submit-welcome-page" type="submit" name="action" value="Login">
                <i class="fa fa-close" onclick="openForm(2)"></i>
            </form>
        </div>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script>
                    function openForm(count) {
                        switch (count) {
                            case 1:
                                document.getElementById("popupForm").style.display = "block";
                                break;
                            case 2:
                                document.getElementById("popupForm").style.display = "none";
                                break;
                        }

                    }
        </script>
    </body>
</html>