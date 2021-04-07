package com.codesquad.todolist.service;


import com.codesquad.todolist.domain.Card;
import com.codesquad.todolist.repository.CardRepository;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class CardService {
    private final CardRepository cardRepository;

    public CardService(CardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    public Card write(Long columnId, HashMap<String, String> cardInfo){
        Card card = new Card(cardInfo.get("title"), cardInfo.get("contents"), columnId);
        cardRepository.save(card);
        return card;
    }

}
