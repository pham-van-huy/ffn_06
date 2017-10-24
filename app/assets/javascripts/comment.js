$(document).ready(function() {
    $("#container_comment").on("click", ".fa-pencil",function () {
      var p = $(this).parents(".name_author").find(".content_comment")
      var content = p.text()
      p.replaceWith(`<input value="${content}" class="form-control" data-content="${content}">
        <button class="btn btn-danger pull-right">cancel</button>
        <button class="btn btn-success pull-right">save</button>`)
    })

    $("#container_comment").on("click", ".btn-danger",function () {
      var i = $(this).siblings("input")
      var root_content = i.data("content")
      i.siblings(".btn-success").remove()
      this.remove()
      i.replaceWith(`<p class="content_comment">${root_content}</p>`)
    })

    $("#container_comment").on("click", ".btn-success",function () {
      var i = $(this).siblings("input")
      var content = i.val()
      var root_content = i.data("content")
      var comment_id = $(this).parent().data("id")
      $.ajax({
        type: "PATCH",
        url: `/comments/${comment_id}`,
        data: {content: content},
        success: (data) => {
          i.siblings(".btn-danger").remove()
          if (data.status) {
            i.replaceWith(`<p class="content_comment">${content}</p>`)
          } else {
            i.replaceWith(`<p class="content_comment">${root_content}</p>`)
          }
          this.remove()
        }
      })
    })

    $("#container_comment").on("click", ".fa-trash",function () {
      var parents = $(this).parents(".name_author")
      $.ajax({
        type: "DELETE",
        url: `/comments/${parents.data("id")}`,
        success: (data) => {
          if  (data.status) {
            parents.parents(".comment-user").remove()
          } else {
            alert(I18n.t("comments.delete_fail"))
          }
        }
      })
    })
});
