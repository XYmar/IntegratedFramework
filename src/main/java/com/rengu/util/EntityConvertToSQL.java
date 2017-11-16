package com.rengu.util;

import com.rengu.entity.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by hanchangming on 2017/5/27.
 */
public class EntityConvertToSQL {
    public static String updateAPSConfigSQL(String name, String value) {
        String SQLString = "UPDATE " + DatabaseInfo.APS_CONGIF + " SET value='" + value + "' WHERE name='" + name + "'";
        return SQLString;
    }

    public static String updateSQLForAPS(RG_OrderEntity rg_orderEntity) {
        String SQLString = "update " + DatabaseInfo.APS_ORDER + " set name = '" + rg_orderEntity.getName() + "',idclub = '" + rg_orderEntity.getClubByIdClub().getId() + "',priority = '" + rg_orderEntity.getPriority() + "',IDPRODUCT = '" + rg_orderEntity.getProductByIdProduct().getId() + "',quantity = '" + rg_orderEntity.getQuantity() + "', t0 = '" + Tools.dateConvertToString(rg_orderEntity.getT0()) + "',t1 = '" + Tools.dateConvertToString(rg_orderEntity.getT1()) + "',t2 = '" + Tools.dateConvertToString(rg_orderEntity.getT2()) + "',color = '" + rg_orderEntity.getColor() + "',state = '" + "0" + "' where id = '" + rg_orderEntity.getId() + "'";
        return SQLString;
    }

    public static String insertSQLForAPS(RG_OrderEntity rg_orderEntity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_ORDER + " (id,name,IDCLUB,priority,IDPRODUCT,quantity,t0,t1,t2,color,state) VALUES ('" + rg_orderEntity.getId()
                + "','" + rg_orderEntity.getName()
                + "','" + rg_orderEntity.getClubByIdClub().getId()
                + "'," + rg_orderEntity.getPriority()
                + ",'" + rg_orderEntity.getProductByIdProduct().getId()
                + "'," + rg_orderEntity.getQuantity()
                + ",'" + Tools.dateConvertToString(rg_orderEntity.getT0())
                + "','" + Tools.dateConvertToString(rg_orderEntity.getT1())
                + "','" + Tools.dateConvertToString(rg_orderEntity.getT2())
                + "','" + rg_orderEntity.getColor()
                + "'," + 0 + ")";   //rg_orderEntity.getState()
        return SQLString;
    }

