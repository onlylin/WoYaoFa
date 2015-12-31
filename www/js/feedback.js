angular.module('feedback', []).controller('feedbackCtrl', function($scope, $http) {
    // var account = eval("(" + window.jsparams.getJson() + ")");

    angular.element("#submit").click(function() {
        console.log(JSON.stringify({
            'accountId': 38,
            'content': $scope.comment.content
        }));

        if ($scope.comment.content) {
            // $.ajax({
//     url: HOST + 'feedbacks/add', // 跳转到 action
//     data: {
//         'accountId': 38,
//         'content': $scope.comment.content
//     },
//     type: 'post',
//     cache: false,
//     dataType: 'json',
//     contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
//     success: function(data, textStatus) {
//         console.log("success");
//         window.jscomm.toastAlways(data.msg);
//         if (data.datas == undefined) {} else {
//             // window.jscomm.onBack();
//         }
//     },
//     error: function(XMLHttpRequest, textStatus, errorThrown) {
//         // view("异常！");
//         alert("异常！" + textStatus + " == " + errorThrown + " == " + XMLHttpRequest);
//     }
// });

                $http({
                    method: 'post',
                    dataType: 'json',
                    url: HOST + 'feedbacks/add',
                    data: $.param({
                        'accountId': 38,
                        'content': $scope.comment.content
                    }),
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                    }
                }).success(function(data, status, headers, config) {
                    console.log("success");
                    window.jscomm.toastAlways(data.msg);
                    if (data.datas == undefined) {} else {
                        window.jscomm.onBack();
                    }
                }).error(function(data, status, headers, config) {
                    console.log("err " + status +" | "+ headers +" | "+config);
                    window.jscomm.toastAlways(data);
                });
        } else {
            alert("内容不能为空哦！");
        }
    });
});
