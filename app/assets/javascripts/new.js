$(document).on('turbolinks:load', function() {
    // console.log(window.location.href)
    $(".edit_track").hide();
  if ($(".new-sampler-container").length > 0) {
    console.log($(".edit_track").first().find("input")[3])
    $(".paperclip-preview").on("click", function() {
      // console.log($(this).siblings().find("input")[4])

      var selectFile = $(this).siblings().find("input")[3]
      var updateFile = $(this).siblings().find("input")[4]

      $(selectFile).trigger( "click" );
      // console.log("stage 1 complete")
      $(selectFile).change(function(){
        // console.log("stage 2")
        $(updateFile).trigger( "click" );
      })

      // sleep(5)


    })
  }
})
