$(document).ready(function() {
  var count = 1
  $("audio").on("play", function(event) {
    var play_count = count
    var aud_control = event.target
    var image_index = 0
    window.setInterval(function() {
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 1 && play_count === 1) {
        aud_control.volume = 0.35
        console.log(aud_control.volume)
        console.log("sec 1")
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 2 && play_count === 1) {
        aud_control.volume = 0.7
        console.log(aud_control.volume)
        console.log("sec 2")
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 3 && play_count === 1) {
        aud_control.volume = 1.0
        console.log(aud_control.volume)
        console.log("sec 3")
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 28 && play_count === 1) {
        aud_control.volume = 0.7
        console.log(aud_control.volume)
        console.log("sec 28")
      }
      if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 29 && play_count === 1) {
        aud_control.volume = 0.35
        console.log(aud_control.volume)
        console.log("sec 29")
      }
    if ($("audio").get(0).paused === false && (Math.floor(aud_control.currentTime) % 30 ) === 0 && play_count === 1) {
        $("ul li").removeClass("nowPlaying")
        $("ul li").eq(image_index).addClass("nowPlaying")
        image_index += 1
        console.log("sec 0")
      }
    }, 1000)
    count += 1
    // console.log($(this))
    // console.log($("video"))
    // console.log(event.target)
    // if (Math.floor(vid_control.currentTime) === 10) {
    //   console.log("hey")
    // }
    // console.log("Video paused. Current time of videoplay: " + $("video").currentTime);
    // console.log("Video paused. Current time of videoplay: " + event.target.currentTime);
  })





})
