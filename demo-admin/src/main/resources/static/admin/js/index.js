var index = {
  closeWindow: function (e, id) {
    var li = $(e).parents("li");
    li.prev().find("a").trigger("click");
    $("#" + id).remove();
    li.remove();
  },
  refreshWindow: function (id, newHref) {
    var e = document.getElementById(id);
    if (newHref) {
      e.src = newHref;
    } else {
      newHref = e.src;
    }
    e.src = newHref;
  },
  navOver: function (e) {
    $(e).find(".main-if-close,.main-if-refresh").show();
  },
  navLeave: function (e) {
    $(e).find(".main-if-close,.main-if-refresh").hide();
  },
  closeNav: function (href, notShowPrev) {
    $("#content-nav li").each(function () {
      var li = $(this);
      var h = li.data("href");
      if (h) {
        if (href.split("?")[0] === h.split("?")[0]) {
          if (notShowPrev) {
            $(li.find("a").attr("href")).remove();
            li.remove();
          } else {
            li.find(".main-if-close").trigger("click");
          }
          return false;
        }
      }
    });
  },
  showNav: function (href, refresh) {
    var opened = false;
    var uri = href.split("?")[0];
    var hasPower = false;
    $("#content-nav li").each(function () {
      var li = $(this);
      var h = li.data("href");
      if (h) {
        if (uri === h.split("?")[0]) {
          var a = li.find("a");
          if (refresh) {
            index.refreshWindow(a.attr("aria-controls"), href)
          }
          a.trigger("click");
          opened = true;
          hasPower = true;
          return false;
        }
      }
    });
    if (!opened) {
      $(".J_menuItem").each(function () {
        var $this = $(this);
        if (uri === $this.attr("href")) {
          var id = $this.attr("id");
          var ic = $this.find("i").attr("class");
          index.openNav(ic, href, id, $this.text(), refresh);
          hasPower = true;
          return false;
        }
      });
    }
    if (!hasPower) {
      alert("请申请访问权限!");
    }
  },
  showNavAnother: function (href, refresh) {
    index.closeNav(href, true);
    var uri = href.split("?")[0];
    var hasPower = false;
    $(".J_menuItem").each(function () {
      var $this = $(this);
      if (uri === $this.attr("href")) {
        var id = $this.attr("id");
        var ic = $this.find("i").attr("class");
        index.openNav(ic, href, id, $this.text(), refresh);
        hasPower = true;
        return false;
      }
    });
    if (!hasPower) {
      alert("请申请访问权限!");
    }
  },
  openNav: function (icon, href, id, text, refresh) {
    var exists = $("#tab_" + id);
    if (exists.length > 0) {
      if (refresh) {
        index.refreshWindow("tab_" + id, href);
      }
      $("#content-nav a[href='#tab_" + id + "']").tab("show");
    } else {
      var nav = $("#content-nav");
      nav.find(".active").removeClass("active");
      nav.append("<li role='presentation' class='tab-nav active' data-toggle='context' data-target='#context-menu' onmouseleave='index.navLeave(this)' onmouseover='index.navOver(this)' data-href='" + href + "'>" +
        "<a href='#tab_" + id + "' aria-controls='tab_" + id + "' role='tab' data-toggle='tab'>" +
        "<i class='" + icon + "'></i>" + text.trim() + "</a>" +
        "<button type='button' class='close main-if-close' onclick='index.closeWindow(this, \"tab_" + id + "\")'><span>&times;</span></button>" +
        "<button type='button' class='close main-if-refresh' onclick='index.refreshWindow(\"tab_" + id + "\")'><i class='fa fa-refresh'></i></button>" +
        "</li>");
      var content = $("#content-main");
      content.find(".active").removeClass("active");
      content.append("<iframe role='tabpanel' class='tab-pane active' id='tab_" + id + "' width='100%' height='100%' " +
        "src='" + href + "' frameborder='0' seamless></iframe>");
    }
    index.initContextMenu('tab_' + id);
    index.monitorEnter('tab_' + id);
  },
  initContextMenu: function (id) {
    var iframe = document.getElementById(id);
    iframe.onload = function () {
      try {
        iframe.contentDocument.onclick = function () {
          $(".tab-nav").contextmenu('closemenu');
        };
      } catch (e) {
      }
    }
  },
  // 输入框输完信息点击回车查询监听
  monitorEnter: function (id) {
    var iframe = document.getElementById(id);
    iframe.onload = function () {
      var searchForm = $("#" + id).contents().find("form").first();
      searchForm.submit(function () {
        return false;
      });
      var searchBtn = null;
      searchForm.find("button").each(function () {
        if ($(this).html().indexOf("查询") > -1) {
          searchBtn = $(this);
          return false;
        }
      });
      if (searchBtn == null) {
        return false;
      }
      try {
        var objEvtKd = $._data(searchForm.find("input.form-control")[0], 'events');
        if (!objEvtKd || !objEvtKd['keydown']) {
          searchForm.find("input.form-control").keydown(function (e) {
            if (e.keyCode === 13) {
              searchBtn.click();
            }
          });
        }
      } catch (e) {
        console.log("no search input");
      }
      try {
        var objEvtCg = $._data(searchForm.find("select")[0], 'events');
        if (!objEvtCg || !objEvtCg['change']) {
          searchForm.find("select").change(function () {
            searchBtn.click();
          })
        }
      } catch (e) {
        console.log("no search select");
      }
    }
  },
  currentUserAuth: null,
  //获取当前用户权限信息
  getCurrentUserAuth: function () {
    if (!index.currentUserAuth) {
      $.ajax({
        url: "/admin/user/auth/info",
        method: "GET",
        async: false,
        success: function (res) {
          index.currentUserAuth = res.data;
        },
        type: "json"
      });
    }
    return index.currentUserAuth;
  }
};
$(function () {
  $(".J_menuItem").on('click', function () {
    if (window.event.ctrlKey) {
      return true;
    }
    var $this = $(this);
    var id = $this.attr("id");
    var ic = $this.find("i").attr("class");
    var href = $this.attr("href");
    index.openNav(ic, href, id, $this.text(), false);
    return false;
  });
  $("#side-menu .dropdown-menu").mouseleave(function () {
    $("#side-menu .dropdown").removeClass("open");
  });
  // 右键点击菜单详细事件
  $(".tab-nav").contextmenu();
  $(".dropdown-menu-other").click(function () {
    var id = $("#context-menu").attr("data-id");
    $(".tab-nav").each(function () {
      var a = $(this).find("a");
      if (a.attr("aria-controls") != id) {
        index.closeWindow(a, a.attr("aria-controls"));
      }
    });
  });
  $(".dropdown-menu-all").click(function () {
    $(".tab-nav").each(function () {
      var a = $(this).find("a");
      index.closeWindow(a, a.attr("aria-controls"));
    });
    $("#content-nav a").trigger("click");
  });

});