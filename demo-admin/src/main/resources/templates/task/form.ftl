<#include "/layout/frmlayout.ftl"/>

<@htmlContent>
<div class="row">
  <div class="col-sm-12">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5>修改调度作业</h5>
      </div>
      <div class="ibox-content">
        <form class="form-horizontal m-t" id="frm" method="post">
          <div class="form-group">
            <div class="col-xs-6">
              <label class="col-xs-3 control-label">名称：</label>
              <div class="col-xs-9">
                <input name="taskName" class="form-control"
                       value="${task.name!}">
              </div>
            </div>
            <div class="col-xs-6">
              <label class="col-xs-3 control-label">描述：</label>
              <div class="col-xs-9">
                <input name="description" class="form-control"
                       value="${task.description!}">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-xs-6">
              <label class="col-xs-3 control-label">时间表达式：</label>
              <div class="col-xs-9">
                <input name="cronExpression" class="form-control"
                       value="${task.cronExpression!}">
              </div>
            </div>
            <div class="col-xs-6">
              <label class="col-xs-3 control-label">调用参数Json：</label>
              <div class="col-xs-9">
                <input name="argumentsMap" class="form-control"
                       value='${task.argumentsMap!}'>
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-xs-6">
              <label class="col-xs-3 control-label">调用Class：</label>
              <div class="col-xs-9">
                <input name="targetClass" class="form-control"
                       value="${task.targetClass!}">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="col-xs-12 text-center">
              <button class="btn btn-primary" type="submit">保存</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<!-- Page-Level Scripts -->
<script type="text/javascript">
  $(document).ready(function () {

    $("#frm").validate({
      rules: {
        name: {
          required: true,
          minlength: 2
        },
        targetClass: {
          required: true,
          minlength: 10
        },
        cronExpression: {
          required: true
        }
      },
      messages: {},
      submitHandler: function (form) {
        $.post("${ctx!}/admin/task/edit/${task.id}", $(form).serialize(), function(res){
          if (res.success) {
            layer.msg(res.message, {time: 2000}, function () {
              var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
              parent.layer.close(index);
            });
          }
          else {
            layer.alert(res.message, {icon: 2});
          }
        });
      }
    });
  });
</script>
</@htmlJs>