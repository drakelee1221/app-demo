

;(function ($, window) {

  if (!$.selector) {
    $.selector = {};
  }

  $.selector.icons = function (define) {

    var myModal = $('#mj-selectorIconsModal');
    if (myModal.length === 0) {
      $.ajax({
        url: ctx + "/admin/pub/plugin/icons/icons.html",
        async: false,
        type: "GET",
        dataType: "html",
        success: function (data, textStatus, jqXHR) {
          $("body").append(data);
        }
      });
      myModal = $('#mj-selectorIconsModal');
      $("#mj-selectorIconsModal .fa-hover").on("click", function () {
        if ($.isFunction(define)) {
          define($(this).find("i").attr("class"));
        }
        myModal.modal("hide");
      });
    }
    myModal.modal();
  };
})(jQuery, window);