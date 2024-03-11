package com.omas.webapp.entity.response;

import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;

public class MessageResponse extends ResponseEntity<String> {

    public MessageResponse(String message, HttpStatusCode status) {
        super("{\"message\": \"" + message + "\"}", status);
    }

}
