$(window).on('load', function() {

// $(document).on('pageinit',function() {
// $(document).on('pageinit',function() {

  $(".mySlides").hide()
  $(".mySlides").first().show()
  var audioController = $("audio")[0]
  audioController.volume = 0.35
  $(".thumbs").on("click", function(event){
    audioController.currentTime = ($(this).index()) * 30
    audioController.play();
  })
  var count = 1
  $("#play").on("click", function(event) {
    if(audioController.paused){
      audioController.play();
    } else {
      audioController.pause();
    }
    var playCount = count
    var imageIndex = 0
    window.setInterval(function() {
      var tar_coord_x = $(".mySlides").offset().left;
      var tar_coord_y = $(".mySlides").offset().top;

      // if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 1 && playCount === 1) {
      //   audioController.volume /= 0.7
      // }
      // if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 2 && playCount === 1) {
      //   audioController.volume /= 0.7
      // }
      // if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 3 && playCount === 1) {
      //   audioController.volume = 1
      // }
      // if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 28 && playCount === 1) {
      //   audioController.volume *= 0.7
      // }
      // if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 29 && playCount === 1) {
      //   audioController.volume *= 0.7
      // }
      if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 3 ) === 0 && playCount === 1) {
        if (audioController.volume > 0.4) {
          audioController.volume *= 0.7
        }
        imageIndex = Math.floor(audioController.currentTime/3)
        var this_coord_x = $(".thumbs").eq(imageIndex).offset().left;
        var this_coord_y = $(".thumbs").eq(imageIndex).offset().top;
        var move_coord_x = tar_coord_x - this_coord_x;
        var move_coord_y = tar_coord_y - this_coord_y;
        $(".thumbs").eq(imageIndex).css("transform", "translate(" + move_coord_x + "px, " + move_coord_y + "px) scale(10)");
        $(".mySlides").hide()
        $(".mySlides").eq(imageIndex).attr("style", "display:block")
        $(".thumbs").css("opacity", 1)
        $(".thumbs").eq(imageIndex).css( "opacity", 0.33 )
      }
    }, 1000)
    count += 1
  })

  window.setInterval(function(){
    var audioSource = $("audio").attr("src");
    var samplerID = /\d+(?=.mp3)/g.exec(audioSource);
    var url = "/samplers/check/" + samplerID
    var request = $.ajax({
      url: url
    });
    request.done(function(response) {
      $(".download-link").html("")
      $(".download-link").append(response)
    });
  }, 5000)

})
