
(function ($) {
  $(function(){
    $(".g-btn").on("mousemove", function (e) {
      $(this).find(".g-btn_background").css({'left':(e.pageX - this.offsetLeft) + 'px', 'top': (e.pageY - this.offsetTop)+'px'});
    });
  });
})(jQuery);
