package com.rengu.DAO.impl;

import com.rengu.DAO.TyperescourceDAO;
import com.rengu.entity.RG_TyperescourceEntity;
import com.rengu.util.MySessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hanchangming on 2017/5/31.
 */
public class TyperescourceDAOImpl extends SuperDAOImpl implements TyperescourceDAO<RG_TyperescourceEntity> {
    @Override
    public List<RG_TyperescourceEntity> findAll() {

        /*List tableList = new ArrayList();
        tableList.add("APS_TYPERESOURCE");
        SyncAPSTable(tableList,"ORACLE","APS_TYPERESOURCE");*/

        MySessionFactory.getSessionFactory().getCurrentSession().close();
        Session session = MySessionFactory.getSessionFactory().getCurrentSession();
        Transaction transaction = session.getTransaction();
        if (!transaction.isActive()) {
            session.beginTransaction();
        }
        String hql = "from RG_TyperescourceEntity rg_typerescourceEntity";
        Query query = session.createQuery(hql);
        List list = query.list();
        return list;
    }

    @Override
    public RG_TyperescourceEntity findAllById(String id) {
        try {
            MySessionFactory.getSessionFactory().getCurrentSession().close();
            Session session = MySessionFactory.getSessionFactory().getCurrentSession();
            Transaction transaction = session.getTransaction();
            if (!transaction.isActive()) {
                session.beginTransaction();
            }
            String hql = "from RG_TyperescourceEntity rg_typerescourceEntity where rg_typerescourceEntity.id =:id";
            Query query = session.createQuery(hql);
            query.setParameter("id", id);
            if (!query.list().isEmpty()) {
                RG_TyperescourceEntity rg_typerescourceEntity = (RG_TyperescourceEntity) query.list().get(0);
                return rg_typerescourceEntity;
            } else {
                return null;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return null;
        }
    }
}
