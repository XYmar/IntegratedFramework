package com.rengu.util;

import com.rengu.entity.*;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 通过SOCKET访问aps pomserver，获取APS的状态信息
 * Created by wey580231 on 2017/6/13.
 */
public class ApsTools {

    public static final int UNKNOWN = -1;
    public static final int IDLE = 0;
    public static final int BUSY_EXECUTE = 0;        //请求执行项目
    public static final int BUSY = 1;                //用于返回客户端查询服务器的状态
    public static final int STOPPED = 1;
    public static final int STARTED = 1;
    public static final int ALREADY = 2;
    public static final int FINISHED = 3;

    //aps部署的地址和端口号
    private static ApsTools apsTool = null;
    private final String replyApsAction = "/aps/updateProgress";
    private String apsHost;
    private int apsPort;

    //集成框架部署的地址和端口号
    private String localAddress;
    private String localPort;
    private String localProjectName;

    private ApsTools() {
        apsHost = Tools.getDatabaseProperties().getProperty("APSHost");
        apsPort = Integer.parseInt(Tools.getDatabaseProperties().getProperty("APSPort"));

        localAddress = Tools.getDatabaseProperties().getProperty("LocalAddress");
        localPort = Tools.getDatabaseProperties().getProperty("LocalPort");
        localProjectName = Tools.getDatabaseProperties().getProperty("LocalProjectName");
    }

    public static ApsTools instance() {
        if (apsTool == null) {
            synchronized (ApsTools.class) {
                if (apsTool == null) {
                    apsTool = new ApsTools();
                }
            }
        }
        return apsTool;
    }

    //TODO 待将连接修改成APS提供的访问连接
    public static String getAdjustOrderHandlingURL(RG_AdjustOrderEntity entity) {

        String result = "/NCL:RUN?Program=./Model/Interaction/Rescheduling/Order/AcceptOrder.n" +
                "&" +
                "BUFFER=1\\n2\\n" + "null" + "\\n001\\n2000-01-01\\t06:00:00\\n120\\n" + entity.getOrd().getId() + "\\n" + entity.getOrd().getName()
                + "\\n" + entity.getOrd().getQuantity() + "\\n" + entity.getOrd().getProductByIdProduct().getId() + "\\n" + entity.getOrd().getIdGroupResource() +
                "\\n1\\n" + ApsTools.instance().convertSpaceWithTab(Tools.formatToStandardDate(entity.getOrd().getT0())) + "\\n"
                + ApsTools.instance().convertSpaceWithTab(Tools.formatToStandardDate(entity.getOrd().getT1())) + "\\n"
                + ApsTools.instance().convertSpaceWithTab(Tools.formatToStandardDate(entity.getOrd().getT2())) +
                "&" +
                "REPLY=" + ApsTools.instance().getReplyAddress() +
                "&" +
                "ID=001" +
                "&" +
                "DELAY=1000";
        System.out.println("APS链接地址：" + result);
        return result;
    }

    //获取工序调整
    public static String getAdjustProcessHandlingURL(RG_AdjustProcessEntity entity) {

        String result = "/NCL:RUN?Program=./Model/Interaction/Rescheduling/Task/MoveTask.n" +
                "&" +
                "BUFFER=1\\n2\\n" + entity.getIdTask() + "\\n001\\n2000-01-01\\t06:00:00\\n120\\n1\\n6\\n" +
                entity.getIdJob() + "\\n" + entity.getIdOrder() + "\\n" + entity.getOriginalResource() + "\\n" + ApsTools.instance().convertSpaceWithTab(Tools.formatToStandardDate(entity.getOriginalStartTime()))
                + "\\n" + entity.getAppointResource() + "\\n" + ApsTools.instance().convertSpaceWithTab(Tools.formatToStandardDate(entity.getAppointStartTime())) +
                "&" +
                "REPLY=" + ApsTools.instance().getReplyAddress() +
                "&" +
                "ID=001" +
                "&" +
                "DELAY=1000";
        System.out.println("APS链接地址：" + result);
        return result;
    }

