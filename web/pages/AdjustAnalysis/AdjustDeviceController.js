/**
 * Created by Administrator on 2017/7/13.
 */

'use strict';
angular.module("IntegratedFramework.AdjustDeviceController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/AdjustDevice', {
            templateUrl: 'pages/AdjustAnalysis/AdjustDevice.html',
            controller: 'AdjustDeviceController'
        })
    }])

    .controller('AdjustDeviceController', function ($scope, $http, myHttpService, serviceList, validate, notification, renderTableService) {

        layer.load(0);


        $(function () {
            myHttpService.get(serviceList.getAllAdjustDeviceException).then(function (response) {
                $scope.adjustDeviceList = response.data;
                hideLoadingPage();
            });

        });

        //渲染checkBox样式
        $scope.renderTable = function ($last) {
            renderTableService.renderTable($last);
        };


        //异常处理
        $scope.HandleResource = function (event) {
            layer.confirm('是否处理当前异常?', {
                btn: ['确定', '取消'] //按钮
            }, function (index) {
                layer.load();
                myHttpService.get(serviceList.getAllAdjustDeviceException).then(function (response) {
                    if (response.data.state == 1) {  //撤销
                        cancelResource(event);
                    }else if(response.data.state == 0){  //恢复
                        resumeResource(event);
                    } else {
                        notification.sendNotification("alert", "请重试");
                    }
                    hideLoadingPage();
                });
                layer.close(index);
            }, function (index) {
                layer.close(index);
                notification.sendNotification("alert", "取消异常处理");
            });
        };

        function cancelResource(event) {
            var e = event || window.event;
            var target = e.target || e.srcElement;
            if (target.parentNode.parentNode.tagName.toLowerCase() == "td") {
                var rowIndex = target.parentNode.parentNode.parentNode.rowIndex;
                var id = document.getElementById("table_value").rows[rowIndex].cells[0].innerHTML;
                //alert(id);
                myHttpService.get(serviceList.CancelResource + "?id=" + id).then(function successCallback(response) {
                    hideLoadingPage();
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败...");
                })
            }
        }

        function resumeResource(event) {
            var e = event || window.event;
            var target = e.target || e.srcElement;
            if (target.parentNode.parentNode.tagName.toLowerCase() == "td") {
                var rowIndex = target.parentNode.parentNode.parentNode.rowIndex;
                var id = document.getElementById("table_value").rows[rowIndex].cells[0].innerHTML;
                //alert(id);
                myHttpService.get(serviceList.ResumeResource + "?id=" + id).then(function successCallback(response) {
                    hideLoadingPage();
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败...");
                })
            }
        }


       /* myHttpService.get(serviceList.queryApsState).then(function (response) {
            if (response.data.result == "ok") {
                if (response.data.data.state == 0) {
                    $("#modal-add").modal({show: 'true'});
                } else {
                    notification.sendNotification("alert", "APS正在计算中，无法排程");
                    // layer.msg('APS正在计算中，无法排程!', {icon: 2});
                }
            } else {
                notification.sendNotification("alert", "查询APS状态失败，请重试");
                // layer.msg('查询APS状态失败，请重试!', {icon: 2});
            }
        });*/

    });