$(document).ready(function() {
  var count = 1
  $("video").on("play", function(event) {
    var play_count = count
    var vid_control = event.target
    window.setInterval(function() {
      if ($("video").get(0).paused === false && (Math.floor(vid_control.currentTime) % 10) % 3 === 0 && play_count === 1) {
        vid_control.volume = 0.7
        console.log(vid_control.volume)
      }
      if ($("video").get(0).paused === false && (Math.floor(vid_control.currentTime) % 10) % 4 === 0 && play_count === 1) {
        vid_control.volume = 0.5
        console.log(vid_control.volume)
      }
      if ($("video").get(0).paused === false && (Math.floor(vid_control.currentTime) % 10) % 5 === 0 && play_count === 1) {
        vid_control.volume = 0.7
        console.log(vid_control.volume)
      }
      if ($("video").get(0).paused === false && (Math.floor(vid_control.currentTime) % 10) % 6 === 0 && play_count === 1) {
        vid_control.volume = 1
        console.log(vid_control.volume)
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
