package com.codesquad.todolist.contoroller;

import com.codesquad.todolist.domain.Card;
import com.codesquad.todolist.service.CardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/card")
public class CardController {
    private Logger logger = LoggerFactory.getLogger(CardController.class);

    @Autowired
    private final CardService cardService;

    public CardController(CardService cardService) {
        this.cardService = cardService;
    }

    @GetMapping("/{columnId}")
    public ResponseEntity view(@PathVariable Long columnId) {
        List<Card> cards = cardService.viewCardById(columnId);
        return new ResponseEntity(cards, HttpStatus.OK);
    }

    @PostMapping("/{columnId}")
    public ResponseEntity create(@PathVariable Long columnId, @RequestParam(value = "title",required=false) String title, @RequestParam(value = "contents",required=false) String contents) {
        Card card = cardService.create(columnId, title, contents);
        return new ResponseEntity(card, HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity update(@PathVariable Long id, @RequestParam(value = "title",required=false) String title, @RequestParam(value = "contents",required=false) String contents) {
        Card card = cardService.update(id, title, contents);
        return new ResponseEntity(card, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        cardService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @PutMapping("/{id}/move/{columnId}/{index}")
    public ResponseEntity move(@PathVariable Long id, @PathVariable Long columnId, @PathVariable int index) {
        Card card = cardService.move(id, columnId, index);
        return new ResponseEntity(card, HttpStatus.OK);
    }

}
