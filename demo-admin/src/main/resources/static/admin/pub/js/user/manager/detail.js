

$(function () {
  var userId = $("#userId").val();
  $("#userDetail a").click(function () {
    var targetId = $(this).attr("href");
    var url = "";
    var data = {};
    if (targetId == '#userDetail-tab-1') {
      url = ctx + "/admin/user/manager/detail/base";
      data = {
        userId: userId
      };
    }
    if (targetId == '#userDetail-tab-2') {
      url = ctx + "/admin/user/manager/detail/order";
      data = {
        userId: userId
      };
    }
    if (targetId == '#userDetail-tab-3') {
      url = ctx + "/admin/user/manager/detail/service";
    }
    if (targetId == '#tuserDetail-tab-4') {
      return false;
    }
    if (targetId == '#userDetail-tab-5') {
      url = ctx + "/admin/user/manager/detail/supply";
      data = {
        userId: userId,
        type: 1
      };
    }
    if (targetId == '#userDetail-tab-6') {
      url = ctx + "/admin/user/manager/detail/demand";
      data = {
        userId: userId,
        type: 0
      };
    }
    if (url) {
      initTab(url, data, targetId);
    }
  });

  //首次打开的是第一个选项卡
  initTab(ctx + "/admin/user/manager/detail/base", {userId: userId}, "#userDetail-tab-1");

  function initTab(url, data, targetId) {
    $(targetId + " .panel-body").empty();
    $(targetId + " >div").html("");
    $.ajax({
      url: url,
      type: 'GET',
      data: data,
      cache: false,
      dataType: 'html',
      success: function (html) {
        $(targetId + " .panel-body").html(html);
      }
    });
  }

});