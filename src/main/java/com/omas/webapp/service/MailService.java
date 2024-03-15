package com.omas.webapp.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    private final JavaMailSender emailSender;

    public MailService(JavaMailSender emailSender) {
        this.emailSender = emailSender;
    }

    public void sendRecoveryEmail(String to, String recoveryLink) {
        SimpleMailMessage message = new SimpleMailMessage(); 
        message.setFrom("noreply@domain.com");
        message.setTo(to); 
        message.setSubject("Account Recovery"); 
        message.setText("To reset your password, click the link below:\n" + recoveryLink);
        emailSender.send(message);
    }
}