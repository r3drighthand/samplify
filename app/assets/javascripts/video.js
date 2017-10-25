$(document).on('turbolinks:load', function() {
  if (window.location.href.search(/(samplers\/\d+)/) > 0) {
    $(".mySlides").hide()
    $(".mySlides").first().show()
    var audioController = $("audio")[0]
    audioController.volume = 0.35
    var imageIndex = 0
    $(".thumbs").on("click", function(event){
      audioController.volume = 0.35
      audioController.currentTime = ($(this).index()) * 30
      if (audioController.paused){
        $("#play").trigger( "click" );
      }
      imageIndex = Math.floor(audioController.currentTime/30)
      $(".thumbs").css("opacity", 1)
      $(".thumbs").eq(imageIndex).css( "opacity", 0.33 )
      $(".mySlides").hide()
      $(".mySlides").eq(imageIndex).attr("style", "display:block")
    })
    var count = 1
    $("#play").on("click", function(event) {
      if (audioController.paused){
        audioController.play();
      } else {
        audioController.pause();
      }
      var playCount = count
      setInterval(function() {
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 1 && playCount === 1) {
          audioController.volume /= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 2 && playCount === 1) {
          audioController.volume /= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 3 && playCount === 1) {
          audioController.volume = 1
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 28 && playCount === 1) {
          audioController.volume *= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 29 && playCount === 1) {
          audioController.volume *= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 0 && playCount === 1) {
          if (audioController.volume > 0.4) {
            audioController.volume *= 0.7
          }
          imageIndex = Math.floor(audioController.currentTime/30)
          $(".mySlides").hide()
          $(".mySlides").eq(imageIndex).attr("style", "display:block")
          $(".thumbs").css("opacity", 1)
          $(".thumbs").eq(imageIndex).css( "opacity", 0.33 )
        }
      }, 1000)
      count += 1
    })
    var downloadChecker = setInterval(function(){
      var audioSource = $("audio").attr("src");
      var samplerID = /\d+(?=.mp3)/g.exec(audioSource);
      var url = "/samplers/check/" + samplerID
      var request = $.ajax({
        url: url
      });
      request.done(function(response) {
        $(".download-link").html("")
        $(".download-link").append(response)
        clearInterval(downloadChecker);
      });
    }, 5000)
  }
})
