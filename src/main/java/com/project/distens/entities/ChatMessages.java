
package com.project.distens.entities;

import com.project.distens.util.StringUtils;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatMessages {
    
    private String from;
    private String text;
    private String recipient;
    private String time;

    public ChatMessages() {
        this.time = StringUtils.getCurrentTimeStamp();
    }
    
    public ChatMessages(String from, String text, String recipient) {
        this();
        this.from = from;
        this.text = text;
        this.recipient = recipient;  
    }
}
