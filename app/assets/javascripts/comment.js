$(document).ready(function() {
    $("#container_comment").on("click", ".fa-pencil",function () {
      var p = $(this).parents(".name_author").find(".content_comment")
      var content = p.text()
      var replace = "<input value='" + content + "' class='form-control' data-content='" + content + "'>"
      replace += "<button class='btn btn-danger pull-right'>" + I18n.t("users.edit.cancel") + "</button>"
      replace += "<button class='btn btn-success pull-right'>" + I18n.t("users.edit.save") + "</button>"
      p.replaceWith(replace)
    })

    $("#container_comment").on("click", ".btn-danger",function () {
      var i = $(this).siblings("input")
      var root_content = i.data("content")
      i.siblings(".btn-success").remove()
      this.remove()
      i.replaceWith("<p class='content_comment'>" + root_content + "</p>")
    })

    $("#container_comment").on("click", ".btn-success",function () {
      var i = $(this).siblings("input")
      var content = i.val()
      var root_content = i.data("content")
      var comment_id = $(this).parent().data("id")
      var varthis = this
      $.ajax({
        type: "PATCH",
        url: "/comments/" + comment_id,
        data: {content: content},
        success: function (data) {
          i.siblings(".btn-danger").remove()
          if (data.status) {
            i.replaceWith("<p class='content_comment'>" + content + "</p>")
          } else {
            i.replaceWith("<p class='content_comment'>" +  root_content + "</p>")
          }
          varthis.remove()
        }
      })
    })

    $("#container_comment").on("click", ".fa-trash",function () {
      var parents = $(this).parents(".name_author")
      $.ajax({
        type: "DELETE",
        url: "/comments/" + parents.data("id"),
        success: function (data) {
          if  (data.status) {
            parents.parents(".comment-user").remove()
          } else {
            alert(I18n.t("comments.delete_fail"))
          }
        }
      })
    })

  startTime()
});

function startTime() {
  var today = new Date();
  var h = today.getHours();
  var m = today.getMinutes();
  var s = today.getSeconds();
  m = checkTime(m);
  s = checkTime(s);
  $("#clock").text(h + ":" + m + ":" + s)
  setTimeout(startTime, 500);
}

function checkTime(i) {
  if (i < 10) {i = "0" + i};
  return i;
}

