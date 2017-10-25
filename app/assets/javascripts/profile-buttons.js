$(document).ready(function() {
  $(".playlist-button").on("click", function(event) {
    if ($(".page-content-right").is(":visible")) {
      $(".page-content-left").toggle();
      $(".page-content-right").toggle();
    };
  });
  $(".sampler-button").on("click", function(event) {
    if ($(".page-content-left").is(":visible")) {
      $(".page-content-left").toggle();
      $(".page-content-right").toggle();
    };
  });
});
