/**
 * Created by hanchangming on 2017/5/15.
 */
'use strict';
angular.module("IntegratedFramework", [
    'ngRoute',
    'IntegratedFramework.OrderManagementController',
    'IntegratedFramework.ResourceDistributionController',
    'IntegratedFramework.BOMManagementController',
    'IntegratedFramework.ResourceListController',
    'IntegratedFramework.ResourceGroupController',
    'IntegratedFramework.ResourceClassifyController',
    'IntegratedFramework.ResourceStationController',
    'IntegratedFramework.WorkListController',
    'IntegratedFramework.ScheduleSnapController',
    'IntegratedFramework.PlanScheduleController',
    'IntegratedFramework.InteractiveController',
    'IntegratedFramework.ShowController',
    'IntegratedFramework.EquipmentMonitoringController',
    'IntegratedFramework.MainPage',
    'IntegratedFramework.BOMManagementController',
    'IntegratedFramework.AdjustProcedureController',
    'IntegratedFramework.AdjustOrderController',
    'IntegratedFramework.AdjustFactoryController',
    'IntegratedFramework.AdjustDeviceController',
    'IntegratedFramework.FactoryLayoutController',
    'IntegratedFramework.OnlineOrderController'
])
    .config(['$routeProvider', function ($routeProvider, $locationProvider) {
        //     // $locationProvider.hashPrefix('!');
        $routeProvider.otherwise("/MainPage");
    }])
    .config(['$httpProvider', function ($httpProvider) {
        /*$httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded';
         $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';*/
    }])
    .factory("myHttpService", ['$http', function ($http) {
        var service = {};
        var _get = function (servletUrl) {
            return $http({
                'method': 'get',
                'dataType': 'json',
                'url': servletUrl,
                'headers': {
                    'Content-Type': 'application/json;charset=utf-8',
                }
            })
        };
        var _post = function (servletUrl, body) {
            return $http({
                'method': 'post',
                'dataType': 'json',
                'url': servletUrl,
                'data': body,
                'headers': {
                    'Content-Type': 'application/json;charset=utf-8',
                }
            })
        };
        var _delete = function (servletUrl, body) {
            return $http({
                'method': 'delete',
                'dataType': 'json',
                'url': servletUrl,
                'data': body,
                'headers': {
                    'Content-Type': 'application/json;charset=utf-8',
                }
            })
        };
        service.get = _get;
        service.post = _post;
        service.delete = _delete;
        return service;
    }])

    .factory("notification", function () {
        var service = {};
        var notyf = null;
        service.sendNotification = function (notificationType, message) {
            if (notyf == null) {
                notyf = new Notyf();
            }

            if (notificationType === "alert") {
                notyf.alert(message);
            }
            if (notificationType === "confirm") {
                notyf.confirm(message);
            }
        };
        return service;
    })

    .factory("serviceList", function () {
        var service = {};
        var backUrl = "";
        <!--订单信息-->
        service.ListOrder = backUrl + "orders/getAllOrders.action";

        service.DeleteOrder = backUrl + "orders/delete.action";
        service.UpdateOrder = backUrl + "orders/update.action";
        service.AddOrder = backUrl + "orders/save.action";

        service.GetOrderById = backUrl + "orders/findAllById.action";

        service.GetOrderByState = backUrl + "orders/findByState.action";


        <!--订单监控-->
        service.ComListOrder = backUrl + "online/findByState.action";


        <!--工序信息-->
        service.ListProcess = backUrl + "process/getAllByIsRootNode.action";
        <!--工序资源信息-->
        service.ListAssisantProcess = backUrl + "assisantprocess/getAllAssisantProcess.action";
        service.DeleteAssisantProcess = backUrl + "assisantprocess/delete.action";
        service.UpdateAssisantProcess = backUrl + "assisantprocess/update.action";
        service.AddAssisantProcess = backUrl + "assisantprocess/save.action";
        service.GetAssisantProcessById = backUrl + "assisantprocess/findAllById.action";
        <!--资源信息-->
        service.ListResource = backUrl + "resource/getAllResource.action";
        service.DeleteResource = backUrl + "resource/delete.action";
        service.UpdateResource = backUrl + "resource/update.action";
        service.AddResource = backUrl + "resource/save.action";
        service.GetResourceById = backUrl + "resource/findAllById.action";
        <!--资源类型信息-->
        service.ListTypeRecource = backUrl + "typerescource/getAllTypeRescource.action";
        service.DeleteTypeResource = backUrl + "typerescource/delete.action";
        service.UpdateTypeResource = backUrl + "typerescource/update.action";
        service.AddTypeResource = backUrl + "typerescource/save.action";
        service.GetTypeResourceById = backUrl + "typerescource/findAllById.action";
        <!--资源工组信息-->
        service.ListGroupResource = backUrl + "groupresource/getAllGroupResource.action";
        service.DeleteGroupResource = backUrl + "groupresource/delete.action";
        service.UpdateGroupResource = backUrl + "groupresource/update.action";
        service.AddGroupResource = backUrl + "groupresource/save.action";
        service.GetGroupResourceById = backUrl + "groupresource/findAllById.action";
        <!--资源工位信息-->
        service.ListSite = backUrl + "site/getAllSite.action";
        service.DeleteSite = backUrl + "site/delete.action";
        service.UpdateSite = backUrl + "site/update.action";
        service.AddSite = backUrl + "site/save.action";
        service.GetSiteById = backUrl + "site/findAllById.action";
        <!--资源班次信息-->
        service.ListShift = backUrl + "shift/getAllShift.action";
        service.DeleteShift = backUrl + "shift/delete.action";
        service.UpdateShift = backUrl + "shift/update.action";
        service.AddShift = backUrl + "shift/save.action";
        service.GetShiftById = backUrl + "shift/findAllById.action";
        service.saveAPS = backUrl + "shift/saveAPS.action";
        <!--3D信息-->
        service.query3DState = backUrl + "3d/query3DState.action";
        service.config3D = backUrl + "3d/config3D.action";
        service.set3DLayout = backUrl + "3d/set3DLayout.action";
        service.get3DReport = backUrl + "3d/get3DReport.action";
        <!--工厂布局-->
        service.ListFactoryLayout = backUrl + "3d/getAllFactoryLayouts.action";
        service.LayoutDetail = backUrl + "3d/findAllById.action";
        <!--排程信息-->
        service.beginSchedule = backUrl + "schedule/beginSchedule.action";
        service.ListSchedule = backUrl + "schedule/getAllSchedules.action";
        service.DeleteSchedule = backUrl + "schedule/delete.action";
        service.autoRolling = backUrl + "schedule/autoRollingScheduling.action";
        service.getLastScheduleInfo = backUrl + "FullCalendar/getLastScheduleInfo.action";
        service.CurInfo = backUrl + "orders/findAllByisFinishedAndDate.action";
        <!--工序信息接口-->
        service.isRootNode = backUrl + "process/getAllByIsRootNode.action";
        service.isChildNode = backUrl + "process/getAllById.action";

        <!--快照信息-->
        service.isRootLevel = backUrl + "snapshot/getAllByLevel.action";
        service.getTree = backUrl + "snapshot/getAllById.action";
        service.view3DEmulate = backUrl + "snapshot/view3DEmulate.action";
        service.dispatchMes = backUrl + "snapshot/dispatcherResultToMess.action";
        service.getAllPlan = backUrl + "plan/getAllPlanBySnapshotId.action";
        service.getAllResult = backUrl + "plan/getAllResultBySnapshotId.action";
        service.getAllRate = backUrl + "plan/fingRateById.action";

        <!--高级调整分析-->
        service.AdjustProcess = backUrl + "ExceptionList/getAllAdjustProcessException.action";
        service.AdjustOrder = backUrl + "ExceptionList/getAllAdjustOrderException.action";
        service.getALLAdjustOrderByType = backUrl + "ExceptionList/getAllAdjustOrderByAdjustOrderType.action";

        <!--异常状态-->
        service.AddAdjustOrder = backUrl + "ExceptionSimulat/creatOrderException.action";
        service.AddAdjustProcess = backUrl + "ExceptionSimulat/creatProcessException.action";

        <!--异常处理-->
        service.deviceProcessHandling = backUrl + "exceptionHandling/deviceProcessHandling.action";
        service.orderExceptionHandling = backUrl + "exceptionHandling/orderExceptionHandling.action";
        service.processExceptionHandling = backUrl + "exceptionHandling/processExceptionHandling.action";

        service.getAllAdjustDeviceException = backUrl + "ExceptionList/getAllAdjustDeviceException.action";
        service.getAllAdjustLayoutException = backUrl + "ExceptionList/getAllAdjustLayoutException.action";
        service.getAllLayout = backUrl + "layout/get3DLayout.action";

        service.queryApsState = backUrl + "aps/apsState.action";
        service.currSheduleInfo = backUrl + "aps/scheduleDetail.action";
        service.emulateApsInterResult = backUrl + "aps/emulateApsInterResult.action";

        service.switchModel = backUrl + "aps/switchAPSModel.action";

        //获取异常数量接口
        service.findAllExceptionUrl = backUrl + "mainpage/getAllExcepitonNumInfo.action";
        //获取EvenLog接口
        service.getAllEventLogUrl = backUrl + "eventlog/getAllEventLog.action";

        <!--恢复快照-->
        service.recoverSnapshot = backUrl + "snapshot/recoverSnapshot.action";
        service.queryRecoverSnapshot = backUrl + "snapshot/queryRecoverSnapshot.action";

        <!-- MES接口 -->
        service.CarryInfoList = backUrl + "mes/getAllCarrys.action";
        service.getAllCarrysByFirstResultAndMaxResults = backUrl + "mes/getAllCarrysByFirstResultAndMaxResults.action";
        service.AssemblyCarryInfoList = backUrl + "mes/getAllAssemblyCarrys.action";
        service.getAllAssemblyCarrysByFirstResultAndMaxResults = backUrl + "mes/getAllAssemblyCarrysByFirstResultAndMaxResults.action";
        service.AssemblyCenterInfoList = backUrl + "mes/getAllAssemblyCenters.action";
        service.getAllAssemblyCentersByFirstResultAndMaxResults = backUrl + "mes/getAllAssemblyCentersByFirstResultAndMaxResults.action";
        service.DeportInfoList = backUrl + "mes/getAllById.action";
        service.AllDeportInfoList = backUrl + "mes/getAllDeportInfo.action";
        service.AllAGVInfoList = backUrl + "mes/getAllAGVInfo.action";

        //撤销资源
        service.CancelResource = backUrl + "exceptionHandling/cancelResource.action";
        //恢复资源
        service.ResumeResource = backUrl + "exceptionHandling/resumeResource.action";


        return service;
    })
    .factory("renderTableService", function () {
        var service = {};

        //渲染checkBox样式
        service.renderTable = function ($last) {
            if ($last) {
                //Enable iCheck plugin for checkboxes
                //iCheck for checkbox and radio inputs
                $('.mailbox-messages input[type="checkbox"]').iCheck({
                    checkboxClass: 'icheckbox_flat-blue',
                    radioClass: 'iradio_flat-blue'
                });

                //Enable check and uncheck all functionality
                $(".checkbox-toggle").click(function () {
                    var clicks = $(this).data('clicks');
                    if (clicks) {
                        //Uncheck all checkboxes
                        $(".mailbox-messages input[type='checkbox']").iCheck("uncheck");
                        $(".fa", this).removeClass("fa-check-square-o").addClass('fa-square-o');
                    } else {
                        //Check all checkboxes
                        $(".mailbox-messages input[type='checkbox']").iCheck("check");
                        $(".fa", this).removeClass("fa-square-o").addClass('fa-check-square-o');
                    }
                    $(this).data("clicks", !clicks);
                });
            }
        };

        return service;
    })
    .factory("validate", function () {
        var service = {};
        service.checkString = function (s) {
            var SRegexp = /^[A-Za-z]+$/;
            if (!SRegexp.test(s)) {

                return false;
            }
            return true;
        };

        service.checkNumber = function (n) {
            var NRegexp = /^[0-9]*$/;
            if (!NRegexp.test(n)) {

                return false;
            }
            return true;
        };

        service.checkLength = function (l) {
            if (l == "") {

                return false;
            }
            return true;
        };

        service.checkChinese = function (c) {
            var CRegexp = /[^\u0000-\u00FF]/;
            if (!CRegexp.test(c)) {

                return false;
            }
            return true;
        };

        service.checkTime = function(t) {
            //var TRegexp = /\d{2}:\d{2}:\d{2}$/;
            var TRegexp = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/;
            if (!TRegexp.test(t)) {
                return false;
            }
            return true;
        };

        return service;
    })
    .factory("dispatchApsService", ['notification', function (notification) {
        var service = {};
        service.dispatchAps = function (confirmDispatchAps, resetDispatchAps) {
            if (hasCheckRows()) {
                layer.confirm('将选中数据下发APS？', {
                    btn: ['下发', '取消'] //按钮
                }, function () {
                    layer.closeAll('dialog');
                    confirmDispatchAps();
                }, function () {
                    resetDispatchAps();
                });
            } else {
                notification.sendNotification("alert", "请选择一条记录！");
            }
        };
        return service;
    }])
    .factory("dateService", function (notification) {
        var service = {};
        service.getCurrDate = function () {
            var date = new Date();
            var seperator1 = "-";
            var seperator2 = ":";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                + " " + date.getHours() + seperator2 + date.getMinutes()
                + seperator2 + date.getSeconds();
            return currentdate;
        };

        service.formatDateTime = function (time) {
            var date = new Date(time);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? ('0' + m) : m;
            var d = date.getDate();
            d = d < 10 ? ('0' + d) : d;
            var h = date.getHours();
            h = h < 10 ? ('0' + h) : h;
            var minute = date.getMinutes();
            var second = date.getSeconds();
            minute = minute < 10 ? ('0' + minute) : minute;
            second = second < 10 ? ('0' + second) : second;
            return y + '-' + m + '-' + d + ' ' + h + ':' + minute + ':' + second;
        };

        //比较时间
        service.compareTime = function (startDate, endDate) {
            if (startDate.length > 0 && endDate.length > 0) {
                var startDateTemp = startDate.split(" ");
                var endDateTemp = endDate.split(" ");

                var arrStartDate = startDateTemp[0].split("-");
                var arrEndDate = endDateTemp[0].split("-");

                var arrStartTime = startDateTemp[1].split(":");
                var arrEndTime = endDateTemp[1].split(":");
                var allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], arrStartTime[0], arrStartTime[1], arrStartTime[2]);
                var allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], arrEndTime[0], arrEndTime[1], arrEndTime[2]);

                if (allStartDate.getTime() >= allEndDate.getTime()) {
                    return false;
                } else {
                    return true;
                }
            } else {
                return false;
            }
            return false;
        };

        return service;
    })
    .factory("confirm", function () {
        var service = {};
        //确认修改

        service.confirmEdit = function () {
            var msg = "确定要修改吗？";
            if (confirm(msg) == true) {
                return true;
            } else {
                return false;
            }
        };
        //确认删除
        service.confirmDel = function () {
            var msg = "确定要删除吗？";
            if (confirm(msg) == true) {
                return true;
            } else {
                return false;
            }
        };

        return service;
    })

    .factory("enter", function () {
        var service = {};
        service.enterDown = function () {
            document.onkeydown = keyDownSearch;

            function keyDownSearch(e) {
                // 兼容FF和IE和Opera
                var theEvent = e || window.event;
                var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
                if (code == 13) {

                    return false;
                }
                return true;
            }
        };
        return service;
    });

