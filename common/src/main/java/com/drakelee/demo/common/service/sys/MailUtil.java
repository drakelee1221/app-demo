

package com.drakelee.demo.common.service.sys;


import com.drakelee.demo.common.dto.mail.Mailable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.util.Properties;

/**
 * 邮件服务类
 *
 * @author <a href="lijian@xianyunsoft.com">Lijian</a>
 * @version 1.0.0, 2017-07-18
 */
@Service
public class MailUtil {
  private Logger logger = LoggerFactory.getLogger(this.getClass());

  public void sendMail(Mailable mailable, String subject, String content, Address[] addresses) throws Exception {
    sendEmail(mailable, subject, content, false, addresses);
  }

  public void sendHtmlMail(Mailable mailable, String subject, String content, Address[] addresses) throws Exception {
    sendEmail(mailable, subject, content, true, addresses);
  }

  private void sendEmail(Mailable mailable, String subject, String content, boolean isHtml, Address[] addresses)
    throws Exception {
    Properties props = new Properties();
    /*SysMailDto mail = mailDto;
    if(mail.getSend() == 0){
      return ;
    }*/
    props.put("mail.smtp.host", mailable.getSmtp());
    props.put("mail.smtp.auth", "true");
    Session session = Session.getDefaultInstance(props);
    session.setDebug(true);
    MimeMessage message = new MimeMessage(session);

    message.setFrom(new InternetAddress(mailable.getAddress()));
    message.addRecipients(Message.RecipientType.TO, addresses);
    message.setSubject(subject);

    Multipart multipart = new MimeMultipart();
    BodyPart contentPart = new MimeBodyPart();
    if (isHtml) {
      contentPart.setContent(content, "text/html;charset=UTF-8");
    } else {
      contentPart.setText(content);
    }
    multipart.addBodyPart(contentPart);
    message.setContent(multipart);
    message.saveChanges();
    Transport transport = session.getTransport("smtp");
    transport.connect(mailable.getSmtp(), mailable.getAddress(), mailable.getPassword());
    transport.sendMessage(message, message.getAllRecipients());
    transport.close();
  }

}
