package com.rengu.DAO.impl;

import com.rengu.DAO.UsersDAO;
import com.rengu.entity.UsersEntity;
import com.rengu.util.MySessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by hanchangming on 2017/5/11.
 */
public class UsersDAOImpl extends HibernateDaoSupport implements UsersDAO {

    public boolean userLogin(UsersEntity usersEntity) {
        Transaction transaction = null;
        try {
            Session session = MySessionFactory.getSessionFactory().getCurrentSession();
            transaction = session.beginTransaction();
//            String hql = "from com.rengu.entity.UsersEntity userEntity where userEntity.username=:username and userEntity.password=:password";
            String sql = "select * from users where username=:username and password=:password";
//            Query query = session.createQuery(hql);
            Query query = session.createSQLQuery(sql);
            query.setParameter("username", usersEntity.getUsername());
            query.setParameter("password", usersEntity.getPassword());
            List list = query.list();
            transaction.commit();
            if (list.size() <= 0) {
                return false;
            }
            return true;
        } catch (Exception exception) {
            exception.printStackTrace();
            return false;
        } finally {
            if (transaction != null) {
                transaction = null;
            }
        }
    }
}
