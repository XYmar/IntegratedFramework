<%--
  Created by IntelliJ IDEA.
  User: XY
  Date: 2017/6/1
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<link href="../../mycss/mycss.css" type="text/css" rel="stylesheet">

<style type="text/css">

    .nav-ml ul {
        margin-bottom: 0px;
    }

    .nav-ml ul > li {
        list-style-type: none;
        margin: -5px;
        padding: 10px 0px 5px 5px;
        position: relative;
        left: 0px;
        font-size: 12px;
        cursor: pointer;
        /*width: 440px;*/
    }

    .nav-ml li::before, .nav-ml li::after {
        content: '';
        left: -40px;
        position: absolute;
        right: auto
    }

    .nav-ml li a {
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        border: 1px solid lightgrey;
        border-radius: 5px;
        display: inline-block;
        padding: 3px 8px;
        text-decoration: none;
        background-color: #f9fcfc;
    }

    .fold {
        display: none;
    }

    .nav-ml li.nav-first_li > a {
        cursor: pointer
    }

    .nav-ml > ul > li::before, .nav-ml > ul > li::after {
        border: 1px;
    }

    .nav-ml li:last-child::before {
        height: 30px;
    }

    .bomspan {
        font-size: 16px;
        /*background: url("../../images/bom_img/bomqie.png");*/

    }

    .bomdiv {
        background: url("../../images/bom_img/bomqie.png") no-repeat;
        background-size: 100% 100%;
    }

    /*
        BOM树左侧的线条（竖线）
    */
    .nav-ml li::before {
        border-left: 2px solid white;
        bottom: 50px;
        height: 100%;
        top: 0px;
        width: 1px;
        margin-top: -2px;
    }

    /*
        BOM树左侧的线条（横线）
    */
    .nav-ml li::after {
        border-top: 2px solid white;
        height: 20px;
        top: 25px;
        width: 20px;
    }

    .bg {
        background-color: #c1edfa;
    }

    /*
        BOM树下部panel
    */
    .uk-panel-box {
        padding: 15px;
        background: #fafafa;
        color: #444;
        border: 1px solid #ddd;
        border-radius: 0px;
    }

    .uk-table td {
        vertical-align: top;
        width: 28px;
        margin-left: 11px;
    }

    /*
        form表单的位置固定
    */
    .uk-form {
        display: inherit;
    }

    #rMenu {
        position: absolute;
        visibility: hidden;
        top: 0;
        background-color: #FFFFFF;
        padding: 2px;
    }

    #rMenu ul li {
        margin: 1px 0;
        padding: 0 2px;
        cursor: pointer;
        list-style: none outside none;
        background-color: #FFFFFF;
    }

    <%--.ztree li span.button.diy01_ico_open,.ztree li span.button.diy01_ico_close{background:url("../../images/bom_img/1.png") no-repeat;}
    .ztree li span.button.diy02_ico_open,.ztree li span.button.diy02_ico_close{background:url("../../images/bom_img/2.png") no-repeat;}
    .ztree li span.button.diy02_ico_docu{background:url("../../images/bom_img/2.png") no-repeat;}
    .ztree li span.button.diy03_ico_docu{background:url("../../images/bom_img/3.png") no-repeat;}--%>
    /*第一个图标*/
    .ztree li span.button.switch.level0 {
        background: url("../../images/bom_img/1.png") no-repeat;
        position:relative;
        margin-top:14px;
        margin-left:5px;
    }
    /*第二个图标*/
    .ztree li span.button.switch.level1 {
        background: url("../../images/bom_img/2.png") no-repeat;
        position:relative;
        margin-top:15px;
        margin-left:10px;
    }
    /*第三个图标*/
    .ztree li span.button.switch.level2 {
        background: url("../../images/bom_img/3.png") no-repeat;
        position:relative;
        margin-top:15px;
        margin-left:12px;
    }
    /*
           BOM树左侧的线条（竖线）
       */
    .ztree li::before {
        border-left: 2px solid white;
        bottom: 50px;
        height: 100%;
        top: 0px;
        width: 1px;
        margin-top: -2px;
    }
    /*
       BOM树左侧的线条（横线）
   */
    .ztree li::after {
        border-top: 2px solid white;
        height: 20px;
        top: 25px;
        width: 22px;
    }

    .ztree ul > li {
        list-style-type: none;
        margin-left: 3px;
        padding: 10px 0px 5px 5px;
        position: relative;
        left: 0px;
        font-size: 12px;
        cursor: pointer;
    }

    .ztree li::before, .ztree li::after {
        content: '';
        left: -10px;
        position: absolute;
        right: auto
    }

    .ztree li a {
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        border: 1px solid lightgrey;
        border-radius: 5px;
        display: inline-block;
        padding: 3px 10px;
        text-decoration: none;
        background-color: #f9fcfc;
        margin-top:8px;
    }

    .ztree li:last-child::before {
        height: 30px;
    }

