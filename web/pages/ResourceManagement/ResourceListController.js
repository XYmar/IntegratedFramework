/**
 * Created by zhaoqi on 2017/7/8.
 */
'use strict';
angular.module("IntegratedFramework.ResourceListController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/ResourceList', {
            templateUrl: 'pages/ResourceManagement/ResourceList.html',
            controller: 'ResourceListController'
        })
    }])

    .controller('ResourceListController', function ($scope, $http, myHttpService, serviceList, validate, notification, renderTableService, dispatchApsService, confirm,enter) {

        layer.load(0);
        enter.enterDown();

        var editData = {};//保存新增和修改的信息
        var addData = [];
        var edit_params = {};//获取需改后的数据
        var idVal;
        var id_params = {}; //保存选中的记录的id信息

        $(function () {
            loadRightFloatMenu();

            myHttpService.get(serviceList.ListResource).then(function (response) {
                $scope.resourceList = response.data;

                hideLoadingPage();
            });

            myHttpService.get(serviceList.ListShift).then(function (response) {
                $scope.workList = response.data;
                hideLoadingPage();
            });
        });

        //确认下发APS
        function confirmDispatchAps() {
            layer.load();
            setTimeout(function () {
                notification.sendNotification("confirm", "已下发");
                hideLoadingPage();
            }, 2000);
        }

        //取消下发APS
        function resetDispatchAps() {
            notification.sendNotification("alert", "取消下发");
        }

        //将选中记录下发APS
        $scope.dispatchRecord = function () {
            dispatchApsService.dispatchAps(confirmDispatchAps, resetDispatchAps);
        };

        //渲染checkBox样式
        $scope.renderTable = function ($last) {
            renderTableService.renderTable($last);
        };

        //信息填写检验
        var resourceAddValidate = function () {
            var params = {};
            params.name = $("input[name='add-name']").val();
            params.nameShift = $("#selectAdd option:selected").val();
            params.weekend = $("#selectAdd2 option:selected").val();
            params.rate = parseInt($("input[name='add-rate']").val());
           //params.state = $("input[name='add-state']").val();
            params.state = $("#selectState option:selected").val();
            addData = JSON.stringify(params);


            if (!validate.checkLength(params.name)) {
                $("#add-name").removeClass("has-success");
                $("#add-name").addClass("has-error");
            } else {
                $("#add-name").removeClass("has-error");
                $("#add-name").addClass(" has-success");
            }

            if (!validate.checkLength(params.nameShift)) {
                $("#add-nameShift").removeClass("has-success");
                $("#add-nameShift").addClass("has-error");
            } else {
                $("#add-nameShift").removeClass("has-error");
                $("#add-nameShift").addClass(" has-success");
            }

            if (!validate.checkNumber(params.rate) || !validate.checkLength(params.rate)) {
                $("#add-rate").removeClass("has-success");
                $("#add-rate").addClass("has-error");
            } else {
                $("#add-rate").removeClass("has-error");
                $("#add-rate").addClass(" has-success");
            }

            if (!validate.checkLength(params.weekend)) {
                $("#add-weekend").removeClass("has-success");
                $("#add-weekend").addClass("has-error");
            } else {
                $("#add-weekend").removeClass("has-error");
                $("#add-weekend").addClass(" has-success");
            }

            if (!validate.checkLength(params.state)) {
                $("#add-state").removeClass("has-success");
                $("#add-state").addClass("has-error");
            } else {
                $("#add-state").removeClass("has-error");
                $("#add-state").addClass(" has-success");
            }

            if (validate.checkLength(params.name) && validate.checkLength(params.rate) && validate.checkNumber(params.rate) &&
                validate.checkLength(params.nameShift) && validate.checkLength(params.weekend) && validate.checkLength(params.state)) {
                return true;
            } else {
                return false;
            }
        };


        //信息填写检验
        var resourceEditValidate = function () {
            var params = {};
            params.name = $("input[name='edit-name']").val();
            params.nameShift = $("#selectEdit option:selected").val();
            params.state = $("input[name='edit-state']").val();
            editData = params;

            if (!validate.checkLength(params.name)) {
                $("#edit-name").removeClass("has-success");
                $("#edit-name").addClass("has-error");
            } else {
                $("#edit-name").removeClass("has-error");
                $("#edit-name").addClass(" has-success");
            }


            if (!validate.checkLength(params.nameShift)) {
                $("#edit-nameShift").removeClass("has-success");
                $("#edit-nameShift").addClass("has-error");
            } else {
                $("#edit-nameShift").removeClass("has-error");
                $("#edit-nameShift").addClass(" has-success");
            }

          /*  if (!validate.checkNumber(params.state) || !validate.checkLength(params.state)) {
                $("#edit-state").removeClass("has-success");
                $("#edit-state").addClass("has-error");
            } else {
                $("#edit-state").removeClass("has-error");
                $("#edit-state").addClass(" has-success");
            }*/

            if (validate.checkLength(params.name) &&
                validate.checkLength(params.nameShift)) {
                return true;
            } else {
                return false;
            }
        };

        //新增订单
        $scope.addResource = function () {
            if (resourceAddValidate()) {
                $("#modal-add").modal('hide');
                myHttpService.post(serviceList.AddResource, addData).then(function successCallback() {
                    myHttpService.get(serviceList.ListResource).then(function (response) {
                        $scope.resourceList = response.data;
                        notification.sendNotification("confirm", "添加成功");
                    })
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                notification.sendNotification("alert", "输入有误");
            }
        };

        //获得表单信息
        var getInfo = function () {
            $("div").removeClass("has-error");
            $("div").removeClass("has-success");
            if (hasCheckRows()) {
                var a = document.getElementsByName("check");
                var row = 1;
                for (var i = 0; i < a.length; i++) {
                    if (a[i].checked) {
                        idVal = $("#table_value").find("tr").eq(row).find("td").eq(1).html();
                        id_params.id = idVal;
                    }
                    row++;
                }
                return true;
            } else {
                notification.sendNotification("alert", "请重新选择！");
                return false;
            }
        };


        //修改订单
        $scope.update = function () {
            if (getInfo()) {
                $("#modal-edit").modal('show');
                /*var temps = id_params.idR;
                delete(id_params.idR);
                id_params.id = temps;*/
                var idInfo = JSON.stringify(id_params);
                myHttpService.post(serviceList.GetResourceById, idInfo).then(function successCallback(response) {
                    var editList = [];//保存从数据库获取的需要修改的数据
                    editList.push(response.data);
                    console.log(editList);
                    edit_params = response.data;
                    $scope.editList = editList;
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                $("#modal-edit").modal('hide');
            }
        };

        $scope.editResource = function () {
            if (confirm.confirmEdit()) {
                if (resourceEditValidate()) {
                    $("#modal-edit").modal('hide');
                    //用获取到的数据代替从数据库取到的数据
                    edit_params.name = editData.name;
                    edit_params.nameShift = editData.nameShift;
                    edit_params.state = editData.state;
                    var update_data = angular.toJson(edit_params);
                    console.log(update_data);
                    myHttpService.post(serviceList.UpdateResource, update_data).then(function successCallback() {
                        myHttpService.get(serviceList.ListResource).then(function (response) {
                            $scope.resourceList = response.data;
                            notification.sendNotification("confirm", "修改成功");
                        })
                    }, function errorCallback() {
                        notification.sendNotification("alert", "请求失败");
                    })
                } else {
                    notification.sendNotification("alert", "输入有误");
                }
            }
        };


        //删除订单
        $scope.deleteResource = function () {
            if (getInfo()) {
                if (confirm.confirmDel()) {
                    var params = {};
                    params.idR = idVal;
                    var idInfo = JSON.stringify(params);
                    myHttpService.delete(serviceList.DeleteResource, idInfo).then(function successCallback() {
                        myHttpService.get(serviceList.ListResource).then(function (response) {
                            $scope.resourceList = response.data;
                            notification.sendNotification("confirm", "删除成功");
                        })
                    }, function errorCallback() {
                        notification.sendNotification("alert", "请求失败");
                    });
                }
            }
        };

        $scope.reset = function () {
            $("input").val('');
            $("div").removeClass("has-error");
            $("div").removeClass("has-success");
        }
    });