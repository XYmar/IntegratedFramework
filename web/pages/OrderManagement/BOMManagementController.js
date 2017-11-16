/**
 * Created by zhaoqi on 2017/7/9.
 */
'use strict';
angular.module("IntegratedFramework.BOMManagementController", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/BOMManagement', {
            templateUrl: 'pages/OrderManagement/BOMManagement.html',
            controller: 'BOMManagementController'
        })
    }])
    .controller('BOMManagementController', function ($scope, $http, myHttpService, serviceList, notification) {

        layer.load(0);

        var zNodes = [];
        var rootData = [];
        var option;//Dag的option
        var map = {};//根节点用于折叠展开
        var mapMiddle = {};

        var myDag;

        var oldMiddle = [];//存放选择查看方式时被删除的节点，用于恢复dag原形
        var oldBottom = [];

        var vals;//右侧下拉框选中的值

        $(function () {
            //初始化下拉数据
            $(".select2").select2();

            //显示暂无数据
            view();

            var dataTrue = {"isRootNode": true};
            myHttpService.post(serviceList.isRootNode, dataTrue).then(function successCallback(response) {
                rootData = response.data;
                $scope.rootdata = response.data;
                //$scope.processdata = response.data;
                loadRightFloatMenu();
                hideLoadingPage();
            });
        });

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

            zNodes.splice(0, zNodes.length);
            oldMiddle.splice(0, oldMiddle.length);
            oldBottom.splice(0, oldBottom.length);
            var idRoot;
            var val = $(this).children('option:selected').val();

            refreshSelects();

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

                myHttpService.post(serviceList.isChildNode, id).then(function successCallback(response) {
                    var datas = response.data;

                    if (datas.hasOwnProperty("childProcess")) {
                        var middleNodeList = datas.childProcess;
                        sortSnapshot(middleNodeList);
                        for (var j = 0; j < middleNodeList.length; j++) {

                            var middleNode = middleNodeList[j];

                            if (middleNode.hasOwnProperty("childProcess")) {

                                sortSnapshot(middleNode.childProcess);

                                for (var k = 0; k < middleNode.childProcess.length; k++) {
                                    var bottomNode = middleNode.childProcess[k];
                                    if (bottomNode.transport == 0) {
                                        bottomNode.icon = "images/bom_img/fit.png";
                                        bottomNode.symbol = "images/bom_img/fit.png";
                                    } else if (bottomNode.transport == 1) {

                                        bottomNode.icon = "images/bom_img/transport.png";
                                        bottomNode.symbol = "images/bom_img/transport.png";
                                    } else {
                                        bottomNode.icon = "images/bom_img/errorNode.png";
                                        bottomNode.symbol = "images/bom_img/errorNode.png";
                                    }
                                }
                                var temps = middleNode.childProcess;
                                delete(middleNode.childProcess);
                                middleNode.children = temps;
                                middleNode = middleNode;
                                if (middleNode.children.length > 0) {
                                    if (middleNode.transport == 0) {

                                        middleNode.icon = "images/bom_img/fit.png";
                                        middleNode.symbol = "images/bom_img/fit.png";
                                    } else if (middleNode.transport == 1) {
                                        middleNode.icon = "images/bom_img/interactive.png";
                                        middleNode.symbol = "images/bom_img/interactive.png";
                                    } else {
                                        middleNode.icon = "images/bom_img/errorNode.png";
                                        middleNode.symbol = "images/bom_img/errorNode.png";
                                    }
                                } else {
                                    if (middleNode.transport == 0) {

                                        middleNode.icon = "images/bom_img/fit.png";
                                        middleNode.symbol = "images/bom_img/fit.png";
                                    } else if (middleNode.transport == 1) {
                                        middleNode.icon = "images/bom_img/transport.png";
                                        middleNode.symbol = "images/bom_img/transport.png";
                                    } else {
                                        middleNode.icon = "images/bom_img/errorNode.png";
                                        middleNode.symbol = "images/bom_img/errorNode.png";
                                    }
                                }

                            }
                        }
                        datas.icon = "images/bom_img/rootNode.png";
                        datas.symbol = "images/bom_img/rootNode.png";
                        var temp = datas.childProcess;
                        delete(datas.childProcess);
                        datas.children = temp;
                    }
                    zNodes.push(datas);

                    loadTree();
                    loadDAG();
                    hideLoadingPage();
                });
                $scope.processData = "";
                $scope.$apply();
            } else {
                document.getElementById("treeDemo").style.display = "none";
                // $("#table_value  tr:not(:first)").html("");
                $scope.processData = "";
                $scope.$apply();
                //显示暂无数据
                view();
            }

        });

        $("#select0").change(function () {

            var model;
            var val = $(this).children('option:selected').val();

            if (val.length > 0) {
                if(val == "简化模型"){
                    model = 1;
                }else if(val == "细化模型"){
                    model = 2;
                }

                var params = {};
                params.model = model;
                var modelNum = JSON.stringify(params);

                layer.load();


                myHttpService.post(serviceList.switchModel, modelNum).then(function successCallback() {
                    hideLoadingPage();
                    notification.sendNotification("confirm", "切换成功！");
                }, function errorCallback() {
                    notification.sendNotification("alert", "切换失败");
                });
            } else {
                $scope.$apply();
            }

        });


        function loadTree() {
            var setting = {
                view: {
                    dblClickExpand: false,
                    showIcon: true,
                    showLine: false
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
                refresh();

                /*var zTree = $.fn.zTree.getZTreeObj("treeDemo");
                zTree.expandNode(treeNode);*/

                //节点点击显示具体信息
                $scope.processData = treeNode;
                $scope.$apply();

                var zTree = $.fn.zTree.getZTreeObj("treeDemo");

                if (treeNode.level == 0) {
                    zTree.expandNode(treeNode);
                } else if (treeNode.level == 1) {

                    var params = {};
                    params.id = treeNode.id;
                    var data = JSON.stringify(params);
                    layer.load();
                    myHttpService.post(serviceList.isChildNode, data).then(function successCallback(response) {
                        $scope.processDetail = response.data;
                        console.log($scope.processDetail);
                        hideLoadingPage();
                    });
                }

                for (var j = 0; j < option.series[0].data.length; j++) {
                    //根节点的折叠展开
                    if (option.series[0].data[j].name == treeNode.name) {
                        //展开
                        if (map.hasOwnProperty(treeNode.name) && map[treeNode.name] != null) {
                            option.series[0].data[j].children = map[treeNode.name];
                            map[treeNode.name] = null;
                            //名称位置
                            option.series[0].itemStyle.normal.label.position = null;
                            //点击根节点展开，不显示二级的子节点
                            if (option.series[0].data[j].children.length > 0) {
                                for (var k = 0; k < option.series[0].data[j].children.length; k++) {
                                    if (option.series[0].data[j].children[k].hasOwnProperty("children")) {
                                        mapMiddle[option.series[0].data[j].children[k].name] = option.series[0].data[j].children[k].children;
                                        //将子节点删除
                                        delete option.series[0].data[j].children[k].children;
                                    }
                                }
                            }
                            break;
                        }
                        //折叠
                        if (option.series[0].data[j].children) {
                            //将子节点信息存入map，形式【当前点击节点的name为key，子节点数据为value】
                            map[option.series[0].data[j].name] = option.series[0].data[j].children;
                            //然后将option中的当前子节点删除
                            delete option.series[0].data[j].children;
                            //如果option的data结构只有根节点名称，没有children，则无法正确显示
                            option.series[0].data[j].children = "";
                            option.series[0].itemStyle.normal.label.position = "right";
                            //点击根节点收缩，完全折叠
                            $.fn.zTree.getZTreeObj("treeDemo").expandAll(false);
                            //跳出循环
                            break;
                        }
                    }

                    //二级节点的操作
                    for (var l = 0; l < option.series[0].data[j].children.length; l++) {
                        if (option.series[0].data[j].children[l].name == treeNode.name) {
                            if (mapMiddle.hasOwnProperty(treeNode.name) && mapMiddle[treeNode.name] != null) {
                                option.series[0].data[j].children[l].children = mapMiddle[treeNode.name];
                                mapMiddle[treeNode.name] = null;
                                option.series[0].itemStyle.normal.label.position = null;
                                break;
                            }

                            if (option.series[0].data[j].children[l].children) {
                                //将子节点信息存入clickMap，形式【当前点击节点的name为key，子节点数据为value】
                                mapMiddle[option.series[0].data[j].children[l].name] = option.series[0].data[j].children[l].children;
                                //然后将_option中的当前子节点删除
                                delete option.series[0].data[j].children[l].children;
                                option.series[0].itemStyle.normal.label.position = null;
                                break;
                            }
                        }
                    }
                }

                myDag.clear();
                //重新赋值，渲染图表
                myDag.setOption(option);

                refreshSelects();

            }

            $.fn.zTree.init($("#treeDemo"), setting, zNodes);

            document.getElementById("treeDemo").style.display = "";

        }

        function refreshSelects(){
            //右侧下拉框刷新
            $("#selects").empty();
            //根据select查找对象，
            var obj=document.getElementById('selects'); //获取到id为'mySelect'的select元素

            //添加选项
            obj.options.add(new Option(""));
            obj.options.add(new Option("运输工艺"));
            obj.options.add(new Option("生产工艺"));
            obj.options.add(new Option("显示全部"));
        }

        function loadDAG() {
            // 基于准备好的dom，初始化echarts实例
            myDag = echarts.init(document.getElementById('dag'));

            // 指定图表的配置项和数据
            option = {
                series: [
                    {
                        name: '树图',
                        type: 'tree',
                        orient: 'horizontal',  // vertical horizontal
                        rootLocation: {x: 100, y: 230}, // 根节点位置  {x: 100, y: 'center'}
                        nodePadding: 25,
                        layerPadding: 150,
                        roam: true,
                        symbolSize: 6,
                        legendHoverLink: true,
                        itemStyle: {
                            normal: {
                                color: '#4883b4',
                                label: {
                                    show: true,
                                    position: 'right',
                                    formatter: "{b}",
                                    textStyle: {
                                        color: '#000',
                                        fontSize: 5
                                    }
                                },
                                lineStyle: {
                                    color: '#ccc',
                                    type: 'curve' // 'curve'|'broken'|'solid'|'dotted'|'dashed'
                                }
                            },
                            emphasis: {
                                label: {
                                    show: true,
                                    textStyle: {
                                        color: '#991096',
                                    }
                                },
                                borderWidth: 2
                            }
                        },
                    }
                ]
            };

            //图结构数据
            option.series[0].data = zNodes;

            //只显示根节点
            for (var j = 0; j < option.series[0].data.length; j++) {
                map[option.series[0].data[j].name] = option.series[0].data[j].children;
                //然后将option中的当前子节点删除
                delete option.series[0].data[j].children;
                //如果option的data结构只有根节点名称，没有children，则无法正确显示
                option.series[0].data[j].children = "";
            }

            // 使用刚指定的配置项和数据显示图表
            myDag.setOption(option);
            document.getElementById("dag").style.display = "";

        }

        var myChart = document.getElementById('dag');

        //自适应宽高
        var myChartContainer = function () {
            myChart.style.width = window.screen.availWidth +'px';
            myChart.style.height = window.screen.availHeight+'px';
        };
        myChartContainer();
        //浏览器大小改变时重置大小
        window.onresize = function () {
            myChartContainer();
            //myChart.resize();
        };


        //查看方式
        //下拉框事件改变
        $("#selects").change(function () {

            vals = $(this).children('option:selected').val();

            changeDAG();

            myDag.clear();
            //重新赋值，渲染图表
            myDag.setOption(option);
        });

        function changeDAG(){

            refresh();
            if (vals == "生产工艺") {
                for (var i = 0; i < option.series[0].data.length; i++) {
                    if (option.series[0].data[i].children.length > 0) {
                        for (var j = option.series[0].data[i].children.length - 1; j >= 0; j--) {
                            if (option.series[0].data[i].children[j].transport == 1) {
                                oldMiddle.push(option.series[0].data[i].children[j]);
                                //移除“生产工艺的”
                                option.series[0].data[i].children.removeByValue(option.series[0].data[i].children[j]);
                            } else {
                                if (option.series[0].data[i].children[j].children) {
                                    for (var l = option.series[0].data[i].children[j].children.length - 1; l >= 0; l--) {
                                        if (option.series[0].data[i].children[j].children[l].transport == 1) {
                                            option.series[0].data[i].children[j].children[l].parentId = option.series[0].data[i].children[j].id;
                                            oldBottom.push(option.series[0].data[i].children[j].children[l]);
                                            option.series[0].data[i].children[j].children.removeByValue(option.series[0].data[i].children[j].children[l]);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else if (vals == "运输工艺") {
                for (var i = 0; i < option.series[0].data.length; i++) {
                    if (option.series[0].data[i].children.length > 0) {
                        for (var j = option.series[0].data[i].children.length - 1; j >= 0; j--) {
                            if (option.series[0].data[i].children[j].transport == 0) {
                                oldMiddle.push(option.series[0].data[i].children[j]);
                                //移除运输工艺的
                                option.series[0].data[i].children.removeByValue(option.series[0].data[i].children[j]);
                            } else {
                                if (option.series[0].data[i].children[j].children) {
                                    for (var l = option.series[0].data[i].children[j].children.length - 1; l >= 0; l--) {
                                        if (option.series[0].data[i].children[j].children[l].transport == 0) {
                                            option.series[0].data[i].children[j].children[l].parentId = option.series[0].data[i].children[j].id;
                                            oldBottom.push(option.series[0].data[i].children[j].children[l]);
                                            option.series[0].data[i].children[j].children.removeByValue(option.series[0].data[i].children[j].children[l]);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else if (vals == "显示全部") {
                /*   for (var i = 0; i < option.series[0].data.length; i++) {
                 if (option.series[0].data[i].children.length > 0) {
                 for (var j = option.series[0].data[i].children.length - 1; j >= 0; j--) {
                 oldDag.push(option.series[0].data[i].children[j]);
                 option.series[0].data[i].children.removeByValue(option.series[0].data[i].children[j]);
                 }
                 option.series[0].data[i].children = treeNodes.children;
                 myDag.clear();
                 //重新赋值，渲染图表
                 myDag.setOption(option);
                 }
                 }*/
            }

            //解决只剩根节点时的显示问题
            for (var i = 0; i < option.series[0].data.length; i++) {
                if (!option.series[0].data[i].hasOwnProperty("children")) {
                    option.series[0].data[i].children = "";
                }
            }
        }

        //移除数组中对应的对象数组
        Array.prototype.removeByValue = function (obj) {
            for (var i = 0; i < this.length; i++) {
                if (this[i].id == obj.id) {
                    this.splice(i, 1);
                    break;
                }
            }
        };


        //恢复DAG原形
        function refresh() {
            for (var j = 0; j < option.series[0].data.length; j++) {
                if (oldMiddle.length > 0) {
                    for (var i = 0; i < oldMiddle.length; i++) {
                        (option.series[0].data[j].children).push(oldMiddle[i]);
                        for (var k = 0; k < option.series[0].data[j].children.length; k++) {
                            if (oldBottom.length > 0) {
                                for (var l = 0; l < oldBottom.length; l++) {
                                    if (option.series[0].data[j].children[k].id == oldBottom[l].parentId) {
                                        option.series[0].data[j].children[k].children.push(oldBottom[l]);
                                    }
                                }
                            }
                        }
                    }
                    oldMiddle.splice(0, oldMiddle.length);
               /* } else if (oldDag.length > 0) {
                    if (option.series[0].data[j].children.length > 0) {
                        for (var k = option.series[0].data[j].children.length - 1; k >= 0; k--) {
                            option.series[0].data[j].children.removeByValue(option.series[0].data[j].children[k]);
                        }
                    }
                    for (var l = 0; l < oldDag.length; l++) {
                        (option.series[0].data[j].children).push(oldDag[l]);
                    }
                    oldDag.splice(0, oldDag.length);*/
                } else {
                    for (var m = 0; m < option.series[0].data[j].children.length; m++) {
                        if (oldBottom.length > 0) {
                            for (var l = 0; l < oldBottom.length; l++) {
                                if (option.series[0].data[j].children[m].id == oldBottom[l].parentId) {
                                    (option.series[0].data[j].children[m].children).push(oldBottom[l]);
                                }
                            }
                        }
                    }
                    oldBottom.splice(0, oldBottom.length);
                }
            }
        }
        //显示暂无数据
        function view() {
            document.getElementById("dag").style.display = "";
            var myDag = echarts.init(document.getElementById('dag'));
            var option = {
                series: [
                    {
                        roam: true,
                    }
                ]
            };
            myDag.setOption(option);
        }


        $("#dag").dblclick(function(){
            //全屏
            fullScreen();
            //退出全屏
            exitFullScreen();
        });


        //全屏
        function fullScreen() {
            var el = document.getElementById("dag");
            var rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen;
            if (typeof rfs != "undefined" && rfs) {
                rfs.call(el);
            } else if (typeof window.ActiveXObject != "undefined") {
                var wscript = new ActiveXObject("WScript.Shell");
                if (wscript != null) {
                    wscript.SendKeys("{F11}");
                }
            }
        }

        //退出全屏
        function exitFullScreen() {
            var el = document;
            var cfs = el.cancelFullScreen || el.webkitCancelFullScreen || el.mozCancelFullScreen || el.exitFullScreen;

            if (typeof cfs != "undefined" && cfs) {
                cfs.call(el);
            } else if (typeof window.ActiveXObject != "undefined") {
                //for IE，这里和fullScreen相同，模拟按下F11键退出全屏
                var wscript = new ActiveXObject("WScript.Shell");
                if (wscript != null) {
                    wscript.SendKeys("{F11}");
                }
            }
        }

        //更新BOM
        $scope.updateBOM = function () {
            layer.confirm('是否更新当前BOM信息?', {
                btn: ['确定', '取消'] //按钮
            }, function (index) {
                layer.close(index);
                notification.sendNotification("confirm", "已更新");
            }, function (index) {
                layer.close(index);
                notification.sendNotification("alert", "已取消更新");
            });
        };

        //属性设置
        $scope.propertySetting = function () {

        };

        //辅助工艺
        $scope.assisantProcess = function () {

        };


    });