var attachment = {
  pattern: '',
  regist: function (pattern) {
    attachment.pattern = pattern;
    //上传文件事件
    $(":file").change(function () {
      if(attachment.pattern === 'single' && $(".attaDiv ").length >=1 ){
        layer.alert("只能选择一个");
        return;
      }
      if(attachment.pattern === 'img' && $(".attaDiv ").length >=1 ){
        $("#attas").html('');
      }
      var loadIndex = layer.load();
      if ($(this).val() == null || $(this).val() == undefined || $(this).val() == "") {
        return;
      }
      var option = {
        url: ctx + "/admin/attachment/uploadAtta",
        type: 'POST',
        dataType: "json",
        clearForm: false,
        restForm: false,
        success: function (res) {
          if (res.success) {
            layer.msg(res.message, {time: 1000});
            if(attachment.pattern === 'img'){
              $('#attas_img').attr('src',res.data.url)
            }
            $("#attas").append(
              '<div class="attaDiv" style="margin: 3px">' +
              '<label class="attaName col-sm-3">' + res.data.name + '</label>' +
              '<label class="attaSize col-sm-2">' + res.data.size + 'k</label>' +
              '<input type="text" class="attaRemark col-sm-4" placeholder="附件说明"/>' +
              '&nbsp;' + '&nbsp;' +
              '<a href="' + res.data.url + '" download="" class="attaUrl" target="_blank">下载</a>' +
              '&nbsp;' + '&nbsp;' +
              '<button type="button" class="btn-danger"  onclick="attachment.deleteAtta(this)"><i class="fa fa-trash-o"></i>删除</button>' +
              '</div>'
            );
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
        }
      };
      $("#attaForm").ajaxSubmit(option);
    });
  },
  deleteAtta: function (target) {
    $(target).parent().remove();
  },
  emptyAtta: function(){
    $("#attas").html('');
  },
  imgclear: function () {
    $('#attas_img').attr('src','');
    $('#attas').html('');
  },
  appendAtta: function (e) {
    $("#attas").append(
      '<div class="attaDiv" style="margin: 3px">' +
      '<label class="attaName col-sm-3">' + e.name + '</label>' +
      '<label class="attaSize col-sm-2">' + e.size + '</label>' +
      '<input type="text" class="attaRemark col-sm-4" value="' + e.remark + '" placeholder="附件说明"/>' +
      '&nbsp;' + '&nbsp;' +
      '<a href="' + e.url + '" download="" class="attaUrl" target="_blank">下载</a>' +
      '&nbsp;' + '&nbsp;' +
      '<button type="button" class="btn-danger"  onclick="attachment.deleteAtta(this)"><i class="fa fa-trash-o"></i>删除</button>' +
      '</div>'
    );
  },
  appendHostAtta: function (e) {
    if(e){
      $("#attas").append(
        '<div class="attaDiv" style="margin: 3px">' +
        '<label class="attaName col-sm-3">' + e.attaName + '</label>' +
        '<label class="attaSize col-sm-2">' + e.attaSize + '</label>' +
        '<input type="text" class="attaRemark col-sm-4" value="' + e.attaRemark + '" placeholder="附件说明"/>' +
        '<input type="hidden" value="'+e.persistent+'" class="persistentValue"/>' +
        '&nbsp;' + '&nbsp;' +
        '<a href="/api/edges/oss/redirect?file=' + e.attaUrl + '" download="" class="attaUrl" target="_blank">下载</a>' +
        '&nbsp;' + '&nbsp;' +
        '<button type="button" class="btn-danger"  onclick="attachment.deleteAtta(this)"><i class="fa fa-trash-o"></i>删除</button>' +
        '</div>'
      );
    }
  },
  getAttaParams: function () {
    var attas = new Array();
    $("#attas").find("div").each(function () {
      var attaName = $(this).find(".attaName").eq(0).html();
      var attaRemark = $(this).find(".attaRemark").eq(0).val();
      var attaUrl = $(this).find(".attaUrl").eq(0).attr("href");
      var attaSize = $(this).find(".attaSize").eq(0).html();
      var persistent = $(this).find(".persistentValue").eq(0).val();
      var atta = {
        attaName: attaName,
        attaRemark: attaRemark,
        attaUrl: attaUrl,
        attaSize: attaSize,
        persistent: persistent
      }
      attas.push(atta);
    });
    return attas;
  }
}