jQuery(function($) {
    $('#carousel').slideBox({
        duration: 0.3, //滚动持续时间，单位：秒
        easing: 'linear', //swing,linear//滚动特效
        delay: 5, //滚动延迟时间，单位：秒
        hideClickBar: false, //不自动隐藏点选按键
        clickBarRadius: 10
    });
});

angular.module('line_detail', []).controller('lineDetailCtrl', function($scope, $http) {
  var accountId;
  connectWebViewJavascriptBridge(function(bridge){
    bridge.init(function(message,responseCallback) {

    })

    bridge.registerHandler('lineDetail',function(data,responseCallback){
      accountId = data.accountId;
      $http({
          method: 'get',
          dataType: 'json',
          url: HOST + 'lines/detail/' + data.id,
          data: {
              'accountId': '1'
          },
          headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
          }
      }).success(function(data, status, headers, config) {
          console.log(JSON.stringify(data));
          if (data.datas == undefined) {
              alert(data.msg);
          } else {
              $scope.lineBean = data.datas;
          }
      }).error(function(data, status, headers, config) {
          alert("请求失败，请重新尝试！");
      });
      $http({
          method: 'get',
          dataType: 'json',
          url: HOST + 'lines/others/' + data.companyId + "/" + data.id,
          data: {},
          headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
          }
      }).success(function(data, status, headers, config) {
          console.log(JSON.stringify(data));
          if (data.datas == undefined) {
              alert(data.msg);
          } else {
              $scope.otherLines = data.datas;
          }
      }).error(function(data, status, headers, config) {
          alert("请求失败，请重新尝试！");
      });
    })

    angular.element("#company").click(function() {
      bridge.callHandler('detail', {'id':$scope.lineBean.company.id}, function(response) {

      })
    })

    //下单
    angular.element("#order").click(function() {
      bridge.callHandler('makeOrder',null, function(response) {

      })
    })

    //打电话
    angular.element("#phone").click(function() {
      bridge.callHandler('callPhone',{"phone" : $scope.lineBean.company.phone}, function(response) {

      })
    })

    //打电话
    angular.element("#option_phone").click(function() {
      bridge.callHandler('callPhone',{"phone" : $scope.lineBean.company.phone}, function(response) {

      })
    })

    //评论列表
    angular.element("#evaluation").click(function() {
      bridge.callHandler('comment',{'id':$scope.lineBean.id},function(response){

      })
    })

  });

   angular.element("#collect").click(function() {
        try {
            $http({
                method: 'post',
                dataType: 'json',
                url: HOST + 'collections/add',
                data: $.param({
                    'lineId': $scope.lineBean.id,
                    'type': 1, //(0表示公司，1表示线路)
                    'accountId': accountId
                }),
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            }).success(function(data, status, headers, config) {
                console.log(JSON.stringify(data));
                alert(data.msg);
            }).error(function(data, status, headers, config) {
                alert("请求失败，请重新尝试！");
            });
        } catch (e) {
            console.log(e);
        } finally {

        }
    });
})
