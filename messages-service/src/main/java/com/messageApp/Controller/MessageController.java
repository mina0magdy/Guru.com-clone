package com.messageApp.Controller;

import com.messageApp.Models.*;
import com.messageApp.DTO.*;
import com.messageApp.DTO.See_conversationsDTO;
import com.messageApp.DTO.UpdateDTO;
import com.messageApp.Models.Message;
import com.messageApp.Models.See_conversations;
import com.messageApp.Models.messagePrimaryKey;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;


@RestController
@RequestMapping("/message")
public class MessageController {
    @Autowired
    private MessagesRepository MegRepository;
    @Autowired
    private See_conversationsRepository SeeRepository;

    @Autowired
    private MessageService messageService;

    @PostMapping
    public ResponseEntity<?> saveMessage(@Valid @RequestBody MessageInputDTO messageInputDTO) {
        return messageService.saveMessage(messageInputDTO);
    }

    @GetMapping("/lists")
    public List<Message> getMessageAll() {
        return MegRepository.findAll();
    }

    @GetMapping("/chatMessages")
    public List<Message> findMessageByCompositeKey(@RequestParam UUID conversation_id) {
        try {
            return MegRepository.findByCompositeKey(conversation_id);
        }
        catch (Exception e){
            System.out.println(e);
            return null;
        }

    }

    @PutMapping("/update")
    public ResponseEntity<String> updateMessage(@Valid @RequestBody UpdateDTO dto) {
        return messageService.updateMessage(dto);
    }


    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteMessage(@RequestBody messagePrimaryKey mp) {
        try {
            MegRepository.deleteByCompositeKey(mp.getConversation_id(), mp.getSent_at(), mp.getMessage_id());
            return ResponseEntity.ok("Message deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete message");
        }
    }

}