    //获取排程结果
    public static void getScheduleResult(RG_SnapshotNodeEntity bottomSnapshot) throws SQLException, ClassNotFoundException {
        String SQLString = "select * from APS_PLAN";
        List<?> list = Tools.executeSQLForList(DatabaseInfo.ORACLE, DatabaseInfo.APS, SQLString);
        System.out.println("APS_PLAN总计：" + list.size() + "个条目。");
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        for (Object object : list) {
//        for (int i = 0; i < 5; i++) {
            if (object instanceof HashMap) {
//            if (true) {
                RG_PlanEntity rg_planEntity = new RG_PlanEntity();
                Map tempMap = (HashMap) object;
                rg_planEntity.setId(Tools.getUUID());
                rg_planEntity.setIdTask(tempMap.get("IDTASK").toString());
                rg_planEntity.setIdJob(tempMap.get("IDJOB").toString());
                rg_planEntity.setNameTask(tempMap.get("NAMETASK").toString());
                rg_planEntity.setNameOrder(tempMap.get("NAMEORDER").toString());
                rg_planEntity.setNameJob(tempMap.get("NAMEJOB").toString());
                rg_planEntity.setNameResource(tempMap.get("NAMERESOURCE").toString());
                rg_planEntity.setNameGroupResource(tempMap.get("NAMEGROUPRESOURCE").toString());
                rg_planEntity.setNameTypeResource(tempMap.get("NAMETYPERESOURCE").toString());
                rg_planEntity.setNameSite(tempMap.get("NAMESITE").toString());
                rg_planEntity.setNameProvider(tempMap.get("NAMEPROVIDER").toString());
                rg_planEntity.setOrdToParentTask(Short.parseShort(tempMap.get("ORDTOPARENTTASK").toString()));
//                rg_planEntity.setIdTaskResourceSucc(tempMap.get("IDTASKRESOURCESUCC").toString());
                rg_planEntity.setPreemptiveTask(tempMap.get("PREEMPTIVETASK").toString());
                rg_planEntity.setDivisibleTask(tempMap.get("DIVISIBLETASK").toString());
                rg_planEntity.setContinuousTask(tempMap.get("CONTINUOUSTASK").toString());
                rg_planEntity.setQuantityTask(Short.parseShort(tempMap.get("QUANTITYTASK").toString()));
                rg_planEntity.setQuantityResourceTask(Short.parseShort(tempMap.get("QUANTITYRESOURCETASK").toString()));
                rg_planEntity.setQuantityBatchTask(Short.parseShort(tempMap.get("QUANTITYBATCHTASK").toString()));
                rg_planEntity.setQtySequence(Short.parseShort(tempMap.get("QTYSEQUENCE").toString()));
                rg_planEntity.setT1Task(tempMap.get("T1TASK").toString());
                rg_planEntity.setT2Task(tempMap.get("T2TASK").toString());
                rg_planEntity.setT2ExtendedTask(tempMap.get("T2EXTENDEDTASK").toString());
//                rg_planEntity.setAdvice(tempMap.get("ADVICE").toString());
                rg_planEntity.setEstimateTask(tempMap.get("ESTIMATETASK").toString());
                rg_planEntity.setTimeTask(tempMap.get("TIMETASK").toString());
                rg_planEntity.setInitTimeTask(tempMap.get("INITTIMETASK").toString());
                rg_planEntity.setUnitTimeTask(tempMap.get("UNITTIMETASK").toString());
                rg_planEntity.setPostTimeTask(tempMap.get("POSTTIMETASK").toString());
                rg_planEntity.setCheckTimeTask(tempMap.get("CHECKTIMETASK").toString());
//                rg_planEntity.setIdGroupResource0Task(tempMap.get("IDGROUPRESOURCE0TASK").toString());
//                rg_planEntity.setIdResource0Task(tempMap.get("IDRESOURCE0TASK").toString());
//                rg_planEntity.setIdSite0Task(tempMap.get("IDSITE0TASK").toString());
                rg_planEntity.setQuantity0Task(Short.parseShort(tempMap.get("QUANTITY0TASK").toString()));
//                rg_planEntity.setT10Task(tempMap.get("T10TASK").toString());
//                rg_planEntity.setT20Task(tempMap.get("T20TASK").toString());
//                rg_planEntity.setT20ExtendedTask(tempMap.get("T20EXTENDEDTASK").toString());
                rg_planEntity.setT1Job(tempMap.get("T1JOB").toString());
                rg_planEntity.setT2Job(tempMap.get("T2JOB").toString());
                rg_planEntity.setQuantityJob(Short.parseShort(tempMap.get("QUANTITYJOB").toString()));
                rg_planEntity.setNbTaskJob(Short.parseShort(tempMap.get("NBTASKJOB").toString()));
                rg_planEntity.setRefProductJob(tempMap.get("REFPRODUCTJOB").toString());
                rg_planEntity.setOrdToRootJob(Short.parseShort(tempMap.get("ORDTOROOTJOB").toString()));
//                rg_planEntity.setOrdToRootChildJob(tempMap.get("ORDTOROOTCHILDJOB").toString());
                rg_planEntity.setT1Order(tempMap.get("T1ORDER").toString());
                rg_planEntity.setT2Order(tempMap.get("T2ORDER").toString());
                rg_planEntity.setQuantityOrder(Short.parseShort(tempMap.get("QUANTITYORDER").toString()));
                rg_planEntity.setPriorityOrder(Short.parseShort(tempMap.get("PRIORITYORDER").toString()));
//                rg_planEntity.setColorOrder(tempMap.get("COLORORDER").toString());
                rg_planEntity.setState(Byte.parseByte(tempMap.get("STATE").toString()));
                rg_planEntity.setProcessByIdProcess(session.get(RG_ProcessEntity.class, tempMap.get("IDPROCESS").toString()));
                rg_planEntity.setOrderByIdOrder(session.get(RG_OrderEntity.class, tempMap.get("IDORDER").toString()));
                rg_planEntity.setResourceByIdResource(session.get(RG_ResourceEntity.class, tempMap.get("IDRESOURCE").toString()));
                rg_planEntity.setClubByIdClub(session.get(RG_ClubEntity.class, tempMap.get("IDCLUB").toString()));
                rg_planEntity.setSiteByIdSite(session.get(RG_SiteEntity.class, tempMap.get("IDSITE").toString()));
                rg_planEntity.setTyperescourceByIdTypeResource(session.get(RG_TyperescourceEntity.class, tempMap.get("IDGROUPRESOURCE").toString()));
                rg_planEntity.setGroupresourceByIdGroupResource(session.get(RG_GroupresourceEntity.class, tempMap.get("IDTYPERESOURCE").toString()));
                rg_planEntity.setProviderByIdProvider(session.get(RG_ProviderEntity.class, tempMap.get("IDPROVIDER").toString()));
                //Snapshot
                if (bottomSnapshot != null) {
                    bottomSnapshot.getPlans().add(rg_planEntity);

                    rg_planEntity.setSnapShort(bottomSnapshot);
                }

                session.save(rg_planEntity);
            }
        }
        System.out.println("APS_PLAN 表同步完成");
    }

