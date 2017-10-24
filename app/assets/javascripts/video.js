$(document).ready(function() {
  $(".mySlides").hide()
  $(".mySlides").first().show()
  var count = 1
  $("audio").on("play", function(event) {
    var play_count = count
    var aud_control = event.target
    var image_index = 0
    aud_control.volume = 0.35
    console.log("start: " + aud_control.volume)
    window.setInterval(function() {
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 1 && play_count === 1) {
        aud_control.volume /= 0.7
        console.log("sec 1: " + aud_control.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 2 && play_count === 1) {
        aud_control.volume /= 0.7
        console.log("sec 2: " + aud_control.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 3 && play_count === 1) {
        aud_control.volume = 1
        console.log("sec 3: " + aud_control.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 28 && play_count === 1) {
        aud_control.volume *= 0.7
        console.log("sec 28: " + aud_control.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 29 && play_count === 1) {
        aud_control.volume *= 0.7
        console.log("sec 29: " + aud_control.volume)
      }
    if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 0 && play_count === 1) {
        if (aud_control.volume > 0.4) {
          aud_control.volume *= 0.7
        }
        console.log("sec 0: " + aud_control.volume)
        image_index = Math.floor(aud_control.currentTime/30)
        $(".mySlides").hide()
        $(".mySlides").eq(image_index).attr("style", "display:block")
        console.log(image_index)
      }
    }, 1000)
    count += 1

  })

// myaudio.currentTime = 0; - This will rewind the audio to the beginning.

// If you want a function to be called once the audio has finished playing then you can use 'myaudio.addEventListener('ended',myfunc)' - This will call 'myfunc()' once the audio has finished.
})
