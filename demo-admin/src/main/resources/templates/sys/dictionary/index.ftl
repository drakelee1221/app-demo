<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="col-sm-6">
  <div>字典</div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="m-b-sm">
        <button onclick="pi.addOrEdit('add')" type="button" class="btn btn-info">
          <i class="fa fa-plus"></i>
          新增
        </button>
        <button onclick="pi.addOrEdit('edit')" type="button" class="btn btn-warning">
          <i class="fa fa-edit"></i>
          编辑
        </button>
        <button onclick="pi.delete()" type="button" class="btn btn-danger">
          <i class="fa fa-remove"></i>
          删除
        </button>
        <button onclick="exampleSelect()" type="button" class="btn btn-default right-align">
          后台下拉框示例
        </button>
        <button onclick="refreshDictionaryCache()" type="button" class="btn btn-default right-align">
          刷新服务器字典缓存
        </button>
      </div>
      <form id="search_form" name="searchForm">
        <div class="form-inline">
          <div class="form-group">
            <label for="searchDictCode" class="sr-only">字典编码</label>
            <input type="text" placeholder="字典编码" name="searchDictCode" id="searchDictCode" class="form-control">
          </div>
          <div class="form-group">
            <label for="searchDictName" class="sr-only">字典名称</label>
            <input type="text" placeholder="字典名称" name="searchDictName" id="searchDictName" class="form-control">
          </div>
          <div class="form-group">
            <label for="searchDataType" class="sr-only">数据类型</label>
            <div class="dictDiv" inputType="select" inputName="searchDataType" firstOption="全部" firstOptionValue=""
                 dictCode="dictDataType"></div>
          </div>
          <div class="form-group">
            <label for="searchStatus" class="sr-only">状态</label>
            <div class="dictDiv" inputType="select" inputName="searchStatus" firstOption="全部" firstOptionValue="-1"
                 dictCode="status"></div>
          </div>
          <div class="form-group">
            <label for="searchCanEdit" class="sr-only">状态</label>
            <div class="dictDiv" inputType="select" inputName="searchCanEdit" firstOption="全部" firstOptionValue="-1"
                 dictCode="canEdit"></div>
          </div>
          <button type="button" class="btn btn-primary" onclick="pi.search()"><i class="fa fa-search"></i>查询</button>
          <button type="button" class="btn btn-white" onclick="pi.clearCondition()"><i class="fa fa-recycle"></i>清空条件
          </button>
        </div>
      </form>
    </div>
    <div class="panel-body">
      <table id="table_list"></table>
    </div>
  </div>
  <div class="modal" id="dictionaryModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width: 65%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">关闭</span>
          </button>
          <h4 class="modal-title">
            <b id="modal_title">字典</b>
          </h4>
        </div>
        <div class="modal-body">
          <form class="panel-body form-horizontal" id="dictionary_form" name="dictionaryForm">
            <input type="hidden" class="form-control" name="id" id="id"/>
            <input type="hidden" class="form-control" name="orderNo" id="orderNo"/>
            <div class="form-group">
              <label for="dictCode" class="control-label">字典编码：</label>
              <div>
                <input type="text" class="form-control" placeholder="字典编码" id="dictCode" name="dictCode"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="dictName" class="control-label">字典名称：</label>
              <div>
                <input type="text" class="form-control" placeholder="字典编码" id="dictName" name="dictName"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="dataType" class="control-label">数据类型：</label>
              <div>
                <div class="dictDiv" inputType="select" inputName="dataType" inputRequired="required"
                     dictCode="dictDataType"></div>
              </div>
            </div>

            <div class="form-group">
              <label for="canEdit" class="control-label">是否可编辑：</label>
              <div>
                <div class="dictDiv" inputType="select" inputName="canEdit" inputRequired="required"
                     dictCode="canEdit"></div>
              </div>
            </div>

            <div class="form-group">
              <label for="remarks" class="control-label">备注：</label>
              <div>
                <input type="text" class="form-control" placeholder="备注" id="remarks" name="remarks"
                       required="required"/>
              </div>
            </div>

            <div class="form-group">
              <label for="status" class="control-label">状态：</label>
              <div class="dictDiv" inputType="select" inputName="status" inputRequired="required"
                   dictCode="status"></div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="dealSaveBtn" onclick="pi.dealSave()"><i
            class="fa fa-save"></i>提交
          </button>
          <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
        </div>
      </div>
    </div>
  </div>
  <#--后台下拉框示例-->
  <div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width: 50%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">关闭</span>
          </button>
          <h4 class="modal-title">
            <b id="modal_title">后台下拉框示例</b>
          </h4>
        </div>
        <div class="modal-body">
          1、示例代码（其中属性inputName、inputRequired、firstOption、firstOptionValue、dictCode自定义，dictCode是字典编码）：
          <xmp style="white-space: pre-wrap;word-wrap: break-word;">
            <div class="dictDiv" inputType="select" inputName="example1" inputRequired="required"  firstOption="全部" firstOptionValue="-1" dictCode="status"></div>
            <div class="dictDiv" inputType="select" inputName="example2" inputRequired="required"  firstOption="--请选择--" firstOptionValue="" dictCode="dictDataType"></div>
          </xmp>
          2、后台页面引入："${ctx!}/admin/pub/js/sys/dictionary/data/util.js"（有根据dictCode获取字典数据的方法）
          <br>
          3、执行： dictUtil.initElement()
          <br>
          4、示例结果：
          <div class="dictDiv" inputType="select" inputName="example" inputRequired="required"   firstOption="全部" firstOptionValue="-1" dictCode="status"></div>
          <br>
          <div class="dictDiv" inputType="select" inputName="example2" inputRequired="required"  firstOption="--请选择--" firstOptionValue="" dictCode="dictDataType"></div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
        </div>
      </div>
    </div>
  </div>
  <#--/后台下拉框示例-->

</div>

<iframe class="col-sm-6" src="${ctx!}/admin/sys/dictionary/data/index" name="dictionaryDataIfm" id="dictionaryDataIfm"
        style="border: 0;margin: 0;padding: 0;margin-top: -20px;"></iframe>

</@htmlContent>

<@htmlJs>
  <script src="${ctx!}/admin/pub/js/sys/dictionary/index.js"></script>
  <script src="${ctx!}/admin/pub/js/sys/dictionary/data/util.js"></script>
  <script>
    dictUtil.initElement();
  </script>
  <@fancytree/>
</@htmlJs>