    //设备资源取消
    public String getCancelDeviceURL(RG_AdjustDeviceEntity entity) {
        String result = "/NCL:RUN?Program=./Model/Interaction/Rescheduling/Resource/RejectResource.n" +
                "&" +
                "BUFFER=1\\n2\\n" + entity.getResoureId() + "\\n001\\n2000-01-01\\t06:00:00\\n120\\n"
                + convertSpaceWithTab(entity.getCancelTime()) + "\\n" + convertSpaceWithTab(entity.getLatestCancelTime()) +
                "&" +
                "REPLY=" + ApsTools.instance().getReplyAddress() +
                "&" +
                "ID=001" +
                "&" +
                "DELAY=1000";
        System.out.println("APS链接地址：" + result);
        return result;
    }

    //设备资源不可用aps请求连接
    public String getUnavailableDeviceURL(RG_AdjustDeviceEntity entity) {
        String result = "/NCL:RUN?Program=./Model/Interaction/Rescheduling/Resource/ModifyResourceTimeGantt.n" +
                "&" +
                "BUFFER=1\\n2\\n" + entity.getResoureId() + "\\n001\\n2000-01-01\\t06:00\\n120\\n" + entity.getUnavailableStartTime()
                + "\\n" + entity.getUnavailableEndTime() + "\\n1\\n2\\n" + convertSpaceWithTab(entity.getUnavailableStartDate()) + "\\n" + convertSpaceWithTab(entity.getUnavailableEndDate()) +
                "&" +
                "REPLY=" + ApsTools.instance().getReplyAddress() +
                "&" +
                "ID=001" +
                "&" +
                "DELAY=1000\n";
        System.out.println("APS链接地址：" + result);
        return result;
    }

