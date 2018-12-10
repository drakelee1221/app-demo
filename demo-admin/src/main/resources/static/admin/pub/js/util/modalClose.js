(function ($) {
  if($){
    $(function () {
      $(document).on('hidden.bs.modal', '.modal', function (event) {
        if ($(".modal.in").length > 0 && !$("body").hasClass("modal-open")) {
          $("body").addClass("modal-open");
        }
      });
    });
  }else{
    console.error("jquery not found")
  }
})(window.jQuery);