    //简化模型process
    public static String insertSQLForAPS(ApsProcess1Entity apsProcess1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_PROCESS + " VALUES ('" + apsProcess1Entity.getId()
                + "','" + apsProcess1Entity.getName()
                + "','" + apsProcess1Entity.getIdProduct()
                + "','" + apsProcess1Entity.getIdParent()
                + "','" + apsProcess1Entity.getIdPrec()
                + "','" + apsProcess1Entity.getIdSucc()
                + "'," + apsProcess1Entity.getMinTimeSucc()
                + "," + apsProcess1Entity.getMaxTimeSucc()
                + "," + apsProcess1Entity.getOrdToParent()
                + ",'" + apsProcess1Entity.getSlot1()
                + "','" + apsProcess1Entity.getSlot2()
                + "'," + apsProcess1Entity.getInitTime()
                + "," + apsProcess1Entity.getUnitTime()
                + "," + apsProcess1Entity.getPostTime()
                + "," + apsProcess1Entity.getCheckTime()
                + "," + apsProcess1Entity.getDelta()
                + "," + apsProcess1Entity.getEstimate()
                + ",'" + apsProcess1Entity.getContinuous()
                + "'," + apsProcess1Entity.getQuantity()
                + "," + apsProcess1Entity.getMinQtySwitch()
                + "," + apsProcess1Entity.getMaxQtySwitch()
                + "," + apsProcess1Entity.getApsSwitch()
                + "," + apsProcess1Entity.getMaxResourceDivision()
                + "," + apsProcess1Entity.getMinTimeDivision()
                + "," + apsProcess1Entity.getMinQtyDivision()
                + "," + apsProcess1Entity.getMinQtyBatch()
                + "," + apsProcess1Entity.getMinTimeBatch()
                + ",'" + apsProcess1Entity.getIdCoupledGroupResource()
                + "','" + apsProcess1Entity.getIdCoupledTypeShift()
                + "'," + apsProcess1Entity.getOrdToRoot()
                + ",'" + apsProcess1Entity.getOrdToRootChild()
                + "','" + apsProcess1Entity.getIdRoot()
                + "','" + apsProcess1Entity.getIdExclusive()
                + "','" + apsProcess1Entity.getIdCoupledResource()
                + "'," + apsProcess1Entity.getTypeShift()
                + ",'" + apsProcess1Entity.getIdPrecSwitch()
                + "'," + apsProcess1Entity.getMaxQtyDivision()
                + "," + apsProcess1Entity.getMaxTimeDivision()
                + "," + apsProcess1Entity.getMaxQtyBatch()
                + "," + apsProcess1Entity.getMaxTimeBatch()
                + ",'" + apsProcess1Entity.getPreemptive()
                + "','" + apsProcess1Entity.getExclusiveJob()
                + "','" + apsProcess1Entity.getExclusiveOrder()
                + "','" + apsProcess1Entity.getCoupledTypeOrder()
                + "','" + apsProcess1Entity.getIdCoupled()
                + "','" + apsProcess1Entity.getIdCoupledShift()
                + "','" + apsProcess1Entity.getIdCoupledTypeResource()
                + "','" + apsProcess1Entity.getIdCoupledTypeSite()
                + "','" + apsProcess1Entity.getIdCoupledSite()
                + "'," + null
                + "," + apsProcess1Entity.getUnitQuantity()
                + ",'" + apsProcess1Entity.getIdIcon()
                + "'," + apsProcess1Entity.getModQtySwitch()
                + ",'" + apsProcess1Entity.getBatch()
                + "'," + apsProcess1Entity.getModQtyBatch()
                + "," + apsProcess1Entity.getModResourceDivision()
                + "," + apsProcess1Entity.getModTimeBatch()
                + "," + apsProcess1Entity.getModQtyDivision()
                + "," + apsProcess1Entity.getModTimeDivision()
                + "," + apsProcess1Entity.getMinResourceDivision()
                + "," + apsProcess1Entity.getNbTask()
                + ",'" + apsProcess1Entity.getIdTypeResourceNext()
                + "','" + apsProcess1Entity.getIdNextResource()
                + "','" + apsProcess1Entity.getColor()
                + "')";
        return SQLString;
    }

