angular.module('companyIndex', []).controller('companyIndexCtrl', function($scope, $http) {
  connectWebViewJavascriptBridge(function(bridge){
    bridge.init(function(message,responseCallback) {

    })

    bridge.registerHandler('companyHome',function(data,response){
      $http({
          method: 'get',
          dataType: 'json',
          url: HOST + 'companies/home/' + data.id,
          data: {
              'accountId': data.id
          },
          headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
          }
      }).success(function(data, status, headers, config) {
          console.log(JSON.stringify(data));
          if (data.datas == undefined) {
              alert(data.msg);
          } else {
              $scope.companyBean = data.datas;
              for (var i = 0; i < 3; i++) {
                  $scope.companyBean.images[i]={"host":"http://img0.imgtn.bdimg.com/","id":361,"url":"it/u=48252272,1629415252&fm=21&gp=0.jpg"}
              }
              if ($scope.companyBean.lines) {
                  $scope.companyBean.commentNum = 0;
                  $scope.companyBean.commentTotalScore = 0;
                  for (var i = 0; i < $scope.companyBean.lines.length; i++) {
                      var line = $scope.companyBean.lines[i];
                      $scope.companyBean.commentNum += line.commentNum;
                      $scope.companyBean.commentTotalScore += line.commentTotalScore;
                  }
                  $scope.companyBean.commentTotalScore = $scope.companyBean.commentTotalScore / $scope.companyBean.lines.length;
              }
          }
      }).error(function(data, status, headers, config) {
          alert("请求失败！" + data);
      });
    })

    angular.element("#option_phone").click(function() {
      bridge.callHandler('callPhone', {'phone':$scope.companyBean.phone}, function(response) {

      })
    })

    angular.element("#phone").click(function() {
      bridge.callHandler('callPhone', {'phone':$scope.companyBean.phone}, function(response) {

      })
    })

    angular.element("#company_content").click(function() {
      bridge.callHandler('detail', {'id':$scope.companyBean.id}, function(response) {

      })
    })

  })

    angular.element("#collect").click(function() {
        try {
            $scope.accountBean = eval("(" + window.jscomm.getAccountWithLogin() + ")");
            $http({
                method: 'post',
                dataType: 'json',
                url: HOST + 'collections/add',
                data: $.param({
                    'companyId': $scope.companyBean.id,
                    'type': 0, //(0表示公司，1表示线路)
                    'accountId': $scope.accountBean.id
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
});
jQuery(function($) {
    $('#carousel').slideBox({
        duration: 0.3, //滚动持续时间，单位：秒
        easing: 'linear', //swing,linear//滚动特效
        delay: 5, //滚动延迟时间，单位：秒
        hideClickBar: false, //不自动隐藏点选按键
        clickBarRadius: 10
    });
});
