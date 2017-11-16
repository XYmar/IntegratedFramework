package com.rengu.actions.mes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.rengu.util.MyLog;
import com.rengu.util.Tools;
import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * ActiveMQ发送端
 * Created by wey580231 on 2017/7/5.
 */
public class MesSender {

    private ConnectionFactory connectionFactory;
    private Connection connection = null;
    private Session session = null;
    private Destination destination = null;
    private MessageProducer producer = null;

    private static MesSender sender = null;

    private ObjectMapper objMapper = null;
    private ObjectNode rootNode = null;

    private String messSender = null;
    private String messReciver = null;

    private MesSender() {
        connectionFactory = new ActiveMQConnectionFactory(
                ActiveMQConnection.DEFAULT_USER,
                ActiveMQConnection.DEFAULT_PASSWORD,
                Tools.getDatabaseProperties().getProperty("BrokerURL"));
        objMapper = new ObjectMapper();

        messSender = Tools.getDatabaseProperties().getProperty("SendQueue");
        messReciver = Tools.getDatabaseProperties().getProperty("ReceiveQueue");

        try {
            connection = connectionFactory.createConnection();
            connection.start();

        } catch (JMSException e) {
            e.printStackTrace();
        }
    }

    //发送消息
    private void sendMessage(String message) {
        try {
            session = connection.createSession(Boolean.TRUE, Session.AUTO_ACKNOWLEDGE);
            destination = session.createQueue(Tools.getDatabaseProperties().getProperty("SendQueue"));
            producer = session.createProducer(destination);
            producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

            TextMessage tx = session.createTextMessage(message);

            producer.send(tx);

            MyLog.getLogger().info("回复确认消息:" + message);

            session.commit();
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }

    //发送确认消息
    public void sendReplyMessage(String messType, String uuid) {

        rootNode = objMapper.createObjectNode();
        rootNode.put("FC", messType);
        rootNode.put("REVICER", messSender);
        rootNode.put("SENDER", messReciver);
        rootNode.put("UUID", uuid);

        ObjectNode dataNode = objMapper.createObjectNode();
        dataNode.put("result", "OK");
        dataNode.put("type", "1");

        rootNode.put("DATA", dataNode);

        sendMessage(rootNode.toString());
    }

    public void sendReplyMessage(String messType, String uuid, String revicer) {
        if (revicer == null) {
            sendReplyMessage(messType, uuid);
        }
        rootNode = objMapper.createObjectNode();
        rootNode.put("FC", messType);
        rootNode.put("REVICER", revicer);
        rootNode.put("SENDER", messReciver);
        rootNode.put("UUID", uuid);
        ObjectNode dataNode = objMapper.createObjectNode();
        dataNode.put("result", "OK");
        dataNode.put("type", "1");
        rootNode.put("DATA", dataNode);
        sendMessage(rootNode.toString());
    }

    //发送计划、订单等消息
    public void sendData(String messType, ObjectNode dataNode) {
        rootNode = objMapper.createObjectNode();
        rootNode.put("FC", messType);
        rootNode.put("REVICER", messSender);
        rootNode.put("SENDER", messReciver);
        rootNode.put("UUID", Tools.getUUID());
        rootNode.put("DATA", dataNode);
        MyLog.getLogger().info(rootNode.toString());
        sendMessage(rootNode.toString());
    }

    public void emulateData(String message) {
        sendMessage(message);
    }

    public static MesSender instance() {
        if (sender == null) {
            sender = new MesSender();
        }
        return sender;
    }
}