    //将字符转中包含的\s替换成\t
    private String convertSpaceWithTab(String source) {
        source = source.trim();

        Pattern pattern = Pattern.compile("(\\s)+|\t|\r|\n");
        Matcher match = pattern.matcher(source);

        return match.replaceAll("\\\\t");
    }

    //拼接请求命令
    private String combineCommand(String requestURL) {
        StringBuffer requestHeader = new StringBuffer();
        requestHeader
                .append("GET " + requestURL + " HTTP/1.1\n")
                .append("HOST: " + apsHost + ":" + apsPort + " " + "\n")
                .append("Accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n")
                .append("Accept-Encoding:gzip, deflate, sdch\n")
                .append("Accept-Language:zh-CN,zh;q=0.8\n")
                .append("Cache-Control:no-cache\n")
                .append("User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:53.0) Gecko/20100101 Firefox/53.0\n")
                .append("Encoding:UTF-8\n")
                .append("Connection:keep-alive" + "\n").append("\n");

        return requestHeader.toString();
    }

    //执行请求
    private String execute(String command) {
        StringBuffer result = new StringBuffer();
        Socket socket = null;
        BufferedReader breader = null;
        OutputStream os = null;
        try {
            socket = new Socket(apsHost, apsPort);
            breader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            os = socket.getOutputStream();

            os.write(combineCommand(command).getBytes());
            os.flush();
            String oneline = null;

            while ((oneline = breader.readLine()) != null) {
                result.append(oneline).append("\n");
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (os != null) {
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (breader != null) {
                try {
                    breader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (socket != null) {
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return result.toString().toLowerCase();
    }

    //请求执行项目
    public int executeCommand(String command) {
        String result = execute(command);
        if (result.contains("finished")) {
            return ApsTools.FINISHED;
        } else if (result.contains("already")) {
            return ApsTools.ALREADY;
        } else if (result.contains("started")) {
            return ApsTools.STARTED;
        } else if (result.contains("busy")) {
            return ApsTools.BUSY_EXECUTE;
        }

        return ApsTools.UNKNOWN;
    }

    //客户端查询PoemServer当前运行状态
    public int queryExecuteState() {
        String result = execute("/NCL:STATE");
        if (result.contains("busy")) {
            return ApsTools.BUSY;
        } else if (result.contains("idle")) {
            return ApsTools.IDLE;
        }
        return ApsTools.UNKNOWN;
    }

    //客户端请求终止PoemServer运行
    public int requestStopExecute() {
        String result = execute("/NCL:STOP");
        if (result.contains("stopped")) {
            return ApsTools.STOPPED;
        } else if (result.contains("idle")) {
            return ApsTools.IDLE;
        }
        return ApsTools.UNKNOWN;
    }

    public int startAPSSchedule(String middleId) {
        String cmd = "/NCL:RUN?Program=./Model/Script/ScriptAutoScheduling.n" +
                "&" +
                "REPLY=" + getReplyAddress() +
                "&" +
                "ID=" + middleId + "" +
                "&" +
                "DELAY=1000000" +
                "&" +
                "buffer=001";

        return executeCommand(cmd);
    }

    //获取aps计算完后返回结果地址
    public String getReplyAddress() {
        return localAddress + ":" + localPort + localProjectName + replyApsAction;
    }

    //tomcat启动时根据当前排程信息来
    public void resetApsDatabase() {
        Session session = MySessionFactory.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        NativeQuery query = session.createNativeQuery("select resetApsTable from rg_userconfig where idUser = ?");
        query.setParameter(1, "1");
        List lists = query.getResultList();
        if (lists.size() == 1) {
            boolean flag = (boolean) lists.get(0);
            if (flag) {
                //TODO 待清空Oracle数据中job、task、plan、log、order表
                String[] tableNames = {DatabaseInfo.APS_JOB, DatabaseInfo.APS_TASK, DatabaseInfo.APS_PLAN, DatabaseInfo.APS_LOG, DatabaseInfo.APS_ORDER};
                try {
                    Tools.executeSQLForInitTable(DatabaseInfo.ORACLE, DatabaseInfo.APS, tableNames);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                query = session.createNativeQuery("update rg_userconfig set resetApsTable = ? where iduser = ? ");
                query.setParameter(1, false);
                query.setParameter(2, "1");
                query.executeUpdate();
            }
        }
        tx.commit();
        session.close();
    }
}
