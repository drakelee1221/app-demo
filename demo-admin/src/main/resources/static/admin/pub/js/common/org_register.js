//日期范围限制
var registDate = {
  elem: '#registDate',
  format: 'YYYY-MM-DD',
  //: laydate.now(), //设定最小日期为当前日期
  //max: '2099-06-16 23:59:59', //最大日期
  istime: true,
  istoday: false,
  choose: function (datas) {
    // birthday.min = datas; //开始日选好后，重置结束日的最小日期
    // birthday.start = datas //将结束日的初始值设定为开始日
  }
};
laydate(registDate);

var decryptJs;
var preCode;
var token;
var phone;
var timer;
//获取短信验证码
$("#getCode").click(function () {
  token = null;
  phone = $("#contactPhone").val();
  var _that = $(this);
  _that.attr("disabled", "disabled");
  getJs();
});

// 第一步 获取随机的解密js方法
function getJs() {
  $.ajax({
    url: ctx + "/admin/edge/captcha/key/js",
    type: "GET",
    dataType: "json",
    data: {},
    success: function (data) {
      if (data.success) {
        decryptJs = data.data.decryptJs;
        decryptJsHandle(decryptJs);
        getPreKey();
      } else {
        layer.alert(data.message, {icon: 2});
      }

    },
    error: function (e) {
      layer.alert(e.responseJSON.message, {icon: 2});
      $("#getCode").removeAttr("disabled");
      clearJs();
    }
  });
}

// 第二步 获取preKey
function getPreKey() {
  $.ajax({
    url: ctx + "/admin/edge/captcha/key",
    type: "GET",
    dataType: "json",
    data: {
      type: 7,
      length: 8,
      phone: phone,
      decryptJs: decryptJs
    },
    success: function (data) {
      if (data.success) {
        preCode = jsDecrypt(8, data.data.accessKey);
        sendSms();
      } else {
        layer.alert(data.message, {icon: 2});
      }
    },
    error: function (e) {
      layer.alert(e.responseJSON.message, {icon: 2});
      $("#getCode").removeAttr("disabled");
      clearJs();
    }
  });
}

// 第三步 发送短信
function sendSms() {
  $.ajax({
    url: ctx + "/admin/edge/sms/code",
    type: "GET",
    dataType: "json",
    data: {
      type: 7,
      phone: phone,
      preCode: preCode
    },
    success: function (data) {
      console.log(data);
      setTime(60);
      clearJs();
    },
    error: function (e) {
      layer.alert(e.responseJSON.message, {icon: 2});
      $("#getCode").removeAttr("disabled");
      clearJs();
    }
  });
}

//倒计时
function setTime(time) {
  var getCode = $("#getCode");
  if (token != null && token != undefined && token != '') {
    clearTimeout(timer);
    $("#getCode").html("验证成功,点击可重新获取");
    $("#getCode").removeAttr("disabled");
    $("#smsCode").removeAttr("readonly");
    return;
  }
  timer = setTimeout(function () {
    getCode.html(time + "秒后可重新获取");
    time--;
    if (time == 0) {
      $("#getCode").removeAttr("disabled");
      getCode.html("获取验证码");
    } else {
      setTime(time);
    }
  }, 1000);
}

//验证短信获取token
$("#smsCode").blur(function () {
  if ($("#smsCode").val() == "") {
    return;
  }
  if ($(this).disabled) {
    return;
  }
  $.ajax({
    url: ctx + "/admin/register/org/sms/verify",
    type: "GET",
    dataType: "json",
    data: {
      type: 1,
      phone: phone,
      verifyCode: $("#smsCode").val()
    },
    success: function (data) {
      if (data.success) {
        token = data.data;
        $("#getCode").html("验证成功,点击可重新获取");
        $("#getCode").removeAttr("disabled");
        $("#smsCode").removeAttr("readonly");
      } else {
        layer.alert(data.message, {icon: 2});
      }
    },
    error: function (e) {
      layer.alert("网络异常", {icon: 2});
    }
  });
})

// 清除js
function clearJs() {
  decryptJs = "";
  preCode = "";
}

//电话改变重新短信验证
$("#contactPhone").change(function () {
  clearTimeout(timer);
  token = null;
  clearJs();
  $("#getCode").html("获取验证码");
  $("#getCode").removeAttr("disabled");
  $("#smsCode").removeAttr("readonly");
  $("#smsCode").val("");
})


// 向页面增加加密方法
function decryptJsHandle(d) {
  // 第一步：匹配加载的页面中是否含有js
  var regDetectJs = /<script(.| )*?>(.| | )*?<\/script>/ig;
  var jsContained = decryptJs.match(regDetectJs);
  // 第二步：如果包含js，则一段一段的取出js再加载执行
  if (jsContained) {
    // 分段取出js正则
    var regGetJS = /<script(.| )*?>((.| | )*)?<\/script>/im;
    // 按顺序分段执行js
    var jsNums = jsContained.length;
    for (var i = 0; i < jsNums; i++) {
      var jsSection = jsContained[i].match(regGetJS);
      if (jsSection[2]) {
        if (window.execScript) {
          // 给IE的特殊待遇
          window.execScript(jsSection[2]);
        } else {
          // 给其他大部分浏览器用的
          window.eval(jsSection[2]);
        }
      }
    }
  }
}

