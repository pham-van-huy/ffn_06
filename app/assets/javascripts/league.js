$(document).on('click', '#close-preview', function(){
  $('.image-preview').popover('hide');
  // Hover befor close the preview
  $('.image-preview').hover(
    function () {
      $('.image-preview').popover('show');
    },
     function () {
      $('.image-preview').popover('hide');
    }
  );
});

$(function() {
  // Create the close button
  var closebtn = $('<button/>', {
    type:"button",
    text: 'x',
    id: 'close-preview',
    style: 'font-size: initial;',
  });
  closebtn.attr("class","close pull-right");
  // Set the popover default content
  $('.image-preview').popover({
    trigger:'manual',
    html:true,
    title: "<strong>Preview</strong>"+$(closebtn)[0].outerHTML,
    content: "There's no image",
    placement:'bottom'
  });
  // Clear event
  $('.image-preview-clear').click(function(){
    $('.image-preview').attr("data-content","").popover('hide');
    $('.image-preview-filename').val("");
    $('.image-preview-clear').hide();
    $('.image-preview-input input:file').val("");
    $(".image-preview-input-title").text(I18n.t("admin.leagues.new.browse"));
    $("#old-avatar").css("display", "")
    $("#new_img").attr("src", "")
  });
  // Create the preview image
  $(".image-preview-input input:file").change(function (){
    var img = $('<img/>', {
      id: 'dynamic',
      width:250,
      height:200
    });
    var show_img = $("#new_img")
    var file = this.files[0];
    var reader = new FileReader();
    // Set preview image into the popover data-content
    reader.onload = function (e) {
      $(".image-preview-input-title").text(I18n.t("admin.leagues.new.change"));
      $(".image-preview-clear").show();
      $(".image-preview-filename").val(file.name);
      img.attr('src', e.target.result);
      show_img.attr('src', e.target.result);
      $("#old-avatar").css("display", "none")
      $(".image-preview").attr("data-content",$(img)[0].outerHTML).popover("show");
    }
    reader.readAsDataURL(file);
  });
});

$(document).ready(function() {
  $("#league_continent_id").on("change", function() {
    var current = $(this)
    $.ajax({
      type: "GET",
      url: "/admin/ajax_get_countries",
      data: {continent_id: current.val()},
      success: function(response) {
        var option = "<option value=''>" + I18n.t("admin.leagues.new.choise_country") + "</option>"
        $.each(response, function(index, value) {
          option += "<option value='" + value.id + "'>" + value.name + "</option>"
        })
        console.log(option)
        $("#league_country_id").append(option).removeAttr("disabled")
      }
    })
  })

  $("#league_remove_logo").on("change", function() {
    if ($(this).is(":checked")) {
      $(".image-preview").css("display", "")
    } else {
      $(".image-preview").css("display", "none")
    }
  })
})
