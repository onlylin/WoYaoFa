angular.module('claim', []).controller('ClaimController', function($scope, $http) {
    angular.element("#submit").click(function() {
        $http({
            method: 'get',
            dataType: 'json',
            url: HOST + 'http://192.168.199.170:8080/Wuliu-Api/webapi/addressbooks/list/1/0/1/15',
            data: {
                'accountId': '1'
            },
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).success(function(data, status, headers, config) {
            alert(data.datas.resultList[0].name + "  " + status);
        }).error(function(data, status, headers, config) {
            window.jscomm.toastAlways(data);
        });
    });
})
