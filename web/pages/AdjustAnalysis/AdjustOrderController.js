/**
 * Created by XY on 2017/7/12.
 */
'use strict';
angular.module("IntegratedFramework.AdjustOrderController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/AdjustOrder', {
            templateUrl: 'pages/AdjustAnalysis/AdjustOrder.html',
            controller: 'AdjustOrderController'
        })
    }])

    .controller('AdjustOrderController', function ($scope, $http, myHttpService, serviceList, validate, renderTableService, notification) {

        layer.load(0);

        var addData = [];
        var edit_params = {};//获取需改后的数据
        var idVal;
        var id_params = {}; //保存选中的记录的id信息

        $(function () {
            myHttpService.get(serviceList.AdjustOrder).then(function (response) {
                $scope.adjustOrder = response.data;

                hideLoadingPage();
            });
        });

        //渲染checkBox样式
        $scope.renderTable = function ($last) {
            renderTableService.renderTable($last);
        };

        //Date picker
        $('#modal-add-t0-datepicker').datepicker({
            format: "yyyy/mm/dd",
            todayHighlight: true,
            autoclose: true
        });
        $('#modal-add-t1-datepicker').datepicker({
            format: "yyyy/mm/dd",
            todayHighlight: true,
            autoclose: true
        });
        $('#modal-add-t2-datepicker').datepicker({
            format: "yyyy/mm/dd",
            todayHighlight: true,
            autoclose: true
        });

        //信息填写检验
        var orderAddValidate = function () {
            var params = {};
            var t0 = $("input[id='modal-add-t0-datepicker']").val();
            var t1 = $("input[id='modal-add-t1-datepicker']").val();
            var t2 = $("input[id='modal-add-t2-datepicker']").val();
            params.t0 = Date.parse($("input[id='modal-add-t0-datepicker']").val());
            params.t1 = Date.parse($("input[id='modal-add-t1-datepicker']").val());
            params.t2 = Date.parse($("input[id='modal-add-t2-datepicker']").val());
            addData = JSON.stringify(params);

            if (!validate.checkLength(t0)) {
                $("#add-t0").removeClass("has-success");
                $("#add-t0").addClass("has-error");
            } else {
                $("#add-t0").removeClass("has-error");
                $("#add-t0").addClass(" has-success");
            }

            if (!validate.checkLength(t0)) {
                $("#add-t1").removeClass("has-success");
                $("#add-t1").addClass("has-error");
            } else {
                $("#add-t1").removeClass("has-error");
                $("#add-t1").addClass(" has-success");
            }

            if (!validate.checkLength(t2)) {
                $("#add-t2").removeClass("has-success");
                $("#add-t2").addClass("has-error");
            } else {
                $("#add-t2").removeClass("has-error");
                $("#add-t2").addClass(" has-success");
            }

            if (validate.checkLength(params.t0) && validate.checkLength(params.t1) && validate.checkLength(params.t2)) {
                return true;
            } else {

                return false;
            }
        };

        //异常状态
        $scope.addAdjustOrder = function () {
            if (orderAddValidate()) {
                $("#modal-add").modal('hide');
                console.log(addData);
                myHttpService.post(serviceList.AddAdjustOrder, addData).then(function successCallback() {
                    setTimeout('window.location.reload();', 0.1);
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                notification.sendNotification("alert", "参数错误");
            }
        };

        //异常处理
        $scope.exceptionHandling = function (event) {

            myHttpService.get(serviceList.queryApsState).then(function (response) {
                if (response.data.result == "ok") {
                    if (response.data.data.state == 0) {
                        processError();
                    } else {
                        layer.msg('APS正在计算中，无法排程!', {icon: 2});
                    }
                } else {
                    layer.msg('查询APS状态失败，请重试!', {icon: 2});
                }
            });
        };

        function processError() {
            var idInfo;
            var e = event || window.event;
            var target = e.target || e.srcElement;
            if (target.parentNode.tagName.toLowerCase() == "td") {
                var rowIndex = target.parentNode.parentNode.rowIndex;
                var id = document.getElementById("table_adjust").rows[rowIndex].cells[0].innerHTML;
                myHttpService.get(serviceList.orderExceptionHandling + "?id=" + id, idInfo).then(function successCallback(response) {
                    if (response.data.result == "ok") {
                        notification.sendNotification("confirm", "异常处理中...");
                    } else {
                        notification.sendNotification("alert", "请求失败");
                    }
                }, function errorCallback(response) {
                    notification.sendNotification("alert", "请求失败");
                })
            }
        }

        $scope.reset = function () {
            $("input").val('');
            $("div").removeClass("has-error");
            $("div").removeClass("has-success");
        };
    });