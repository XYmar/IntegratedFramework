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
    .controller('ScheduleSnapController', function ($scope, $http, myHttpService, serviceList) {

        $(function () {
            //初始化下拉数据
            $(".select2").select2();
        });

        var dataTrue = {"level": "top"};
        myHttpService.post(serviceList.isRootLevel, dataTrue).then(function successCallback(response) {
            var setting = {
                view: {
                    dblClickExpand: false,
                    showIcon: false,
                    showLine: false
                },
                callback: {
                    onRightClick: OnRightClick
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
            };
            var zNodes = [];

            console.log("*****" + response.status);
            console.log(response.data);
            var dataArr = response.data;
            $scope.dataArr = response.data;


            for (var i = 0; i < dataArr.length; i++) {
                console.log("根节点");
                console.log(dataArr[i]);
                var datas = dataArr[i];
                console.log("是否有一级");
                console.log(datas.hasOwnProperty("childs"));
                if (datas.hasOwnProperty("childs") == true) {
                    var childList = dataArr[i].childs;
                    console.log("根节点下的一级");
                    console.log(childList);
                    console.log("根节点下的一级长度");
                    console.log(childList.length);
                    for (var j = 0; j < childList.length; j++) {
                        console.log("一级节点下是否有");
                        console.log(childList[j].hasOwnProperty("childs"));
                        var childLists = childList[j];
                        if (childLists.hasOwnProperty("childs") == true) {
                            console.log("一级节点下删除前的二级");
                            console.log(childLists);
                            var temps = childLists.childs;
                            console.log(temps);
                            delete(childLists.childs);
                            childLists.children = temps;
                            console.log("一级节点下删除后的二级");
                            console.log(childLists);
                            childList[j] = childLists;
                        }
                    }
                    console.log(childList);
                    var temp = datas.childs;
                    delete(datas.childs);
                    datas.children = temp;
                }
            }
            console.log(dataArr);
            //zNodes = data;
            zNodes = dataArr;
            console.log("&&&&&&&&&");
            console.log(zNodes);

            //右击
            function OnRightClick(event, treeId, treeNode) {
                var e = event || window.event;
                if (!treeNode && e.target.tagName.toLowerCase() != "button" && $(e.target).parents("a").length == 0) {
                    zTree.cancelSelectedNode();
                    showRMenu("root", e.clientX, e.clientY);
                } else if (treeNode && !treeNode.noR) {
                    zTree.selectNode(treeNode);
                    showRMenu("node", e.clientX, e.clientY);
                }
            }

            //右击菜单显示
            function showRMenu(type, x, y) {
                $("#rMenu ul").show();
                if (type == "root") {
                    $("#m_del").hide();
                } else {
                    $("#m_del").show();
                }
                rMenu.css({"top": (y-160) + "px", "left": (x-250) + "px", "visibility": "visible"});

                $("body").bind("mousedown", onBodyMouseDown);
            }

            //右击菜单隐藏
            function hideRMenu() {
                if (rMenu) rMenu.css({"visibility": "hidden"});
                $("body").unbind("mousedown", onBodyMouseDown);
            }


            function onBodyMouseDown(event) {
                if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
                    rMenu.css({"visibility": "hidden"});
                }
            }

            var addCount = 1;

            //增加节点
            $scope.addTreeNode = function() {
                hideRMenu();
                var newNode = {name: "增加" + (addCount++)};
                if (zTree.getSelectedNodes()[0]) {
                    newNode.checked = zTree.getSelectedNodes()[0].checked;
                    zTree.addNodes(zTree.getSelectedNodes()[0], newNode);
                } else {
                    zTree.addNodes(null, newNode);
                }
            }

            //删除节点
            $scope.removeTreeNode = function() {
                hideRMenu();
                var nodes = zTree.getSelectedNodes();
                if (nodes && nodes.length > 0) {
                    if (nodes[0].children && nodes[0].children.length > 0) {
                        var msg = "要删除的节点是父节点，如果删除将连同子节点一起删掉。\n\n请确认！";
                        if (confirm(msg) == true) {
                            zTree.removeNode(nodes[0]);
                        }
                    } else {
                        zTree.removeNode(nodes[0]);
                    }
                }
            }

            //修改节点
            $scope.checkTreeNode = function(checked) {
                var nodes = zTree.getSelectedNodes();
                if (nodes && nodes.length > 0) {
                    zTree.checkNode(nodes[0], checked, true);
                }
                hideRMenu();
            }

            $scope.resetTree = function() {
                hideRMenu();
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            }

            var zTree, rMenu;
            $(document).ready(function () {
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                zTree = $.fn.zTree.getZTreeObj("treeDemo");
                rMenu = $("#rMenu");
            });


        });
    });