    //细化模型process
    public static String insertSQLForAPS(ApsProcess2Entity apsProcess1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_PROCESS + " VALUES ('" + apsProcess1Entity.getId()
                + "','" + apsProcess1Entity.getName()
                + "','" + apsProcess1Entity.getIdProduct()
                + "','" + apsProcess1Entity.getIdParent()
                + "','" + apsProcess1Entity.getIdPrec()
                + "','" + apsProcess1Entity.getIdSucc()
                + "'," + apsProcess1Entity.getMinTimeSucc()
                + "," + apsProcess1Entity.getMaxTimeSucc()
                + "," + apsProcess1Entity.getOrdToParent()
                + ",'" + apsProcess1Entity.getSlot1()
                + "','" + apsProcess1Entity.getSlot2()
                + "'," + apsProcess1Entity.getInitTime()
                + "," + apsProcess1Entity.getUnitTime()
                + "," + apsProcess1Entity.getPostTime()
                + "," + apsProcess1Entity.getCheckTime()
                + "," + apsProcess1Entity.getDelta()
                + "," + apsProcess1Entity.getEstimate()
                + ",'" + apsProcess1Entity.getContinuous()
                + "'," + apsProcess1Entity.getQuantity()
                + "," + apsProcess1Entity.getMinQtySwitch()
                + "," + apsProcess1Entity.getMaxQtySwitch()
                + "," + apsProcess1Entity.getApsSwitch()
                + "," + apsProcess1Entity.getMaxResourceDivision()
                + "," + apsProcess1Entity.getMinTimeDivision()
                + "," + apsProcess1Entity.getMinQtyDivision()
                + "," + apsProcess1Entity.getMinQtyBatch()
                + "," + apsProcess1Entity.getMinTimeBatch()
                + ",'" + apsProcess1Entity.getIdCoupledGroupResource()
                + "','" + apsProcess1Entity.getIdCoupledTypeShift()
                + "'," + apsProcess1Entity.getOrdToRoot()
                + ",'" + apsProcess1Entity.getOrdToRootChild()
                + "','" + apsProcess1Entity.getIdRoot()
                + "','" + apsProcess1Entity.getIdExclusive()
                + "','" + apsProcess1Entity.getIdCoupledResource()
                + "'," + apsProcess1Entity.getTypeShift()
                + ",'" + apsProcess1Entity.getIdPrecSwitch()
                + "'," + apsProcess1Entity.getMaxQtyDivision()
                + "," + apsProcess1Entity.getMaxTimeDivision()
                + "," + apsProcess1Entity.getMaxQtyBatch()
                + "," + apsProcess1Entity.getMaxTimeBatch()
                + ",'" + apsProcess1Entity.getPreemptive()
                + "','" + apsProcess1Entity.getExclusiveJob()
                + "','" + apsProcess1Entity.getExclusiveOrder()
                + "','" + apsProcess1Entity.getCoupledTypeOrder()
                + "','" + apsProcess1Entity.getIdCoupled()
                + "','" + apsProcess1Entity.getIdCoupledShift()
                + "','" + apsProcess1Entity.getIdCoupledTypeResource()
                + "','" + apsProcess1Entity.getIdCoupledTypeSite()
                + "','" + apsProcess1Entity.getIdCoupledSite()
                + "'," + null
                + "," + apsProcess1Entity.getUnitQuantity()
                + ",'" + apsProcess1Entity.getIdIcon()
                + "'," + apsProcess1Entity.getModQtySwitch()
                + ",'" + apsProcess1Entity.getBatch()
                + "'," + apsProcess1Entity.getModQtyBatch()
                + "," + apsProcess1Entity.getModResourceDivision()
                + "," + apsProcess1Entity.getModTimeBatch()
                + "," + apsProcess1Entity.getModQtyDivision()
                + "," + apsProcess1Entity.getModTimeDivision()
                + "," + apsProcess1Entity.getMinResourceDivision()
                + "," + apsProcess1Entity.getNbTask()
                + ",'" + apsProcess1Entity.getIdTypeResourceNext()
                + "','" + apsProcess1Entity.getIdNextResource()
                + "','" + apsProcess1Entity.getColor()
                + "')";
        return SQLString;
    }

    //简化模型typeresource
    public static String insertSQLForAPS(ApsTyperesource1Entity apsTyperesource1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_TYPERESOURCE + " VALUES ('" + apsTyperesource1Entity.getId()
                + "'," + apsTyperesource1Entity.getRatio()
                + ",'" + apsTyperesource1Entity.getName()
                + "')";
        return SQLString;
    }

    //细化模型typeresource
    public static String insertSQLForAPS(ApsTyperesource2Entity apsTyperesource1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_TYPERESOURCE + " VALUES ('" + apsTyperesource1Entity.getId()
                + "'," + apsTyperesource1Entity.getRatio()
                + ",'" + apsTyperesource1Entity.getName()
                + "')";
        return SQLString;
    }

    //简化模型apsTyperesourceSite
    public static String insertSQLForAPS(ApsProcessTyperesourceSite1Entity apsProcessTyperesource1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_PROCESS_TYPERESOURCE_SITE + " VALUES ('" + apsProcessTyperesource1Entity.getIdProcess()
                + "','" + apsProcessTyperesource1Entity.getIdTypeResource()
                + "'," + apsProcessTyperesource1Entity.getMinResource()
                + "," + apsProcessTyperesource1Entity.getMaxResource()
                + ",'" + apsProcessTyperesource1Entity.getModResource()
                + "'," + apsProcessTyperesource1Entity.getGrp()
                + "," + apsProcessTyperesource1Entity.getWeightParallel()
                + "," + apsProcessTyperesource1Entity.getWeightSequence()
                + ",'" + apsProcessTyperesource1Entity.getTypeSite()
                + "','" + apsProcessTyperesource1Entity.getIdSite()
                + "','" + apsProcessTyperesource1Entity.getSiteInGroupResource()
                + "','" + apsProcessTyperesource1Entity.getPrimaryForTime()
                + "','" + apsProcessTyperesource1Entity.getPrimaryForNext()
                + "')";
        return SQLString;
    }

