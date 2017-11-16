/**
 * Created by XY on 2017/7/6.
 */
'use strict';
angular.module("IntegratedFramework.ScheduleSnapController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/ScheduleSnap', {
            templateUrl: 'pages/PlanSchedule/ScheduleSnap.html',
            controller: 'ScheduleSnapController'
        })
    }])

    .controller('ScheduleSnapController', function ($scope, $location, $http, myHttpService, serviceList, notification) {

        layer.load(0);

        var zNodes = [];
        var idVal;//所点击的节点id值
        var rootData = [];
        var treeInfo = [];
        var queryApsRecoverBackupTime = 0;          //定时查询aps恢复快照的状态
        var hasReciveSnapshotFlag = false;

        var selectedCheckArray = []; //选中的checkbox的id值集合

        var PageInfo = {};
        PageInfo.selectedIndex = [];     //每个页面中保存选择的索引
        PageInfo.data = [];              //每个页面对应的数据信息，只加载一次

        var pageCount = 0;              //分页有关
        var currPage = 0;
        var pageTipCount = 0;

        var idSch;                    //快照第一页所选排程
        var bottomInfo = [];         //底层节点

        var snaps = [];              //存放快照的id
        var idS;

        var selsnap = {};

        $(function () {
            //初始化下拉数据
            $(".select2").select2();

            var dataTrue = {"level": "top"};
            myHttpService.post(serviceList.isRootLevel, dataTrue).then(function successCallback(response) {
                rootData = response.data;
                $scope.dataArr = response.data;

                loadRightFloatMenu();
                hideLoadingPage();
            });
            $scope.hasDispatchMes = false;
            $scope.interactiveCount = "";

            $scope.detail = true;


            //快照对比页
            pageCount = $(".MyPage").size();

            for (var i = 0; i < pageCount; i++) {
                PageInfo.selectedIndex[i] = [];
                PageInfo.data[i] = [];
            }

            resetContent();

            $(".MyPageTip").each(function () {
                $(this).css("width", 1 / pageTipCount * 100 + "%");
            });
            $("#tipHover").css("width", 1 / pageTipCount * 100 + "%");

           // $("#nextStep").attr("disabled", true);

            myHttpService.get(serviceList.ListSchedule).then(function (response) {
                $scope.scheduleList = response.data;
                hideLoadingPage();
            });
        });

        //3D车间查看转换结果
        $scope.viewIn3DFactory = function () {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            if (zTree.getSelectedNodes().length == 1 && zTree.getSelectedNodes()[0].level == 2) {
                layer.load();
                myHttpService.get(serviceList.view3DEmulate + "?id=" + zTree.getSelectedNodes()[0].id).then(function success(response) {
                    if (response.data.result == "ok") {
                        notification.sendNotification("confirm", "数据转换成功,3D车间启动中...");
                        setTimeout(function () {
                            window.open('WebGL/index.html', '_blank');
                            // layer.open({
                            //     type: 2,
                            //     title: '3D车间',
                            //     maxmin: true,
                            //     shadeClose: true,
                            //     shade: false,
                            //     offset: 'l',
                            //     area: ['100%', '100%'],
                            //     content: "http://localhost:8080/WebGL"
                            // });
                        }, 1500);
                    } else {
                        notification.sendNotification("alert", "数据转换失败");
                    }
                    hideLoadingPage();
                });
            } else {
                notification.sendNotification("alert", "未选择节点信息");
            }
        };

        //将选中结果下发MES
        $scope.dispatchMes = function () {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");

            if (zTree.getSelectedNodes().length == 1 && zTree.getSelectedNodes()[0].level == 2) {

                var selectedNode = zTree.getSelectedNodes()[0];

                layer.confirm('是否将结果下发MES?', {
                    btn: ['确定', '取消'] //按钮
                }, function (index) {
                    layer.load();

                    myHttpService.get(serviceList.queryApsState).then(function (response) {
                        if (response.data.result == "ok") {
                            if (response.data.data.state == 0) {
                                myHttpService.get(serviceList.dispatchMes + "?id=" + selectedNode.id).then(function success(response) {
                                    if (response.data.result == "ok") {
                                        $scope.hasDispatchMes = true;
                                        $scope.messStatus = "已下发";

                                        var pnode = selectedNode.getParentNode();
                                        pnode.dispatchMesTime = new Date().getTime();
                                        pnode.apply = true;
                                        selectedNode.dispatchMesTime = new Date().getTime();
                                        selectedNode.apply = true;
                                        selectedNode.icon = "images/bom_img/dispatchNode.png";
                                        $scope.dispatchMesTime = pnode.dispatchMesTime;

                                        zTree.refresh();

                                        //TODO 待增加对当前树节点数据的重新加载，以刷新显示
                                        notification.sendNotification("confirm", "下发MES成功");
                                    } else {
                                        notification.sendNotification("alert", "下发MES失败");
                                    }
                                    hideLoadingPage();
                                }, function error() {
                                    notification.sendNotification("alert", "请求失败，稍后再试");
                                    hideLoadingPage();
                                });
                            } else {
                                notification.sendNotification("alert", "查询APS状态失败");
                                hideLoadingPage();
                            }
                        } else {
                            notification.sendNotification("alert", "查询APS状态失败");
                            hideLoadingPage();
                        }
                    }, function () {
                        hideLoadingPage();
                    });

                    layer.close(index);
                }, function (index) {
                    layer.close(index);
                    notification.sendNotification("alert", "取消下发");
                });
            } else {
                notification.sendNotification("alert", "请选择正确的节点");
            }
        };

        //对当前节点进行交互优化，先查询APS的状态是否空闲,interactiveFlag用于表示是否需要页面跳转至交互页面
        $scope.interactiveNode = function (interactiveFlag) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            if (zTree != null && zTree.getSelectedNodes().length == 1 && zTree.getSelectedNodes()[0].level == 2) {

                layer.confirm(interactiveFlag ? '是否优化当前节点?' : '是否恢复此快照?', {
                    btn: ['确定', '取消'] //按钮
                }, function (index) {
                    layer.load();
                    //查询APS的state
                    myHttpService.get(serviceList.queryApsState).then(function (response) {
                        if (response.data.result == "ok") {
                            if (response.data.data.state == 0) {
                                var selectedNode = zTree.getSelectedNodes()[0];
                                //恢复指定快照
                                myHttpService.get(serviceList.recoverSnapshot + "?id=" + selectedNode.id).then(function (response) {
                                    notification.sendNotification("confirm", "恢复APS快照中...");
                                    queryApsRecoverBackupTime = 0;
                                    hasReciveSnapshotFlag = false;

                                    //定时查询当前节点快照是否恢复，最多查询10次
                                    var interFlag = setInterval(function () {

                                        //查询对应节点的恢复状态
                                        myHttpService.get(serviceList.queryRecoverSnapshot + "?id=" + selectedNode.id).then(function (response) {
                                            if (response.data.result == "ok") {
                                                hasReciveSnapshotFlag = true;
                                                hideLoadingPage();
                                                clearInterval(interFlag);
                                                if (interactiveFlag) {
                                                    notification.sendNotification("confirm", "交互优化页面跳转中...");
                                                    setTimeout(function () {
                                                        //TODO 待解决path不能直接用$location跳转问题
                                                        $location.path('/Interactive');
                                                        window.location.href = $location.absUrl();
                                                    }, 1200);
                                                }
                                            }
                                        }, function (response) {

                                        });

                                        if (queryApsRecoverBackupTime >= 10 && !hasReciveSnapshotFlag) {
                                            notification.sendNotification("alert", "APS快照恢复失败...");
                                            hideLoadingPage();
                                            clearInterval(interFlag);
                                        }
                                        queryApsRecoverBackupTime++;

                                    }, 1000);
                                }, function (response) {
                                    notification.sendNotification("alert", "快照请求恢复失败...");
                                    hideLoadingPage();
                                });
                            } else {
                                notification.sendNotification("alert", "查询APS状态失败");
                                hideLoadingPage();
                            }
                        } else {
                            notification.sendNotification("alert", "查询APS状态失败，请重试!");
                            hideLoadingPage();
                        }
                    }, function (response) {
                        hideLoadingPage();
                    });
                    layer.close(index);
                }, function (index) {
                    layer.close(index);
                    notification.sendNotification("alert", "取消下发");
                });

            } else {
                notification.sendNotification("alert", "请选择正确的节点");
            }
        };

        //对快照节点排序
        function sortSnapshot(childList) {
            for (var i = 0; i < childList.length; i++) {
                for (var j = i + 1; j < childList.length; j++) {
                    if (childList[j].nodeCreateTime < childList[i].nodeCreateTime) {
                        var tmp = childList[j];
                        childList[j] = childList[i];
                        childList[i] = tmp;
                    }
                }
            }
        }

        //下拉框事件改变
        $("#select").change(function () {

            $scope.hasDispatchMes = false;
            $scope.messStatus = "--";

            zNodes.splice(0, zNodes.length);
            var idRoot;
            var val = $(this).children('option:selected').val();
            if (val.length > 0) {
                for (var i = 0; i < rootData.length; i++) {
                    if (rootData[i].name == val) {
                        idRoot = rootData[i].id;
                        break;
                    }
                }
                var params = {};
                params.id = idRoot;
                var id = JSON.stringify(params);

                layer.load();

                myHttpService.post(serviceList.getTree, id).then(function successCallback(response) {
                    $scope.snapShotData = response.data;
                    var datas = response.data;

                    if (datas.hasOwnProperty("childs")) {
                        var middleNodeList = datas.childs;
                        sortSnapshot(middleNodeList);
                        for (var j = 0; j < middleNodeList.length; j++) {

                            var middleNode = middleNodeList[j];

                            if (middleNode.hasOwnProperty("childs")) {

                                sortSnapshot(middleNode.childs);

                                for (var k = 0; k < middleNode.childs.length; k++) {
                                    var bottomNode = middleNode.childs[k];
                                    //默认排程节点
                                    if (middleNode.firstNode) {
                                        if (!bottomNode.apply && !middleNode.firstNode) {
                                            bottomNode.icon = "images/bom_img/interNode.png";
                                        } else if (!bottomNode.apply && bottomNode.firstNode) {
                                            bottomNode.icon = "images/bom_img/commonNode.png";
                                        } else if (bottomNode.apply) {
                                            bottomNode.icon = "images/bom_img/dispatchNode.png";
                                        }
                                    }
                                    //故障节点
                                    else {
                                        if (bottomNode.apply) {
                                            bottomNode.icon = "images/bom_img/dispatchNode.png";
                                        } else {
                                            bottomNode.icon = "images/bom_img/commonNode.png";
                                        }
                                    }
                                    treeInfo.push(bottomNode);
                                }
                                var temps = middleNode.childs;
                                delete(middleNode.childs);
                                middleNode.children = temps;
                                middleNode = middleNode;
                                middleNode.schedule = response.data.schedule;
                                treeInfo.push(middleNode);
                            }

                            if (middleNode.errorNode) {
                                middleNode.icon = "images/bom_img/errorNode.png";
                            } else {
                                middleNode.icon = "images/bom_img/interactive.png";
                            }

                            console.log(bottomNode);
                        }
                        datas.icon = "images/bom_img/rootNode.png";
                        var temp = datas.childs;
                        delete(datas.childs);
                        datas.children = temp;
                        treeInfo.push(datas);
                    }
                    zNodes.push(datas);
                    loadTree();
                    hideLoadingPage();
                })
            } else {
                document.getElementById("treeDemo").style.display = "none";
                $("#table_value  tr:not(:first)").html("");
            }
            $("#table_value  tr:not(:first)").html("");
        });

        function loadTree() {
            var setting = {
                view: {
                    dblClickExpand: false,
                    showIcon: true,
                    showLine: false,
                    fontCss: setFontCss
                },
                callback: {
                    onClick: zTreeOnClick
                },
                data: {
                    keep: {
                        parent: true
                    }
                },
                edit: {
                    enable: true,
                    showRenameBtn: false,
                    showRemoveBtn: false
                },
                check: {
                    enable: true
                }
            };

            //点击树形控件
            function zTreeOnClick(e, treeId, treeNode) {
                $scope.hasDispatchMes = treeNode.apply;
                if (treeNode.level == 0) {
                    $scope.messStatus = "--";
                } else if (treeNode.level == 1) {
                    $scope.messStatus = treeNode.apply ? "已下发" : "未下发";
                    if (treeNode.apply) {
                        $scope.dispatchMesTime = treeNode.dispatchMesTime;
                    } else {
                        $scope.dispatchMesTime = "";
                    }

                    if (treeNode.children) {
                        $scope.interactiveCount = (treeNode.children.length - 1) + "次";
                    } else {
                        $scope.interactiveCount = "0次";
                    }

                } else if (treeNode.level == 2) {
                    var pNode = treeNode.getParentNode();
                    if (pNode != null) {
                        $scope.messStatus = pNode.apply ? "已下发" : "未下发";
                        $scope.dispatchMesTime = pNode.dispatchMesTime;
                    }
                }
                $scope.$apply();

                var zTree = $.fn.zTree.getZTreeObj("treeDemo");

                if (treeNode.level == 0 || treeNode.level == 1) {
                    zTree.expandNode(treeNode);
                } else if (treeNode.level == 2) {
                    var params = {};
                    params.id = treeNode.id;
                    var data = JSON.stringify(params);
                    layer.load();
                    myHttpService.post(serviceList.getAllPlan, data).then(function successCallback(response) {
                        $scope.planList = response.data;
                        hideLoadingPage();
                    });
                }
            }   //onclick

            //动态设置字体的颜色
            function setFontCss(treeId, treeNode) {
                var fs;
                if (treeNode.apply && treeNode.level == 2) {
                    fs = {color: "white", background: "#3C8DBC", border: "none"};
                }
                return fs;
            }

            $.fn.zTree.init($("#treeDemo"), setting, zNodes);

            document.getElementById("treeDemo").style.display = "";
        }

        //对右键菜单的状态进行设置
        function resetRightMenSate(buttState) {
            $("#navigationMenu li").each(function () {
                $(this).attr('disabled', buttState);
            });
        }

        //快照对比
        $scope.compareSnapshot = function () {

         /*myHttpService.get(serviceList.queryApsState).then(function (response) {

         });*/

             $('#modal-add').modal({backdrop: 'static', keyboard: false});
             $("#modal-add").show();

             $("#nextStep").attr("disabled", true);

             //下拉框事件改变
             $("#select2").change(function () {

                 $scope.hasDispatchMes = false;
                 $scope.messStatus = "--";

                 $scope.detail = false;

                 var idRoot;
                 var val = $(this).children('option:selected').val();
                 if (val.length > 0) {
                 for (var i = 0; i < rootData.length; i++) {
                     if (rootData[i].name == val) {
                         idRoot = rootData[i].id;
                         break;
                     }
                 }
                 var params = {};
                 params.id = idRoot;
                 var idSch1 = JSON.stringify(params);

                 //console.log(idSch1);

                 }
             });
             //console.log(val2);
             resetContent();
         };

        //重置页面内容信息
        function resetContent() {
            $("#previouseStep").hide();
            $("#nextStep").show();

            pageCount = $(".MyPage").size();
            pageTipCount = $(".MyPageTip").size();

            $(".MyPage").eq(currPage).hide();
            currPage = 0;
            $(".MyPage").eq(currPage).show();

            choosePageTip();

            snaps.splice(0, snaps.length);
            //idS.splice(0, idS.length);

            //清空页面信息
            for (var i = 0; i < pageCount; i++) {
                PageInfo.selectedIndex[i].splice(0, PageInfo.selectedIndex[i].length);
                PageInfo.data[i].splice(0, PageInfo.data[i].length);
            }
        }

        function choosePageTip() {
            $("#tipHover").animate({"left": currPage / pageTipCount * 100 + "%"}, 250, function () {
                $("#tipHover").text($(".MyPageTip").eq(currPage).text());
            });
        }

        //上一步
        $scope.previous = function () {
            if (currPage >= 0) {
                $("#nextStep").show();

                $(".MyPage").eq(currPage).hide();
                currPage -= 1;
                $(".MyPage").eq(currPage).show();
            }

            if (currPage == 0) {
                $("#previouseStep").hide();
                $("#nextStep").show();
            }

            if (currPage == pageCount - 1) {
                $("#previouseStep").hide();
            }

            choosePageTip();

            //快照选择
            if (currPage == 1) {
                if (PageInfo.selectedIndex[currPage].length <= 0) {
                    $("#nextStep").attr("disabled", true);
                } else {
                    $("#nextStep").removeAttr("disabled");
                }
            }
            //显示结果
            else if (currPage == 2) {
                if (PageInfo.selectedIndex[currPage].length <= 0) {

                }
            }
            //第一页
            else {
                $("#nextStep").removeAttr("disabled");
            }


        };

        //下一步
        $scope.next = function () {

            if (currPage == 0) {
                $("#nextStep").removeAttr('disabled');
            }

            if (currPage < pageCount - 1) {
                $("#previouseStep").show();
                $(".MyPage").eq(currPage).hide();
                currPage += 1;
                $(".MyPage").eq(currPage).show();
                $(".previouseStep").eq(currPage).show();
            }

            if (currPage == pageCount - 1) {
                $("#nextStep").hide();
                $("#previouseStep").hide();
            }
            choosePageTip();

            //布局查询
            if (currPage == 1) {
                if (PageInfo.data[currPage].length == 0) {
                    selectSnapshot();
                }
                if (PageInfo.selectedIndex[currPage].length <= 0) {
                    $("#nextStep").attr("disabled", true);
                } else {
                    $("#nextStep").removeAttr("disabled");
                }
            }
            //订单查询
            else if (currPage == 2) {
                if (PageInfo.data[currPage].length == 0) {
                    showCompareInfo();
                }
            }
        };

        //选择快照
        function selectSnapshot() {

            var idSch = $("#select0 option:selected").val();
            console.log(idSch);

            //selsnap.id = idSch;

            if (idSch.length > 0) {
                for (var i = 0; i < rootData.length; i++) {
                    if (rootData[i].name == idSch) {
                        idS = rootData[i].id;
                        break;
                    }
                }


                var params = {};
                params.id = idS;
                idSch = JSON.stringify(params);
            }

            //delete selsnap.id;

            myHttpService.post(serviceList.getTree, idSch).then(function successCallback(response) {
                idS = "";
                $scope.snapShotData = response.data;
                var datas = response.data;

                //console.log(datas);

                if (datas.hasOwnProperty("childs")) {
                    var middleNodeList = datas.childs;
                    console.log(middleNodeList);
                    sortSnapshot(middleNodeList);
                    for (var j = 0; j < middleNodeList.length; j++) {

                        var middleNode = middleNodeList[j];

                        if (middleNode.hasOwnProperty("childs")) {

                            sortSnapshot(middleNode.childs);

                            for (var k = 0; k < middleNode.childs.length; k++) {
                                var bottomNode = middleNode.childs[k];

                                //改
                                //bottomInfo.push(bottomNode);
                                PageInfo.data[currPage].push(bottomNode);
                            }
                        }

                    }
                }
                //改
                //$scope.bottomInfo = bottomInfo;
                $scope.bottomInfo = PageInfo.data[currPage];
                //console.log(bottomInfo);
            });

        }

        //显示对比结果信息
        function showCompareInfo() {
            layer.load(0);

            for (var i = 0; i < pageCount; i++) {
                if (i == 1) {
                    //snaps.id = PageInfo.selectedIndex[i][0];

                    for (var j = 0; j < PageInfo.selectedIndex[i].length; j++) {
                        var params = {};
                        params.id = PageInfo.selectedIndex[i][j];
                        snaps.push(params);
                    }
                }

            }

            var params = {};
            params.snaps = snaps;
            var data = JSON.stringify(params);


            myHttpService.post(serviceList.getAllResult, data).then(function successCallback(response) {


                //清空所用的数组和变量
                selectedCheckArray.splice(0, selectedCheckArray.length);
                snaps.splice(0,snaps.length);
                console.log(snaps);

                $scope.resultList = response.data;
                //$scope.rateList = response.data.useRate;


                hideLoadingPage();
            });

        }


        //基本信息检验
        $scope.infoValidate = function (){

            //alert("haha");
            var coun=$("#select0").val();
            //console.log(coun);
            if(coun != 0) {
                $("#nextStep").removeAttr('disabled');
            }else{
                $("#nextStep").attr("disabled", true);
            }

        };


        //表格信息重置
        $scope.reset = function () {
            $("input").val('');
            //$("#select0").select2("val","");
            $("div").removeClass("has-error");
            $("div").removeClass("has-success");
        };


        //用于监控点击事件，checkbox选择了就更新
        $scope.updateSelection = function ($event, id) {
            var checkbox = $event.target;
            var action = (checkbox.checked ? 'add' : 'remove');


            updateSelected(action, id);

        };

        //添加或取消勾选时更新对应页面的列表
        var updateSelected = function (action, id) {

            if (action == 'add' & PageInfo.selectedIndex[currPage].indexOf(id) == -1) {
                PageInfo.selectedIndex[currPage].push(id);
                if (PageInfo.selectedIndex[currPage].length > 0) {
                    $("#nextStep").removeAttr("disabled");
                }
            }

            if (action == 'remove' && PageInfo.selectedIndex[currPage].indexOf(id) != -1) {
                PageInfo.selectedIndex[currPage].splice(PageInfo.selectedIndex[currPage].indexOf(id), 1);
                if (PageInfo.selectedIndex[currPage].length == 0) {
                    $("#nextStep").attr("disabled", true);
                }
            }
        };

        $scope.isSelected = function (id) {
            return selectedCheckArray.indexOf(id) >= 0;
        };



        //显示利用率

        $scope.findRate = function (event) {
            processError(event);
        };

        function processError(event) {
            var e = event || window.event;
            var target = e.target || e.srcElement;
            if (target.parentNode.tagName.toLowerCase() == "td") {
                var rowIndex = target.parentNode.parentNode.rowIndex;
                var id = document.getElementById("table_result").rows[rowIndex].cells[0].innerHTML;
                //alert(id);

                var params = {};
                params.id = id;
                var idInfo = JSON.stringify(params);

                myHttpService.post(serviceList.getAllRate,idInfo).then(function successCallback(response) {
                    $scope.rateList = response.data;
                    hideLoadingPage();
                })
            }
        }


        //显示当前排程的布局
        $scope.Detail = function (event) {
            var e = event || window.event;
            var target = e.target || e.srcElement;
            if (target.parentNode.tagName.toLowerCase() == "td") {
                var rowIndex = target.parentNode.parentNode.rowIndex;
                //alert(rowIndex);
                var id = document.getElementById("table_info").rows[rowIndex].cells[0].innerHTML;
                //alert(id);
                var parm={};
                parm.id=id;
                var info=JSON.stringify(parm);
                myHttpService.post(serviceList.LayoutDetail,info).then(function successCallback(response) {
                    $scope.layoutDetailList = response.data;

                }, function errorCallback() {
                    notification.sendNotification("alert", "请求失败");
                })

            }
        };
    });