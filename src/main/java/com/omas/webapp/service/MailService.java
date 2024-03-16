package com.omas.webapp.service;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import jakarta.mail.MessagingException; // Add the missing import statement
import jakarta.mail.internet.MimeMessage;

@Service
public class MailService {

    private final JavaMailSender emailSender;

    public MailService(JavaMailSender emailSender) {
        this.emailSender = emailSender;
    }

    public void sendRecoveryEmail(String to, String recoveryLink) throws MessagingException {

        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        helper.setTo(to);

        String subject = "Tässä on linkki salasanasi nollaamiseen";

        String content = "<p>Hei,</p>"
                + "<p>Olet pyytänyt salasanasi nollaamista.</p>"
                + "<p>Klikkaa alla olevaa linkkiä vaihtaaksesi salasanasi:</p>"
                + "<p><a href=\"" + recoveryLink + "\">Vaihda salasanani</a></p>"
                + "<br>"
                + "<p>Jos muistat salasanasi, "
                + "tai et ole tehnyt tätä pyyntöä, voit jättää tämän sähköpostin huomiotta.</p>";

        helper.setSubject(subject);

        helper.setText(content, true);

        emailSender.send(message);
    }
}