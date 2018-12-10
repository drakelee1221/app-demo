//日期范围限制
var birthday = {
  elem: '#birthday',
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
laydate(birthday);


var decryptJs;
var preCode;
var token;
var phone;
var timer;
//获取短信验证码
$("#getCode").click(function () {
  token = null;
  phone = $("#loginPhone").val();
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
      type: 1,
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
      type: 1,
      phone: phone,
      preCode: preCode
    },
    success: function (data) {
      console.log(data);
      setTime(60);
      clearJs();
    },
    error: function (e, h) {
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
      type: 0,
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
$("#loginPhone").change(function () {
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
  if (!orgTree.selected) {
    layer.alert("请选择机构", {icon: 1});
    return;
  } else {
    if (orgTree.selected.data.leftVal + 1 != orgTree.selected.data.rightVal) {
      layer.alert("请选择下级机构", {icon: 1});
      return;
    }
  }
  $("#code").val(orgTree.selected.refKey);
  $("#orgName").val(orgTree.selected.data.memberName);
  $("#regionModal").modal("hide");
}

// 清除选择地区
function clearSelect(treeId) {
  orgTree.tree.fancytree("getTree").reload();
  if (treeId == 'save-region-tree') {
    $("#serviceRegionName").val("");
    $("#serviceRegion").val("");
    $("#regionModal").modal("hide");
  }
}


//身份证上传
$("#idCardAttachment,#educationAttachment,#qualificationAttachment").click(function () {
  $("#file").attr("dir", $(this).attr("id"));
  $("#file").click();
})


// 头像上传点击
var dataURL;
$("#avatar").click(function () {
  $("#photoClipModal").modal("show");
});

// 确认上传
function confirmAvatar() {
  if (dataURL == null || dataURL == undefined || dataURL == "") {
    layer.alert("请先选择图片并点击裁剪按钮！");
    return;
  }
  var form = document.avatarForm;
  var formData = new FormData(form);
  var fileName = new Date().getTime() + "";
  formData.append("file", dataURLtoFile(dataURL, fileName));
  var loadIndex = layer.load();
  $.ajax({
    url: ctx + "/admin/attachment/upload/no/token?isPrivate=false&contactPhone=" + phone,
    type: "POST",
    data: formData,
    dataType: "json",
    processData: false,         // 告诉jQuery不要去处理发送的数据
    contentType: false,        // 告诉jQuery不要去设置Content-Type请求头
    success: function (res) {
      $("#avatarDiv").empty();
      imgDiv("#avatarDiv",res.data)
      document.avatarForm.reset();
      layer.close(loadIndex);
      dataURL = "";
      pc.clear();
      $("#photoClipModal").modal("hide");
    }
  })
}

// 图片裁剪
var pc = new PhotoClip('#clipArea', {
  size: 150,
  outputSize: 640,
  //adaptive: ['60%', '80%'],
  file: '#avatarFile',
  view: '#avatarView',
  ok: '#clipBtn',
  //img: 'img/mm.jpg',
  loadStart: function () {
    console.log('开始读取照片');
  },
  loadComplete: function () {
    console.log('照片读取完成');
  },
  done: function (res) {
    dataURL = res;
  },
  fail: function (msg) {
    layer.alert(msg);
  }
});

//将base64转换为文件
function dataURLtoFile(dataurl, filename) {
  var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }
  return new File([u8arr], filename, {type: mime});
}

//上传文件事件
$("#file").change(function () {
  var loadIndex = layer.load();
  if ($(this).val() == null || $(this).val() == undefined || $(this).val() == "") {
    return;
  }
  var imgDivId = "#" + $(this).attr("dir") + "Div";
  var option = {
    url: ctx + "/admin/attachment/upload/no/token?isPrivate=false&contactPhone=" + phone,
    type: 'POST',
    dataType: "json",
    clearForm: false,
    restForm: false,
    success: function (res) {
      if (res.success) {
        layer.msg(res.message, {time: 1000});
        imgDiv(imgDivId,res.data);
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

function imgDiv(imgDivId,data){
  $(imgDivId).append(' <table class="inline">\n' +
    '               <tr>\n' +
    '                 <td>\n' +
    '                   <img src="' + data.url + '" rel="' + data.name + '" style="max-width: 150px;min-height: 50px;">\n' +
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
//提交注册
$("#submit").click(function () {
  if (!$("#user_protocol")[0].checked) {
    layer.alert("请同意麦积财税平台合作协议", {icon: 2});
    return;
  }
  //判断短信验证码
  // if (token == null || token == "") {
  //   layer.alert("请先验证短信", {icon: 2});
  //   return;
  // }
  if (!$("#registerForm").valid()) {
    layer.alert("请检查必填项", {icon: 2});
    return;
  }
  if ($("#loginPwd").val() != $("#confirmPwd").val()) {
    layer.alert("确认密码不一致", {icon: 2});
    return;
  }
  //邮箱验证
  if (!checkEmail($("#email").val())) {
    layer.alert("邮箱不合法", {icon: 2});
    return;
  }
  //服务地区
  if ($("input[name='serviceRegionBox']:checkbox:checked").length < 1) {
    layer.alert("请选择服务地区", {icon: 2});
    return;
  }
  var params = $("#registerForm").serializeJSON();

  var idCardAttachmentArr = [];
  var educationAttachmentArr = [];
  var qualificationAttachmentArr = [];
  var avatarArr = [];
  //身份证附件
  $("#idCardAttachmentDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    idCardAttachmentArr.push(img);
  })
  //学历证书
  $("#educationAttachmentDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    educationAttachmentArr.push(img);
  })
  //资格证书
  $("#qualificationAttachmentDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    qualificationAttachmentArr.push(img);
  })
  //头像
  $("#avatarDiv").find("img").each(function (i) {
    var img = new Object();
    img.name = $(this).attr("rel");
    img.url = $(this).attr("src");
    avatarArr.push(img);
  })

  var regionService = "";
  var regionServiceName = "";
  $("input[name='serviceRegionBox']:checkbox:checked").each(function () {
    regionService += $(this).val() + ',';
    regionServiceName += $(this).attr("custname") + ',';
  })
  regionService = regionService.substr(0, regionService.length - 1);
  regionServiceName = regionServiceName.substr(0, regionServiceName.length - 1);
  params.serviceRegion = regionService;
  params.serviceRegionName = regionServiceName;
  if (idCardAttachmentArr.length > 0) {
    params.idCardAttachment = JSON.stringify(idCardAttachmentArr);
  } else {
    layer.alert("身份证附件必传", {icon: 2});
    return;
  }
  if (educationAttachmentArr.length > 0) {
    params.educationAttachment = JSON.stringify(educationAttachmentArr);
  }
  if (qualificationAttachmentArr.length > 0) {
    params.qualificationAttachment = JSON.stringify(qualificationAttachmentArr);
  }
  if (avatarArr.length > 0) {
    params.avatar = JSON.stringify(avatarArr);
  }
  // 所在地区全路径
  var regionPathId = $("#firstRegion").val() + "-" + $("#secondRegion").val() + "-" + $("#region").val();
  var regionPathName = $("#firstRegion").find("option:selected").html() + "-" + $("#secondRegion").find("option:selected").html() + "-" + $("#region").find("option:selected").html();
  params.regionPathId = regionPathId;
  params.regionPathName = regionPathName;
  // 空串替换
  for (i in params) {
    if (!params[i]) {
      delete params[i];
    }
  }
  var loadIndex = layer.load();
  $.postPayload(ctx + "/admin/register/user/extend", params, function (data) {
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

// 邮箱验证
function checkEmail(email) {
  if (email == null || email == undefined || email == '') {
    return true;
  }
  var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$");
  if (!reg.test(email)) {
    return false;
  } else {
    return true;
  }
}

//初始化地区列表
$.ajax({
  url: ctx + "/admin/register/region/list",
  type: "GET",
  dataType: "json",
  data: {},
  success: function (data) {
    $("#firstRegion").empty();
    $("#secondRegion").empty();
    $("#region").empty();
    $("#firstRegion").append('<option value="" selected>请选择</option>');
    $("#secondRegion").append('<option value="" selected>请选择</option>');
    $("#region").append('<option value="" selected>请选择</option>');
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
      $("#region").empty();
      $("#secondRegion").append('<option value="" selected>请选择</option>');
      $("#region").append('<option value="" selected>请选择</option>');
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
      $("#region").empty();
      $("#region").append('<option value="" selected>请选择</option>');
      $.each(data, function (index, item) {
        $("#region").append(
          '<option value="' + item.id + '">' + item.name + '</option>'
        )
      });
    },
    error: function (e) {
      layer.alert("网络异常", {icon: 2});
    }
  })
})

//受邀码查公司名字
$("#code").blur(function () {
  var code = $(this).val();
  if (code.length > 0) {
    $.ajax({
      url: ctx + "/admin/register/org/" + code,
      type: "GET",
      dataType: "json",
      success: function (data) {
        if (data.success) {
          $("#companyName").html(data.data);
          if (data.data == '') {
            layer.alert('未查到该受邀码对应的企业', {icon: 2});
          }
        } else {
          layer.alert(data.message, {icon: 2});
        }
      },
      error: function (e) {
        layer.alert("网络异常", {icon: 2});
      }
    });
  }
})

//服务上限初始化
$("#maxService").empty();
for (var i = 1; i <= 50; i++) {
  $("#maxService").append(
    '<option value="' + i + '">' + i + '</option>'
  )
}

//从业年限初始化
$("#workYear").empty();
for (var i = 1; i <= 50; i++) {
  $("#workYear").append(
    '<option value="' + i + '">' + i + '年</option>'
  )
}

//初始化民族
$.ajax({
  url: ctx + "/admin/register/nation/list",
  type: "GET",
  dataType: "json",
  success: function (data) {
    $("#nation").empty();
    $.each(data, function (index, item) {
      $("#nation").append(
        '<option value="' + item + '">' + item + '</option>'
      )
    });
  },
  error: function (e) {
    layer.alert("网络异常", {icon: 2});
  }
});

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

// 机构选择初始化
var orgTree = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    orgTree.tree = $("#save-region-tree").fancytree({
      extensions: ["glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/profession-member/treeorg",
        data: param
      },
      lazyLoad: function (event, data) {
        orgTree.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/profession-member/treeorg",
          data: orgTree.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        orgTree.selected = data.node;
      }
    });
    orgTree.tree.fancytree("getTree").setFocus(true);
    orgTree.tree.fancytree("getTree").visit(function (node) {
      node.setExpanded();
    });
  }
};

$(function () {
  orgTree.treeParam = {};
  orgTree.initTree(orgTree.treeParam);
})