</style>




<script>
    function changeColor(obj) {
        var f = obj.checked;
        var chkColor = "#c1edfa"; //选中后颜色
        //var back = obj.parentElement.parentElement.style.backgroundColor;  //偶数行取消选中后的颜色
        var jiColor = "#FFFFFF";
        if (f)
            obj.parentElement.parentElement.style.backgroundColor = chkColor;
        else
            obj.parentElement.parentElement.style.backgroundColor = jiColor;
    }
</script>

<%--<div id="main">--%>
<div class="<%--uk-grid--%>" style="height: 8%;margin-top: 10px;background-color: white;margin-left: 0px;width: 100%;">

    <img src="../../images/bom_img/shu.png" style="width: 5px;float: left;height: 35px;">


    &nbsp;
    <span style="font-size: 18px;font-weight: 700;margin-top: 10px;/*margin-left: -24px;*/font-family: 微软雅黑">计划排程快照管理</span>

    <form class="uk-search" data-uk-search style="margin-left: 2%;margin-top: 5px;background-color: #e8edf1;">
        <input class="uk-search-field" type="search" placeholder="搜索某个零部件"
               style="width: 150px;border: 1px solid lightgray;">
    </form>

</div>
<%--<hr class="uk-article-divider">--%>
<br/>

<div class="uk-grid" style="height: 88%;">
    <!--快照树-->
    <div id="container" class="uk-width-1-5" style="width: 23%;height: 100%;">
        <!--快照树下部-->
       <!-- <div class="uk-panel uk-panel-box uk-overflow-container" style="height: 82%;background-color: #e2ebf2;">
            <div class="uk-form-row">
                <div class="wrapper">
                    <div class="nav-ml">
                        <%--<ul>
                            <img src="../../images/bom_img/2.png" style="margin-left: -20px;">
                            <li>--%>
                        <ul class="nav-first">
                            <li>
                                <img src="../../images/bom_img/1.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                <a class="item-1"><i></i>排程记录1</a>
                                <ul class="nav-second fold ">
                                    <li>
                                        <img src="../../images/bom_img/2.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                        <a class="item-2"><i></i>排程结果</a>
                                        <ul class="nav-three fold">
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>APS排程结果</a></li>
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>优化结果1</a></li>
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>优化结果2</a></li>
                                        </ul>
                                    </li>

                                    <li>
                                        <img src="../../images/bom_img/2.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                        <a class="item-2"><i></i>故障1</a>
                                        <ul class="nav-three fold">
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>APS应急结果1</a></li>
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>APS应急优化结果1</a></li>
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>APS应急优化结果1</a></li>
                                        </ul>
                                    </li>

                                </ul>
                            </li>
                        </ul>
                        <%-- </li>
                         <img src="../../images/bom_img/2.png" style="margin-left: -20px;">
                         <li>--%>
                        <ul class="nav-first">
                            <li>
                                <img src="../../images/bom_img/1.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                <a class="item-1"><i></i>排程记录2</a>
                                <ul class="nav-second fold ">
                                    <li>
                                        <img src="../../images/bom_img/2.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                        <a class="item-2"><i></i>排程结果</a>
                                        <ul class="nav-three fold">
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>APS排程结果</a></li>
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>优化结果1</a></li>
                                            <li>
                                                <img src="../../images/bom_img/3.png" style="margin-left: -20px;">&nbsp;&nbsp;
                                                <a>优化结果2</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <%--</ul>--%>
                    </div>
                </div>
            </div>
        </div>-->
        <div class="uk-panel uk-panel-box uk-overflow-container"
             style="height: 82%;background-color: #e2ebf2;">
            <ul id="treeDemo" class="ztree"></ul>
        </div>
        <div id="rMenu">
            <ul>
                <li id="m_add" ng-click="addTreeNode()">增加</li>
                <li id="m_del" ng-click="removeTreeNode()">删除</li>
                <li id="m_re" ng-click="renameTreeNode()">重命名</li>
            </ul>
        </div>
    </div>
    <!--右侧表格-->
    <div class="uk-width-4-5"
         style="width: 75.5%;border: 1px solid lightgray;margin-left: 15px;height:  98%;background-color: white;">
        <div style="margin-top: 15px;margin-left: -35px;height: 96%;">

            <!--tab-->
            <div style="width: 100%;border: 0px;margin-top: -15px;">

                <div id="tabs-2" style="width: 100%;">

                    <!--表格-->
                    <div class="uk-overflow-container" style="height: 96%;">
                        <div class="fixtable-head">
                            <table class="uk-table uk-table-striped uk-table-hover ">
                                <thead class="uk-text-left">
                                <tr style="background-color: #e1eaf1;">
                                    <td>
                                        <div style="border: 1px solid lightgray;margin-left: 25%;width: 30px;height: 15px;background-color: #cddae3;">
                                            <img src="../../images/bom_img/select.png"
                                                 style="width: 15px;width: 12px;margin-left: 16px;margin-top: 3px;">
                                        </div>

                                    </td>
                                    <td>订单编码</td>
                                    <td>订单名称</td>
                                    <td>产品名称</td>
                                    <td>优先级</td>
                                    <td>订单量</td>
                                    <td>完工延迟</td>
                                    <td>最早开工</td>
                                    <td>最晚终止</td>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="fixtable-body" style="height: 78%;">
                            <table class="uk-table uk-table-striped uk-table-hover " id="order">

                                <tbody class="uk-text-center">
                                </tbody>

                            </table>

                            <!--底部页码-->
                            <%--<div style="margin-top: -25px;">
                                <ul class="uk-pagination" style="margin-top: 7%;" data-uk-pagination="{currentPage:50}">
                                    <li>
                                        <button class="uk-button"
                                                style="background-image: url('../../images/bom_img/ye1.png');color: white;">
                                            <a href="" style="color: white;">首页</a></button>
                                    </li>
                                    <li>
                                        <button class="uk-button my"><a href="">上一页</a></button>
                                    </li>
                                    <li>
                                        <button class="uk-button my"><a href="">下一页</a></button>
                                    </li>
                                    <li>
                                        <button class="uk-button my"><a href="">尾页</a></button>
                                    </li>
                                    &lt;%&ndash;<li><a href="#">上一页</a></li>
                                    <li><a href="#">下一页</a></li>
                                    <li><a href="#">尾页</a></li>&ndash;%&gt;
                                    <li>共88页</li>&nbsp;
                                    <li>
                                        到第<input type="text" value="2" style="width: 28px;background-color: #EEF7FC;">页
                                    </li>
                                    <li>
                                        <button class="uk-button"
                                                style="background-image: url('../../images/bom_img/ye2.png');color: white;">
                                            确定
                                        </button>
                                    </li>
                                </ul>
                            </div>--%>
                        </div>

                    </div>

                    <br/>

                    <!--底部页码-->
                    <div style="margin-top: -25px;">
                        <ul class="uk-pagination" <%--style="margin-top: 7%;"--%> data-uk-pagination="{currentPage:50}">
                            <li><button class="uk-button" style="background-image: url('../../images/bom_img/ye1.png');color: white;"><a href="" style="color: white;">首页</a></button></li>
                            <li><button class="uk-button my"><a href="">上一页</a></button></li>
                            <li><button class="uk-button my"><a href="">下一页</a></button></li>
                            <li><button class="uk-button my"><a href="">尾页</a></button></li>
                            <li>共10页</li>&nbsp;
                            <li>
                                到第<input type="text" value="1" style="width: 28px;background-color: #EEF7FC;">页
                            </li>
                            <li>
                                <button class="uk-button" style="background-image: url('../../images/bom_img/ye2.png');color: white;">确定</button>
                            </li>
                        </ul>
                    </div>

                </div>

            </div>
        </div>


        <div class="uk-clearfix" style="margin-top: -3%;">
            <button class="uk-button uk-float-right " id="create-order"
                    style="background-image: url('../../images/kuaijie.png');background-size: 100% 100%;"
                    title="快捷菜单">
            </button>
            <div class=" uk-hidden uk-float-right" id="button">
                <div class="uk-panel uk-panel-box">
                    <div class="data-uk-button-radio">
                        <button class="uk-button" style="margin: 3px" data-uk-modal="{target:'#group'}">DAG面板</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--</div>--%>


<script>
    $(function () {
        $("#tabs").tabs();
    });
</script>

<script>
    $(".item-1").click(function () {
        $(this).parent().find(".nav-second").slideToggle(500);
        $(this).children("i").toggleClass("unfold");
    });
    $(".item-2").click(function () {
        $(this).parent().find(".nav-three").slideToggle(500);
        $(this).children("i").toggleClass("unfold");
    });
    /*$(".item-3").click(function () {
     $(this).parent().find(".nav-four").slideToggle(500);
     $(this).children("i").toggleClass("unfold");
     });*/

</script>

