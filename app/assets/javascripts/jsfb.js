(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.10&appId=1642876205728548"
  fjs.parentNode.insertBefore(js, fjs);
}(document, "script", "facebook-jssdk"));

window.fbAsyncInit = function() {
  FB.init({
    appId      : "129461111096003",
    cookie     : true,
    xfbml      : true,
    version    : "v2.10"
  });
  FB.AppEvents.logPageView();

};

(function(d, s, id){
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "https://connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, "script", "facebook-jssdk"));