    //细化模型apsTyperesourceSite
    public static String insertSQLForAPS(ApsProcessTyperesourceSite2Entity apsProcessTyperesource1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_PROCESS_TYPERESOURCE_SITE + " VALUES ('" + apsProcessTyperesource1Entity.getIdProcess()
                + "','" + apsProcessTyperesource1Entity.getIdTypeResource()
                + "'," + apsProcessTyperesource1Entity.getMinResource()
                + "," + apsProcessTyperesource1Entity.getMaxResource()
                + ",'" + apsProcessTyperesource1Entity.getModResource()
                + "'," + apsProcessTyperesource1Entity.getGrp()
                + "," + apsProcessTyperesource1Entity.getWeightParallel()
                + "," + apsProcessTyperesource1Entity.getWeightSequence()
                + ",'" + apsProcessTyperesource1Entity.getTypeSite()
                + "','" + apsProcessTyperesource1Entity.getIdSite()
                + "','" + apsProcessTyperesource1Entity.getSiteInGroupResource()
                + "','" + apsProcessTyperesource1Entity.getPrimaryForTime()
                + "','" + null
                + "')";
        return SQLString;
    }

    //简化模型resource
    public static String insertSQLForAPS(ApsResource1Entity apsResource1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_RESOURCE + " VALUES ('" + apsResource1Entity.getId()
                + "','" + apsResource1Entity.getName()
                + "','" + apsResource1Entity.getIdTypeResource()
                + "','" + apsResource1Entity.getIdFeatureResource()
                + "','" + apsResource1Entity.getCritical()
                + "','" + apsResource1Entity.getIdShift()
                + "','" + apsResource1Entity.getDateForbidden()
                + "'," + null
                + "," + apsResource1Entity.getRate()
                + ",'" + apsResource1Entity.getColor()
                + "'," + apsResource1Entity.getState()
                + ",'" + apsResource1Entity.getWeekend()
                + "','" + apsResource1Entity.getCalendar()
                + "','" + apsResource1Entity.getIdGroupResource()
                + "','" + apsResource1Entity.getIdSite()
                + "'," + apsResource1Entity.getMobility()
                + ",'" + apsResource1Entity.getNameShift()
                + "','" + apsResource1Entity.getSlot()
                + "','" + apsResource1Entity.getIdIcon()
                + "','" + apsResource1Entity.getTypeSite()
                + "','" + apsResource1Entity.getIdSite0()
                + "','" + apsResource1Entity.getIdUser()
                + "','" + apsResource1Entity.getIdSiteGroupResource()
                + "'," + null
                + "," + null
                + "," + null
                + "," + null
                + ",'" + apsResource1Entity.getIdSiteSequence()
                + "'," + apsResource1Entity.getQuantity0()
                + "," + apsResource1Entity.getSizeIcon()
                + ",'" + apsResource1Entity.getIdClub()
                + "','" + apsResource1Entity.getUnit()
                + "','" + apsResource1Entity.getMakespan()
                + "','" + apsResource1Entity.getSameTypeSequence()
                + "')";
        return SQLString;
    }

