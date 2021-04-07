package com.codesquad.todolist.contoroller;

import com.codesquad.todolist.domain.Card;
import com.codesquad.todolist.service.CardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;


@RestController
@RequestMapping("/card")
public class CardController {
    private Logger logger = LoggerFactory.getLogger(CardController.class);

    private CardService cardService;

    public CardController(CardService cardService) {
        this.cardService = cardService;
    }

    @PostMapping("/{columnId}")
    public ResponseEntity create(@PathVariable Long columnId, @RequestBody HashMap<String, String> cardInfo) {
        Card card = cardService.write(columnId, cardInfo);
        return new ResponseEntity(card, HttpStatus.OK);
    }

}
