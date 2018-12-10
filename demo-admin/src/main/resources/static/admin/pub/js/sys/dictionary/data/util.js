/*
 * 字典工具
 * Copyright (c) 2018.mj.he800.com Inc. All rights reserved.
 */
;(function () {
  "use strict"
  var _global;
  var dictUtil = {
    // 返回多个值
    list: function (dictCode) {
      return dictUtil.get(ctx + "/admin/sys/dictionary/data/list", dictCode,false);
    },
    // 返回单个值
    single: function (dictCode) {
      return dictUtil.get(ctx + "/admin/sys/dictionary/data/single", dictCode,false);
    },
    // 异步返回多个值
    listAsync: function (dictCode) {
      return dictUtil.get(ctx + "/admin/sys/dictionary/data/list", dictCode,true);
    },
    // 异步返回单个值
    singleAsync: function (dictCode) {
      return dictUtil.get(ctx + "/admin/sys/dictionary/data/single", dictCode,true);
    },
    // 请求后台
    get: function (url, dictCode,isAsync) {
      var res;
      $.ajax({
        type: 'GET',
        url: url,
        data: {dictCode: dictCode},
        dataType: 'json',
        async: isAsync,
        success: function (result) {
          res = result;
        },
      });
      return res;
    },
    // 加载标签
    initElement: function () {
      $(".dictDiv").each(function () {
        var dictCode = $(this).attr("dictCode");
        var inputType = $(this).attr("inputType");
        var inputRequired = $(this).attr("inputRequired");
        var inputName = $(this).attr("inputName");
        var firstOption = $(this).attr("firstOption");
        var firstOptionValue = $(this).attr("firstOptionValue");
        if (!inputRequired || inputRequired == '') {
          inputRequired = false;
        }
        var data = dictUtil.list(dictCode);
        var html = "";
        // 下拉框
        if (inputType == 'select') {
          html = html + '<select id="' + inputName + '" name="' + inputName + '" class="form-control" required="' + inputRequired + '">';
          if (firstOption && firstOption != '') {
            html = html + '<option value="' + firstOptionValue + '">' + firstOption + '</option>';
          }
          data.forEach(function (item, index) {
            html = html + '<option value="' + item.dataValue + '">' + item.dataName + '</option>';
          });
          html = html + '</select>';
        }
        $(this).append(html);
      })
    }

  };

  if (!$) {
    throw "jquery is not found!";
  }
  // 最后将插件对象暴露给全局对象
  _global = (function () {
    return this || (0, eval)('this');
  }());
  if (typeof module !== "undefined" && module.exports) {
    module.exports = dictUtil;
  } else if (typeof define === "function" && define.amd) {
    define(function () {
      return dictUtil;
    });
  } else {
    !('dictUtil' in _global) && (_global.dictUtil = dictUtil);
  }
}());