    //细化模型resource
    public static String insertSQLForAPS(ApsResource2Entity apsResource1Entity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_RESOURCE + " VALUES ('" + apsResource1Entity.getId()
                + "','" + apsResource1Entity.getName()
                + "','" + apsResource1Entity.getIdTypeResource()
                + "','" + apsResource1Entity.getIdFeatureResource()
                + "','" + apsResource1Entity.getCritical()
                + "','" + apsResource1Entity.getIdShift()
                + "','" + apsResource1Entity.getDateForbidden()
                + "'," + null
                + "," + apsResource1Entity.getRate()
                + ",'" + apsResource1Entity.getColor()
                + "'," + apsResource1Entity.getState()
                + ",'" + apsResource1Entity.getWeekend()
                + "','" + apsResource1Entity.getCalendar()
                + "','" + apsResource1Entity.getIdGroupResource()
                + "','" + apsResource1Entity.getIdSite()
                + "'," + apsResource1Entity.getMobility()
                + ",'" + apsResource1Entity.getNameShift()
                + "','" + apsResource1Entity.getSlot()
                + "','" + apsResource1Entity.getIdIcon()
                + "','" + apsResource1Entity.getTypeSite()
                + "','" + apsResource1Entity.getIdSite0()
                + "','" + apsResource1Entity.getIdUser()
                + "','" + apsResource1Entity.getIdSiteGroupResource()
                + "'," + null
                + "," + null
                + "," + null
                + "," + null
                + ",'" + apsResource1Entity.getIdSiteSequence()
                + "'," + apsResource1Entity.getQuantity0()
                + "," + apsResource1Entity.getSizeIcon()
                + ",'" + apsResource1Entity.getIdClub()
                + "','" + apsResource1Entity.getUnit()
                + "','" + apsResource1Entity.getMakespan()
                + "','" + apsResource1Entity.getSameTypeSequence()
                + "')";
        return SQLString;
    }

    public static String insertSQLForAPS(RG_ResourceEntity rg_resourceEntity) throws SQLException, ClassNotFoundException {
        //拼接IdTypeResource集合
        StringBuffer idTypeResourceBuff = new StringBuffer();

        idTypeResourceBuff.append("{");
        Iterator<RG_TyperescourceEntity> rg_typerescourceEntityIterator = rg_resourceEntity.getTyperesourcesById().iterator();
        while (rg_typerescourceEntityIterator.hasNext()) {
            RG_TyperescourceEntity rg_typerescourceEntity = rg_typerescourceEntityIterator.next();
            if (rg_typerescourceEntityIterator.hasNext()) {
                idTypeResourceBuff.append("\"" + rg_typerescourceEntity.getId() + "\",\"");
            } else {
                idTypeResourceBuff.append("\"" + rg_typerescourceEntity.getId() + "\"");
            }
        }
        idTypeResourceBuff.append("}");
        //拼接IdSite集合

        StringBuffer IdSiteBuff = new StringBuffer();
        IdSiteBuff.append("{");
        Iterator<RG_SiteEntity> rg_siteEntityIterator = rg_resourceEntity.getSitesById().iterator();
        while (rg_siteEntityIterator.hasNext()) {
            RG_SiteEntity rg_siteEntity = rg_siteEntityIterator.next();
            if (rg_siteEntityIterator.hasNext()) {
                IdSiteBuff.append("\"" + rg_siteEntity.getId() + "\",\"");
            } else {
                IdSiteBuff.append("\"" + rg_siteEntity.getId() + "\"");
            }
        }
        IdSiteBuff.append("}");

        //拼接IdShift集合
        StringBuffer IdShiftBuff = new StringBuffer();

        IdShiftBuff.append("{");
        Iterator<RG_ShiftEntity> rg_shiftEntityIterator = rg_resourceEntity.getShiftsById().iterator();
        while (rg_shiftEntityIterator.hasNext()) {
            RG_ShiftEntity rg_shiftEntity = rg_shiftEntityIterator.next();
            if (rg_shiftEntityIterator.hasNext()) {
                IdShiftBuff.append("\"" + rg_shiftEntity.getId() + "\",\"");
            } else {
                IdShiftBuff.append("\"" + rg_shiftEntity.getId() + "\"");
            }
        }
        IdShiftBuff.append("}");
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_RESOURCE + " (id,name,IdTypeResource,idGroupResource,IdSite,mobility,critical,IdShift,NameShift,RATE,COLOR,STATE,CALENDAR,SLOT,IDICON,IDSITE0,QUANTITY0,SIZEICON,IDCLUB,WEEKEND,MAKESPAN) VALUES ('"
                + rg_resourceEntity.getIdR() + "','"
                + rg_resourceEntity.getName() + "','"
                + idTypeResourceBuff.toString() + "','"
                + rg_resourceEntity.getGroupresourceByIdGroupResource().getId() + "','"
                + IdSiteBuff.toString() + "'," + rg_resourceEntity.getMobility() + ",'"
                + rg_resourceEntity.getCritical() + "','"
                + IdShiftBuff.toString() + "','"
                + rg_resourceEntity.getNameShift() + "',"
                + rg_resourceEntity.getRate() + ",'"
                + rg_resourceEntity.getColor() + "',"
                + rg_resourceEntity.getState() + ",'"
                + rg_resourceEntity.getCalendar() + "','"
                + rg_resourceEntity.getSlot() + "','"
                + rg_resourceEntity.getIdIcon() + "','"
                + rg_resourceEntity.getIdSite0() + "',"
                + rg_resourceEntity.getQuantity0() + ",'"
                + rg_resourceEntity.getSizeIcon() + "','"
                + rg_resourceEntity.getClubByIdClub().getId() + "','"
                + rg_resourceEntity.getWeekend() + "','"
                + rg_resourceEntity.getMakespan() + "')";
        return SQLString;
    }

