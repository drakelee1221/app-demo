/**
 * Created by Administrator on 2017/12/18 0018.
 */
$(document).ready(function () {
  //初始化表格,动态从服务器加载数据
  $("#table_list").bootstrapTable({
    method: "POST",
    contentType: "application/x-www-form-urlencoded",
    url: ctx+"/user/list",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    ajaxOptions:{
      async:false
    },
    queryParams: searchParams,
    silent: true,
    //数据列
    columns: [{
      title: "用户名",
      field: "nickName"
    }, {
      title: "手机号",
      field: "phone"
    }, {
      title: "邮箱",
      field: "userEmail"
    }, {
      title: "性别",
      field: "sex",
      formatter: function (value, row, index) {
        if (value === 1) {
          return "男";
        } else if (value === 2) {
          return "女";
        } else {
          return "未知";
        }
      }
    }, {
      title: "年龄",
      field: "age"
    }, {
      title: "职位",
      field: "jobTitle"
    }, {
      title: "工作年限",
      field: "workYears"
    },{
      title:"允许登录",
      field:"valided",
      formatter:function(value, row, index){
        var t;
        if(value){
          t= "<div class='switch' data-animated='switch-mini'><input userId='"+row.userId+"' type='checkbox' checked='checked' name='validUser'></div>";
        }else{
          t= "<div class='switch' data-animated='switch-mini'><input userId='"+row.userId+"' type='checkbox' name='validUser' name='validUser'></div>";
        }

        return t;
      }
    },{
      title:"允许兑换",
      field:"exchange",
      formatter:function(value, row, index){
        var t;
        if(value === 1){
          t= "<div class='switch' data-animated='switch-mini'><input userId='"+row.userId+"' type='checkbox' checked='checked' name='exchangeVal'></div>";
        }else{
          t= "<div class='switch' data-animated='switch-mini'><input userId='"+row.userId+"' type='checkbox' name='exchangeVal' ></div>";
        }

        return t;
      }
    }, {
      title: "是否验证",
      field: "authed",//0 未认证 1认证中 2已认证  -1认证失败
      formatter: function (value, row, index) {
        var n = "";
        switch (value) {
          case 0:
            n = "未认证";
            break;
          case 1:
            n = "认证中";
            break;
          case 2:
            n = "已认证";
            break;
          case -1:
            n = "认证失败";
            break;
        }
        return n;
      }
    }, {
      title: "创建时间",
      field: "createTime"
    }, {
      title: "上次登录时间",
      field: "lastLoginTime"
    },{
      title:"备注",
      field:"remarks"
    }, {
      title: "操作",
      field: "id",
      formatter: function (value, row, index) {
        var operateHtml = '<button class="btn btn-primary btn-xs" type="button" onclick="setRemark(\'' + row.userId + '\',\'' + row.remarks + '\')"><i class="fa fa-edit"></i>备注</button> &nbsp;';
        operateHtml = operateHtml + '<button class="btn btn-danger btn-xs" type="button" onclick="edit(\'' + row.userId + '\')"><i class="fa fa-edit"></i>编辑</button> &nbsp;';
        return operateHtml;
      }
    }]
  });
  initSwitch();
});
function initSwitch(){
  $(':input[name="validUser"]').bootstrapSwitch({
    size:"mini",
    onSwitchChange:function(event,state){
      var userId = $(this).attr("userId");
      $.ajax({
        url:ctx+"/admin/user/valided",
        data:{
          userId:userId,
          valided:state?1:0
        }
      });
    }
  });
  $(':input[name="exchangeVal"]').bootstrapSwitch({
    size:"mini",
    onSwitchChange:function(event,state){
      var userId = $(this).attr("userId");
      $.ajax({
        url:ctx+"/admin/user/exchange",
        data:{
          userId:userId,
          exchange:state?1:0
        }
      });
    }
  });
}
function searchParams(params) {
  return {
    pageSize: params.pageSize,
    pageNum: params.pageNum,
    jobTitle: $("#jobTitle").val(),
    userName: $("#userName").val(),
    phone: $("#phone").val(),
    workYear: $("#workYear").val(),
    isAuth: $("#isAuth").val(),
    registerStart:$("#registerStart").val(),
    registerEnd:$("#registerEnd").val()
  };
}
function searchUser() {
  $('#table_list').bootstrapTable("refresh");
  initSwitch();
}

function edit(userId) {
  window.location.href=ctx+"/user/userinfo?userId="+userId;
}
function setRemark(userId,remark) {
  $("#userRemarks").show();
  if(remark !== "undefined"){
    $("#remark").val(remark);
  }
  layer.open({
    type: 1,
    btn:["确定","取消"],
    skin: 'layui-layer-rim', //加上边框
    area: ['420px', '240px'], //宽高
    content: $('#userRemarks'),
    yes: function(index, layero){
      $.ajax({
        url:ctx+"/admin/user/remarks",
        data:{
          userId:userId,
          remarks:$("#remark").val()
        },
        success:function () {
          searchUser();
          $("#remark").val('');
          layer.close(index);
        }
      });

    }

  });
}
function exportUsers() {
  var params = {
    jobTitle: $("#jobTitle").val(),
    userName: $("#userName").val(),
    phone: $("#phone").val(),
    workYear: $("#workYear").val(),
    isAuth: $("#isAuth").val(),
    registerStart:$("#registerStart").val(),
    registerEnd:$("#registerEnd").val()
  }
  var arr = [];
  for(var x in params){
    arr.push(x+"="+params[x]);
  }

  window.open(ctx+"/admin/users/export?"+arr.join("&"));

}