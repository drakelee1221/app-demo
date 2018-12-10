<@htmlContent>
<#-- 加载编辑器的容器 -->
<div id="${(ueditor_id == null)?string('ueditor_content', ueditor_id)}" type="text/plain"/>
</@htmlContent>
<@htmlJs>
<#-- 配置文件 -->
<script type="text/javascript" src="${ctx!}/admin/pub/plugin/ueditor/ueditor.config.js"></script>
<#-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx!}/admin/pub/plugin/ueditor/editor_api.js"></script>
<#-- 实例化编辑器 -->
<script type="text/javascript">
  ${(ueditor_id == null)?string('ue', ueditor_id)} =
    UE.getEditor("${(ueditor_id == null)?string('ueditor_content', ueditor_id)}",
      {initialFrameHeight: '${(ueditor_height == null)?string('300', ueditor_height)}'});
</script>
</@htmlJs>