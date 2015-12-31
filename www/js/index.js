jQuery(function($) {
    $('#carousel').slideBox({
        duration: 0.3, //滚动持续时间，单位：秒
        easing: 'linear', //swing,linear//滚动特效
        delay: 5, //滚动延迟时间，单位：秒
        hideClickBar: false, //不自动隐藏点选按键
        clickBarRadius: 10
    });
});
angular.module('index', []).controller('IndexController', function($scope, $http) {
    angular.element("#submit").click(function() {
        $http({
            method: 'get',
            dataType: 'json',
            url: HOST + 'lines/detail/1',
            data: {
                'accountId': '1'
            },
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).success(function(data, status, headers, config) {
            if (data.datas == undefined) {
                console.log(data.msg + "  " + status);
                alert(data.msg);
            } else {
                console.log(data.datas + "  " + status);
            }
        }).error(function(data, status, headers, config) {
            console.log(data);
        });
    });

    connectWebViewJavascriptBridge(function(bridge){
      bridge.init(function(message,responseCallback) {

      })

      // bridge.registerHandler('request',function(data,responseCallback){
      //   alert(data.foo);
      //   var responseData = { 'Javascript Says':'Right back atcha!' }
  		// 	responseCallback(responseData)
      // })

      //发快递
      angular.element("#item_find_express").click(function() {
        bridge.callHandler('express', null, function(response) {

        })
      });

      //找物流
      angular.element("#item_find_logistics").click(function() {
        bridge.callHandler('findLogistics', null, function(response) {

        })
      });

    });


})
