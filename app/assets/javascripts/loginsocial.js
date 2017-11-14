function checkLoginState(login_facebook_path, form_authenticity_token) {
  console.log(login_facebook_path, form_authenticity_token)
  FB.getLoginStatus(function(response) {
    if (response.status === "connected") {
      var form = "<form action='" + login_facebook_path + "' method='post'>"
      form += "<input type='text' name='accessToken' value='" + response.authResponse.accessToken + "' />"
      form += "<input name='authenticity_token' value='" + form_authenticity_token + "' type='hidden'> </form>"
      form = $(form)
      $("body").append(form)
      form.submit()
    }
  })
}
