$(document).on('turbolinks:load', function() {
  $(".playlist-button").on("click", function(event) {
    if ($(".page-content-right").is(":visible")) {
      $(".playlist-button").toggleClass("pressed");
      $(".sampler-button").toggleClass("pressed");
      $(".page-content-left").toggle();
      $(".page-content-right").toggle();
    };
  });
  $(".sampler-button").on("click", function(event) {
    if ($(".page-content-left").is(":visible")) {
      $(".playlist-button").toggleClass("pressed");
      $(".sampler-button").toggleClass("pressed");
      $(".page-content-left").toggle();
      $(".page-content-right").toggle();
    };
  });
});
