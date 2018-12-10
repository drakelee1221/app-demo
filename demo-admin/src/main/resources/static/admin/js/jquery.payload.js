
(function($){
  if($){
    $.postPayload = function(url, jsonData, success, error, returnType){
      $.payload(url, "POST", jsonData, success, error, returnType);
    };
    $.putPayload = function(url, jsonData, success, error, returnType){
      $.payload(url, "PUT", jsonData, success, error, returnType);
    };
    $.deletePayload = function(url, jsonData, success, error, returnType){
      $.payload(url, "DELETE", jsonData, success, error, returnType);
    };
    $.payload = function(url, method, jsonData, success, error, returnType){
      var data = (jsonData ? ($.type(jsonData) === "object" ? JSON.stringify(jsonData) : jsonData.toString()) : "{}");
      $.ajax(url, {
        method : method,
        contentType:'application/json;charset=utf-8',
        data: data,
        dataType: (returnType ? returnType : "json"),
        success : function (rs) {
          if(success){
            success(rs);
          }
        },
        error: function (e) {
          if(error){
            error(e);
          }
        }
      });
    };
  }
})(window.jQuery);