//选择服务地区
$("#chooseServiceRegion").click(function () {
  $("#regionModal").modal("show");
});


// 选择地区确认
function confirmRegion() {
  var names = [];
  var nodes = saveRegionTree.tree.fancytree("getTree").getSelectedNodes();
  if (nodes.length == 0) {
    layer.alert("请选择服务地区", {icon: 1});
    return;
  }
  var selectIds = [];
  for (var i = 0; i < nodes.length; i++) {
    selectIds.push(nodes[i].refKey);
    names.push(nodes[i].title);
  }
  $("#serviceRegionName").val(names.join(","));
  $("#serviceRegion").val(selectIds.join(","));
  $("#regionModal").modal("hide");
}

// 清除选择地区
function clearSelect(treeId) {
  saveRegionTree.tree.fancytree("getTree").reload();
  if (treeId == 'save-region-tree') {
    $("#serviceRegionName").val("");
    $("#serviceRegion").val("");
    $("#regionModal").modal("hide");
  }

}


//身份证上传
$("#licenseAttachment,#idCardAttachment,#attachment").click(function () {
  $("#file").attr("dir", $(this).attr("id"));
  $("#file").click();
})

//上传文件事件
$("#file").change(function () {
  var loadIndex = layer.load();
  if ($(this).val() == null || $(this).val() == undefined || $(this).val() == "") {
    return;
  }
  var imgDivId = "#" + $(this).attr("dir") + "Div";
  var option = {
    url: ctx + "/admin/attachment/upload/no/token?isPrivate=true&contactPhone=" + phone,
    type: 'POST',
    dataType: "json",
    clearForm: false,
    restForm: false,
    success: function (res) {
      if (res.success) {
        layer.msg(res.message, {time: 1000});
        $(imgDivId).append(' <table class="inline">\n' +
          '               <tr>\n' +
          '                 <td>\n' +
          '                   <img src="' + res.data.url + '" rel="' + res.data.name + '" style="max-width: 150px;min-height: 50px;">\n' +
          '                 </td>\n' +
          '               </tr>\n' +
          '               <tr>\n' +
          '                 <td>\n' +
          '                   <button type="button" class="btn-danger btn-xs btn cancelImg">删除</button>\n' +
          '                 </td>\n' +
          '               </tr>\n' +
          '             </table>');
        //删除图片
        $(".cancelImg").click(function () {
          $(this).parent().parent().parent().remove();
        })
      }
      else {
        layer.alert(res.message, {icon: 2});
      }
      layer.close(loadIndex);
      document.attaForm.reset();
    },
    error: function () {
      layer.close(loadIndex);
      layer.alert("异常", {icon: 2});
      document.attaForm.reset();
    },
    headers: {
      token: token
    },
    beforeSend: function (request) {
      request.setRequestHeader("token", token);
    }
  };
  $("#attaForm").ajaxSubmit(option);
});

//提交注册
$("#submit").click(function () {
  if(!$("#user_protocol")[0].checked){
    layer.alert("请同意麦积财税平台合作协议", {icon: 2});
    return;
  }
  //判断短信验证码
  if (token == null || token == "") {
    layer.alert("请先验证短信", {icon: 2});
    return;
  }
  if (!$("#registerForm").valid()) {
    layer.alert("请检查必填项", {icon: 2});
    return;
  }
  var params = $("#registerForm").serializeJSON();

  var licenseAttachmentArr = [];
  var idCardAttachmentArr = [];
  var attachmentArr = [];
  //营业执照
  $("#licenseAttachmentDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    licenseAttachmentArr.push(img);
  })
  //法人身份证
  $("#idCardAttachmentDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    idCardAttachmentArr.push(img);
  })
  //附件
  $("#attachmentDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    attachmentArr.push(img);
  })

  if (licenseAttachmentArr.length > 0) {
    params.licenseAttachment = JSON.stringify(licenseAttachmentArr);
  } else {
    layer.alert("营业执照必传", {icon: 2});
    return;
  }
  if (idCardAttachmentArr.length > 0) {
    params.idCardAttachment = JSON.stringify(idCardAttachmentArr);
  } else {
    layer.alert("身份证附件必传", {icon: 2});
    return;
  }
  if (attachmentArr.length > 0) {
    params.attachment = JSON.stringify(attachmentArr);
  }
  // 所在地区全路径
  var regionPathId = $("#firstRegion").val() + "-" + $("#secondRegion").val() + "-" + $("#locationRegion").val();
  var regionPathName = $("#firstRegion").find("option:selected").html() + "-" + $("#secondRegion").find("option:selected").html() + "-" + $("#locationRegion").find("option:selected").html();
  params.regionPathId = regionPathId;
  params.regionPathName = regionPathName;
  // 空串替换
  for (i in params) {
    if (!params[i]) {
      delete params[i];
    }
  }
  var loadIndex = layer.load();
  $.postPayload(ctx + "/admin/register/org/extend", params, function (data) {
    if (data.success) {
      layer.alert("您的信息已经成功提交，平台会尽快处理，请耐心等待！", {icon: 1}, function () {
        location.reload();
      });
    } else {
      if (data.message == '短信验证码错误') {
        $("#getCode").html("获取验证码");
        $("#getCode").removeAttr("disabled");
        $("#smsCode").removeAttr("readonly");
        $("#smsCode").val("");
        layer.alert("短信验证码已过期，请重新获取", {icon: 2});
      } else {
        layer.alert(data.message, {icon: 2});
      }
    }
    layer.close(loadIndex);
  }, function (e) {
    layer.alert(e.responseJSON.message, {icon: 2});
    layer.close(loadIndex);
  }, "json")

})

