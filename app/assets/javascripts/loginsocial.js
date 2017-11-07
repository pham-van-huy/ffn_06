function checkLoginState() {
  FB.getLoginStatus(function(response) {
    if (response.status === "connected") {
      var url = "<%= login_facebook_path.to_s %>"
      var authenticity_token = "<%= form_authenticity_token %>"
      var form = "<form action='" + url + "' method='post'>"
      form += "<input type='text' name='accessToken' value='" + response.authResponse.accessToken + "' />"
      form += "<input name='authenticity_token' value='" + authenticity_token + "' type='hidden'> </form>"
      form = $(form)
      $("body").append(form)
      form.submit()
    }
  })
}
