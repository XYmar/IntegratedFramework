/**
 * Created by zhaoqi on 2017/7/8.
 */
'use strict';
angular.module("IntegratedFramework.WorkListController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/WorkList', {
            templateUrl: 'pages/ResourceManagement/WorkList.html',
            controller: 'WorkListController'
        })
    }])

    .controller('WorkListController', function ($scope, $http, myHttpService, serviceList, validate, notification, confirm, renderTableService, dispatchApsService,enter) {

        layer.load(0);
        enter.enterDown();

        var editData = {};//保存新增和修改的信息
        var addData = [];
        var edit_params = {};//获取需改后的数据
        var idVal;
        var id_params = {}; //保存选中的记录的id信息
        var slot;

        //Timepicker
        /*$('.timepicker').timepicker({
            showInputs: false
        });*/
        /*laydate.render({
            elem: '#modal-add-slot1-timepicker', //指定元素
            type: 'time'
        });
        laydate.render({
            elem: '#modal-add-slot2-timepicker', //指定元素
            type: 'time'
        });*/

        $(function () {
            loadRightFloatMenu();

            myHttpService.get(serviceList.ListShift).then(function (response) {
                $scope.workList = response.data;

                hideLoadingPage();
            });
        });

        //确认下发APS
        function confirmDispatchAps() {
            layer.load();
            if (getInfo()) {
                var params = {};
                params.id = idVal;
                var idInfo = JSON.stringify(params);

                myHttpService.post(serviceList.saveAPS,idInfo).then(function successCallback() {
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                });

                setTimeout(function () {
                    notification.sendNotification("confirm", "已下发");
                    hideLoadingPage();
                }, 2000);
            }

        };

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

        /*$("#select").change(function () {

         slot = $(this).children('option:selected').val();

         });*/

        function StringBuffer() {
            this.__strings__ = [];
        }

        StringBuffer.prototype.append = function (str) {
            this.__strings__.push(str);
            return this;    //方便链式操作
        };

        StringBuffer.prototype.toString = function () {
            return this.__strings__.join("");
        };

        //信息填写检验
        var workAddValidate;
        workAddValidate = function () {
            var params = {};
            params.name = $("input[name='add-name']").val();
            params.type = $("input[name='add-type']").val();
            /*var slot1 = $("input[id='modal-add-slot1']").val();
             var slot2 = $("input[id='modal-add-slot2']").val();

             var slot3 = new StringBuffer();
             slot3.append(moment(slot1).format("hh:mm")).append("--").append(moment(slot2).format("hh:mm"));
             params.slot = slot3.toString();
             console.log(params.slot);*/

            //加班 去掉
            /*params.extra = parseInt($("input[name='add-extra']").val());*/
            addData = JSON.stringify(params);
            /*if (!validate.checkString(params.name) || !validate.checkLength(params.name)) {
                $("#add-name").removeClass(" has-success");
                $("#add-name").addClass(" has-error");
            } else {
                $("#add-name").removeClass(" has-error");
                $("#add-name").addClass(" has-success");
            }*/

            /*if (!validate.checkLength(slot1)) {
             $("#add-slot1").removeClass("has-success");
             $("#add-slot1").addClass("has-error");
             } else {
             $("#add-slot1").removeClass("has-error");
             $("#add-slot1").addClass(" has-success");
             }

             if (!validate.checkLength(slot2)) {
             $("#add-slot2").removeClass("has-success");
             $("#add-slot2").addClass("has-error");
             } else {
             $("#add-slot2").removeClass("has-error");
             $("#add-slot2").addClass(" has-success");
             }*/

            if (!validate.checkTime(slot1)) {
                $("#add-slot1").removeClass("has-success");
                $("#add-slot1").addClass("has-error");
            } else {
                $("#add-slot1").removeClass("has-error");
                $("#add-slot1").addClass(" has-success");
            }

            if (!validate.checkTime(slot2)) {
                $("#add-slot2").removeClass("has-success");
                $("#add-slot2").addClass("has-error");
            } else {
                $("#add-slot2").removeClass("has-error");
                $("#add-slot2").addClass(" has-success");
            }

            // validate.checkLength(params.name) && validate.checkString(params.name)&&validate.checkLength(params.extra) && validate.checkNumber(params.extra)
            if (validate.checkTime(params.slot1) && validate.checkTime(params.slot2)) {
                return true;
            } else {

                return false;
            }
        };

        //班次添加判断
        var workAddValidate = function () {
            var slot1 = document.getElementById("modal-add-slot1-timepicker").value;
            var slot2 = document.getElementById("modal-add-slot2-timepicker").value;

            if (!validate.checkTime(slot1)) {
                $("#add-slot1").removeClass("has-success");
                $("#add-slot1").addClass("has-error");
            } else {
                $("#add-slot1").removeClass("has-error");
                $("#add-slot1").addClass(" has-success");
            }

            if (!validate.checkTime(slot2)) {
                $("#add-slot2").removeClass("has-success");
                $("#add-slot2").addClass("has-error");
            } else {
                $("#add-slot2").removeClass("has-error");
                $("#add-slot2").addClass(" has-success");
            }

            if (validate.checkTime(slot1) && validate.checkTime(slot2)) {
                return true;
            } else {

                return false;
            }
        };

        //添加新班次
        $scope.addNewWork = function () {
            if(workAddValidate()){
                var slot1 = document.getElementById("modal-add-slot1-timepicker").value;
                var slot2 = document.getElementById("modal-add-slot2-timepicker").value;

                var opt = document.createElement("option");
                opt.value = "{" + slot1 + ".." + slot2 + "}";
                opt.innerHTML = "{" + slot1 + ".." + slot2 + "}";

                document.getElementById("addWorkList").appendChild(opt);
            }else {
                notification.sendNotification("alert", "参数错误");
            }

            /*var slot1 = document.getElementById("modal-add-slot1-timepicker").value;
            var slot2 = document.getElementById("modal-add-slot2-timepicker").value;*/



        };
        //删除班次
        $scope.deleWork = function () {
            var dele = document.getElementById("addWorkList");
            var index = dele.selectedIndex;
            dele.options.remove(index);
        }
        ;
      /*  $scope.addNewWorkInfo = function () {
            var workList = document.getElementById("addWorkList");
            var workStr = [];
            for (var i = 0; i < workList.length; i++) {
                workStr[i] = workList[i].text;
            }
            var form = document.getElementById("addWorkList");
            var elements = {};
            elements.name = document.getElementById("workName").value;
            elements.workInfo = workStr;
            elements[2] = document.getElementById("workExtra").value;
            console.log(elements);
            $("#modal-add").modal('hide');
            myHttpService.post(serviceList.AddShift, elements).then(function successCallback() {
                //用强制刷新解决按钮不能连续响应
                location.reload();
            }, function errorCallback() {
                notification.sendNotification("alert", "请求失败");
            })
        }*/

      //弹框添加判断
        var workNewAddValidate = function () {
            var workList = document.getElementById("addWorkList");
            var workStr = [];
            for (var i = 0; i < workList.length; i++) {
                workStr[i] = workList[i].text;
            }

            var form = document.getElementById("addWorkList");
            var elements = {};
            elements.name = document.getElementById("workName").value;
            elements.time1 = document.getElementById("")
            elements.slot = workStr.join(",");
            //elements.extra = document.getElementById("workExtra").value;

            addData = JSON.stringify(elements);
            /*if (!validate.checkString(elements.name) || !validate.checkLength(elements.name)) {
                $("#add-name").removeClass(" has-success");
                $("#add-name").addClass(" has-error");
            } else {
                $("#add-name").removeClass(" has-error");
                $("#add-name").addClass(" has-success");
            }*/

            //&&validate.checkLength(elements.extra) && validate.checkNumber(elements.extra)
            /*if (validate.checkLength(elements.name) && validate.checkString(elements.name) ) {*/
                return true;
            /*} else {

                return false;
            }*/
        };

        //弹框添加
        $scope.addNewWorkInfo = function () {
            if (workNewAddValidate()) {
                $("#modal-add").modal('hide');
                console.log(addData);

                myHttpService.post(serviceList.AddShift, addData).then(function successCallback() {
                    myHttpService.get(serviceList.ListShift).then(function (response) {
                        $scope.workList = response.data;
                    });
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                notification.sendNotification("alert", "参数错误");
            }
            //addData.splice(0, addData.length);
        };
        //信息填写检验
        var workEditValidate = function () {
            var params = {};
            params.name = $("input[name='edit-name']").val();
            /*params.slot = $("input[name='edit-slot']").val();*/
            params.slot = slot;
            //params.extra = parseInt($("input[name='edit-extra']").val());
            editData = params;

            if (!validate.checkString(params.name) || !validate.checkLength(params.name)) {
                $("#edit-name").removeClass(" has-success");
                $("#edit-name").addClass(" has-error");
            } else {
                $("#edit-name").removeClass(" has-error");
                $("#edit-name").addClass(" has-success");
            }


            /*if (!validate.checkNumber(params.extra) || !validate.checkLength(params.extra)) {
                $("#edit-extra").removeClass("has-success");
                $("#edit-extra").addClass("has-error");
            } else {
                $("#edit-extra").removeClass("has-error");
                $("#edit-extra").addClass(" has-success");
            }*/

            if (validate.checkLength(params.name) && validate.checkString(params.name)
                /* && validate.checkLength(params.slot) && validate.checkNumber(params.slot) && validate.checkLength(params.extra) && validate.checkNumber(params.extra)*/) {
                return true;
            } else {

                return false;
            }
        };

        //新增订单
        /*$scope.addWork = function () {
            if (workAddValidate()) {
                $("#modal-add").modal('hide');
                console.log(addData);
                myHttpService.post(serviceList.AddShift, addData).then(function successCallback() {
                    //用强制刷新解决按钮不能连续响应
                    location.reload();
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                notification.sendNotification("alert", "参数错误");
            }
            //addData.splice(0, addData.length);
        };*/

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
                var idInfo = JSON.stringify(id_params);
                myHttpService.post(serviceList.GetShiftById, idInfo).then(function successCallback(response) {
                    var editList = [];//保存从数据库获取的需要修改的数据
                    editList.push(response.data);
                    edit_params = response.data;
                    $scope.editList = editList;
                }, function errorCallback(response) {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                $("#modal-edit").modal('hide');
            }
        };

        $scope.editWork = function () {
            if (workEditValidate()) {
                $("#modal-edit").modal('hide');
                //用获取到的数据代替从数据库取到的数据
                edit_params.name = editData.name;
                edit_params.type = editData.type;
                edit_params.slot = editData.slot;
                //edit_params.extra = editData.extra;
                var update_data = angular.toJson(edit_params);
                myHttpService.post(serviceList.UpdateShift, update_data).then(function successCallback() {
                    location.reload();
                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })
            } else {
                notification.sendNotification("alert", "输入有误");
            }
        };


        //删除订单
        $scope.deleteWork = function () {
            if (getInfo()) {
                if (confirm.confirmDel()) {
                    var params = {};
                    params.id = idVal;
                    var idInfo = JSON.stringify(params);
                    console.log("删除的id信息");
                    console.log(idInfo);
                    myHttpService.delete(serviceList.DeleteShift, idInfo).then(function successCallback() {
                        myHttpService.get(serviceList.ListShift).then(function (response) {
                            $scope.workList = response.data;
                        });
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