//初始化地区列表
$.ajax({
  url: ctx + "/admin/register/region/list",
  type: "GET",
  dataType: "json",
  data: {},
  success: function (data) {
    $("#firstRegion").empty();
    $("#secondRegion").empty();
    $("#locationRegion").empty();
    $("#firstRegion").append('<option value="" selected>请选择</option>');
    $("#secondRegion").append('<option value="" selected>请选择</option>');
    $("#locationRegion").append('<option value="" selected>请选择</option>');
    $.each(data, function (index, item) {
      $("#firstRegion").append(
        '<option value="' + item.id + '">' + item.name + '</option>'
      )
    });
  },
  error: function (e) {
    layer.alert("网络异常", {icon: 2});
  }
});

//地区二级联动
$("#firstRegion").change(function () {
  var id = $(this).val();
  $.ajax({
    url: ctx + "/admin/register/region/list",
    type: "GET",
    dataType: "json",
    data: {id: id},
    success: function (data) {
      $("#secondRegion").empty();
      $("#locationRegion").empty();
      $("#secondRegion").append('<option value="" selected>请选择</option>');
      $("#locationRegion").append('<option value="" selected>请选择</option>');
      $.each(data, function (index, item) {
        $("#secondRegion").append(
          '<option value="' + item.id + '">' + item.name + '</option>'
        )
      });
    },
    error: function (e) {
      layer.alert("网络异常", {icon: 2});
    }
  })
})

//地区三级联动
$("#secondRegion").change(function () {
  var id = $(this).val();
  $.ajax({
    url: ctx + "/admin/register/region/list",
    type: "GET",
    dataType: "json",
    data: {id: id},
    success: function (data) {
      $("#locationRegion").empty();
      $("#locationRegion").append('<option value="" selected>请选择</option>');
      $.each(data, function (index, item) {
        $("#locationRegion").append(
          '<option value="' + item.id + '">' + item.name + '</option>'
        )
      });
    },
    error: function (e) {
      layer.alert("网络异常", {icon: 2});
    }
  })
})

//选择产品
$("#chooseProducts").click(function () {
  $("#productModal").modal("show");
})

//选择产品
function confirmProduct() {
  var names = [];
  var selectIds = [];
  var select = $("#product_list").bootstrapTable("getSelections");
  if (select.length == 0) {
    layer.alert("请勾选擅长产品", {icon: 1});
    return;
  }
  for (var i = 0; i < select.length; i++) {
    names.push(select[i].name);
    selectIds.push(select[i].id);
  }
  $("#productsName").val(names.join(","));
  $("#products").val(selectIds.join(","));
  $("#productModal").modal("hide");
}

// 清除产品
function clearProductSelect() {
  $("#product_list").bootstrapTable('refresh');
  $("#productsName").val("");
  $("#products").val("");
  $("#productModal").modal("hide");
}


//产品
$("#product_list").bootstrapTable({
  method: "GET",
  url: ctx + "/admin/product/info/page",
  queryParams: function (params) {
    return {
      pageSize: params.pageSize,
      pageNum: params.pageNum
    };
  },
  pageSize: 10000,
  checkboxHeader: true,
  clickToSelect: true,
  singleSelect: false,
  idField: "id",
  //数据列
  columns: [{
    checkbox: true
  }, {
    title: "类别",
    field: "typeName"
  }, {
    title: "名称",
    field: "name"
  }, {
    title: "描述",
    field: "descri"
  }, {
    title: "图标",
    field: "icon"
  }, {
    title: "详情介绍链接",
    field: "url"
  }, {
    title: "启用时间",
    field: "beginTime"
  }, {
    title: "过期时间",
    field: "expireTime"
  }, {
    title: "计算周期",
    field: "cycle",
    formatter: function (value, row, index) {
      return value === 0 ? '否' : '是'
    }
  }, {
    title: "状态",
    field: "status",
    formatter: function (value, row, index) {
      return value === 0 ? '禁用' : '启用'
    }
  }]
});



