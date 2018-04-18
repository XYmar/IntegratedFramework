package com.rengu.actions.aps;

import com.opensymphony.xwork2.ActionContext;
import com.rengu.DAO.aps.ErrorProcessDao;
import com.rengu.actions.SuperAction;
import com.rengu.util.ApsTools;
import com.rengu.util.Tools;

import java.sql.SQLException;
import java.util.Map;

/**
 * aps异常处理中心，处理工序、设备、紧急插单等异常
 * Created by wey580231 on 2017/6/15.
 */
public class ErrorProcessAction extends SuperAction {

    ErrorProcessDao dao = new ErrorProcessDao();

    //设备调整
    public void processDeviceError() throws SQLException, ClassNotFoundException {
        ActionContext context = ActionContext.getContext();
        Map<String, Object> parameterMap = context.getParameters();

        Integer result = ApsTools.UNKNOWN;

        if (parameterMap.size() == 1) {
            String[] id = (String[]) parameterMap.get("id");
            if (id.length == 1) {
                result = dao.processDeviceError(id[0]);
            }
        }

        if (result == ApsTools.STARTED) {
            Tools.jsonPrint(Tools.resultCode("ok", "Aps is computing..."), this.httpServletResponse);
        } else {
            Tools.jsonPrint(Tools.resultCode("error", "Can't execute operation"), this.httpServletResponse);
        }
    }

    //工序异常
    public void processProcessError() {
        ActionContext context = ActionContext.getContext();
        Map<String, Object> parameterMap = context.getParameters();

        Integer result = ApsTools.UNKNOWN;

        if (parameterMap.size() == 1) {
            String[] id = (String[]) parameterMap.get("id");
            if (id.length == 1) {
                result = dao.processProcessError(id[0]);
            }
        }

        if (result == ApsTools.STARTED) {
            Tools.jsonPrint(Tools.resultCode("ok", "Aps is computing..."), this.httpServletResponse);
        } else {
            Tools.jsonPrint(Tools.resultCode("error", "Can't execute operation"), this.httpServletResponse);
        }
    }

    //紧急插单
    public void processOrderError() {
        ActionContext context = ActionContext.getContext();
        Map<String, Object> parameterMap = context.getParameters();

        Integer result = ApsTools.UNKNOWN;

        if (parameterMap.size() == 1) {
            String[] id = (String[]) parameterMap.get("id");
            if (id.length == 1) {
                result = dao.processOrderError(id[0]);
            }
        }
        if (result == ApsTools.STARTED) {
            Tools.jsonPrint(Tools.resultCode("ok", "Aps is computing..."), this.httpServletResponse);
        } else {
            Tools.jsonPrint(Tools.resultCode("error", "Can't execute operation"), this.httpServletResponse);
        }
    }
}
