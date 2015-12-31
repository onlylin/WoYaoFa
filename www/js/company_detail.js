angular.module('companyDetail', []).controller('companyDetailCtrl', function($scope, $http) {
      connectWebViewJavascriptBridge(function(bridge){
        bridge.init(function(message,responseCallback) {

        })

        bridge.registerHandler('comapnyDetail',function(data,responseCallback){
          $http({
              method: 'get',
              dataType: 'json',
              url: HOST + 'companies/detail/' + data.id,
              data: {
                  'accountId': '1'
              },
              headers: {
                  'Content-Type': 'application/x-www-form-urlencoded'
              }
          }).success(function(data, status, headers, config) {
              if (data.datas == undefined) {
                  alert(data.msg);
              } else {
                  $scope.companyBean = data.datas;
                  console.log(JSON.stringify(data));
              }
          }).error(function(data, status, headers, config) {
              alert("请求失败！" + data);
          });
        })
      })
  })
