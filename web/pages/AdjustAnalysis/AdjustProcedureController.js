/**
 * Created by XY on 2017/7/12.
 */
'use strict';
angular.module("IntegratedFramework.AdjustProcedureController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/AdjustProcedure', {
            templateUrl: 'pages/AdjustAnalysis/AdjustProcedure.html',
            controller: 'AdjustProcedureController'
        })
    }])
    .controller('AdjustProcedureController', function ($scope, $http, myHttpService, serviceList, validate, renderTableService, notification) {
        layer.load(0);

        var addData = [];

        $(function () {
            //加载页面时数据显示
            myHttpService.get(serviceList.AdjustProcess).then(function (response) {
                $scope.arr = response.data;

                hideLoadingPage();
            });
        });

        //渲染checkBox样式
        $scope.renderTable = function ($last) {
            renderTableService.renderTable($last);
        };

        //信息填写检验
        var processAddValidate = function () {
            var params = {};
            params.idTask = $("input[name='add-idTask']").val();
            params.idJob = $("input[name='add-idJob']").val();
            params.idOrder = $("input[name='add-idOrder']").val();
            params.originalResource = $("input[name='add-originalResource']").val();
            params.appointResource = $("input[name='add-appointResource']").val();
            var reportTime = $("input[id='modal-add-reportTime-datepicker']").val();
            var originalStartTime = $("input[id='modal-add-originalStartTime-datepicker']").val();
            var appointStartTime = $("input[id='modal-add-appointStartTime-datepicker']").val();
            params.reportTime = (new Date($("input[id='modal-add-reportTime-datepicker']").val())).getTime();
            params.originalStartTime = (new Date($("input[id='modal-add-originalStartTime-datepicker']").val())).getTime();
            params.appointStartTime = (new Date($("input[id='modal-add-appointStartTime-datepicker']").val())).getTime();
            addData = JSON.stringify(params);

            if (!validate.checkLength(params.idTask) || !validate.checkNumber(params.idTask)) {
                $("#add-idTask").removeClass("has-success");
                $("#add-idTask").addClass("has-error");
            } else {
                $("#add-idTask").removeClass("has-error");
                $("#add-idTask").addClass(" has-success");
            }

            if (!validate.checkLength(params.idJob) || !validate.checkNumber(params.idJob)) {
                $("#add-idJob").removeClass("has-success");
                $("#add-idJob").addClass("has-error");
            } else {
                $("#add-idJob").removeClass("has-error");
                $("#add-idJob").addClass(" has-success");
            }

            if (!validate.checkLength(params.idOrder) || !validate.checkNumber(params.idOrder)) {
                $("#add-idOrder").removeClass("has-success");
                $("#add-idOrder").addClass("has-error");
            } else {
                $("#add-idOrder").removeClass("has-error");
                $("#add-idOrder").addClass(" has-success");
            }

            if (!validate.checkLength(params.originalResource) || !validate.checkNumber(params.originalResource)) {
                $("#add-originalResource").removeClass("has-success");
                $("#add-originalResource").addClass("has-error");
            } else {
                $("#add-originalResource").removeClass("has-error");
                $("#add-originalResource").addClass(" has-success");
            }

            if (!validate.checkLength(params.appointResource) || !validate.checkNumber(params.appointResource)) {
                $("#add-appointResource").removeClass("has-success");
                $("#add-appointResource").addClass("has-error");
            } else {
                $("#add-appointResource").removeClass("has-error");
                $("#add-appointResource").addClass(" has-success");
            }

            if (!validate.checkLength(reportTime)) {
                $("#add-reportTime").removeClass("has-success");
                $("#add-reportTime").addClass("has-error");
            } else {
                $("#add-reportTime").removeClass("has-error");
                $("#add-reportTime").addClass(" has-success");
            }

            if (!validate.checkLength(originalStartTime)) {
                $("#add-originalStartTime").removeClass("has-success");
                $("#add-originalStartTime").addClass("has-error");
            } else {
                $("#add-originalStartTime").removeClass("has-error");
                $("#add-originalStartTime").addClass(" has-success");
            }

            if (!validate.checkLength(appointStartTime)) {
                $("#add-appointStartTime").removeClass("has-success");
                $("#add-appointStartTime").addClass("has-error");
            } else {
                $("#add-appointStartTime").removeClass("has-error");
                $("#add-appointStartTime").addClass(" has-success");
            }

            if (validate.checkLength(params.idTask) && validate.checkNumber(params.idTask) &&
                validate.checkLength(params.idJob) && validate.checkNumber(params.idJob) &&
                validate.checkLength(params.idOrder) && validate.checkNumber(params.idOrder) &&
                validate.checkLength(params.originalResource) && validate.checkNumber(params.originalResource) &&
                validate.checkLength(params.appointResource) && validate.checkNumber(params.appointResource) &&
                validate.checkLength(params.reportTime) && validate.checkLength(params.originalStartTime) &&
                validate.checkLength(params.appointStartTime)) {
                return true;
            } else {

                return false;
            }
        };

        //异常模拟
        $scope.addAdjustProcess = function () {
            /*if (processAddValidate()) {
                $("#modal-simulate").modal('hide');*/
                myHttpService.post(serviceList.AddAdjustProcess, addData).then(function successCallback() {
                    myHttpService.get(serviceList.AdjustProcess).then(function (response) {
                        $scope.arr = response.data;
                        notification.sendNotification("confirm", "添加成功");
                    })
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
           /* } else {
                notification.sendNotification("alert", "输入有误");
            }*/
        };

        //异常处理
        $scope.exceptionHandling = function (event) {

            myHttpService.get(serviceList.queryApsState).then(function (response) {
                if (response.data.result == "ok") {
                    if (response.data.data.state == 0) {
                        processError(event);
                    } else {
                        notification.sendNotification("alert", "APS正在计算中，无法操作");
                    }
                } else {
                    notification.sendNotification("alert", "查询APS状态失败，请重试");
                }
            });
        };

        function processError(event) {
            var e = event || window.event;
            var target = e.target || e.srcElement;
            if (target.parentNode.tagName.toLowerCase() == "td") {
                var rowIndex = target.parentNode.parentNode.rowIndex;
                var id = document.getElementById("table_adjust").rows[rowIndex].cells[0].innerHTML;
                myHttpService.get(serviceList.processExceptionHandling + "?id=" + id).then(function successCallback(response) {
                    if (response.data.result == "ok") {
                        notification.sendNotification("confirm", "工序调整处理中...");
                    } else {
                        notification.sendNotification("alert", "请求失败");
                    }
                }, function errorCallback(response) {
                    notification.sendNotification("alert", "请求失败");
                })
            }
        }
    });