    public static String insertSQLForAPS_APS_RESOURCE_TYPERESOURCE(String resourceId, String typeResourceId) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_RESOURCE_TYPERESOURCE +
                " (idResource,idTypeResource,maxCapacityParallel,capacitySequence,delaySequence) VALUES ('" + resourceId
                + "','" + typeResourceId
                + "'," + 1
                + "," + 1
                + "," + 0 + ")";
        return SQLString;
    }

    public static String insertSQLForAPS(RG_GroupresourceEntity rg_groupresourceEntity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_GROUPRESOURCE +
                " (id,name,IdSite,idSite0,idProvider,idClub,color) VALUES ('" + rg_groupresourceEntity.getId()
                + "','" + rg_groupresourceEntity.getName()
                + "','" + rg_groupresourceEntity.getIdSite()
                + "','" + rg_groupresourceEntity.getIdSite0()
                + "','" + rg_groupresourceEntity.getProviderByIdProvider().getId()
                + "','" + rg_groupresourceEntity.getProviderByIdProvider().getClubByIdClub().getId()
                + "','" + rg_groupresourceEntity.getColor() + "');";
        return SQLString;
    }

    public static String insertSQLForAPS(RG_SiteEntity rg_siteEntity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_SITE + " (id,name,type,x,y,color,idIcon,sizeIcon,capacity) VALUES ('"
                + rg_siteEntity.getId() + "','"
                + rg_siteEntity.getName() + "','"
                + rg_siteEntity.getType() + "',"
                + rg_siteEntity.getX() + ","
                + rg_siteEntity.getY() + ",'"
                + rg_siteEntity.getColor() + "','"
                + rg_siteEntity.getIdIcon() + "',"
                + rg_siteEntity.getSizeIcon() + ","
                + rg_siteEntity.getCapacity() + ")";
        return SQLString;
    }

    public static String insertSQLForAPS(RG_TyperescourceEntity rg_typerescourceEntity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_TYPERESOURCE + " (id,name,attribute) VALUES ('" + rg_typerescourceEntity.getId() + "','" + rg_typerescourceEntity.getName() + "','" + rg_typerescourceEntity.getAttribute() + "');";
        return SQLString;
    }

    /*public static String insertSQLForAPS(RG_ShiftEntity rg_shiftEntity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_SHIFT + " (id,name,type,Slot) VALUES ('" + rg_shiftEntity.getId() + "','" + rg_shiftEntity.getName() + "','" + rg_shiftEntity.getType() + "','" + rg_shiftEntity.getSlot() + "');";
        return SQLString;
    }*/

    public static String insertSQLForAPS(RG_ShiftEntity rg_shiftEntity) {
        String SQLString = "INSERT INTO " + DatabaseInfo.APS_SHIFT + " (id,name,Slot) VALUES ('" + rg_shiftEntity.getId() + "','" + rg_shiftEntity.getName() + "','" + rg_shiftEntity.getSlot() + "')";
        return SQLString;
    }

    private static List getListFromHashMap(String stringList) {
        List list = new ArrayList();
        stringList = stringList.replace("{", "");
        stringList = stringList.replace("}", "");
        String[] stringLists = stringList.split(",");
        for (String s : stringLists) {
            s = s.replaceAll("\"", "");
            list.add(s);
        }
        return list;
    }
}
