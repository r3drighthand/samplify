$(document).ready(function() {
  $(".mySlides").hide()
  $(".mySlides").first().show()
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
        image_index = Math.floor(aud_control.currentTime/30)
        $(".mySlides").hide()
        $(".mySlides").eq(image_index).attr("style", "display:block")
        console.log(image_index)
      }
    }, 1000)
    count += 1

    // var slideIndex = 0;
    // showSlides();

    // function showSlides() {
    //   var i;
    //   var slides = document.getElementsByClassName("mySlides");
    //   for (i = 0; i < slides.length; i++) {
    //     slides[i].style.display = "none";
    //   }
    //   slideIndex++;
    //   if (slideIndex > slides.length) {slideIndex = 1}
    //   slides[slideIndex-1].style.display = "block";
    //   setTimeout(showSlides, 30000); // Change image every 2 seconds
    // }
  })





})
