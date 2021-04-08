package com.codesquad.todolist.service;


import com.codesquad.todolist.domain.Action;
import com.codesquad.todolist.domain.Card;
import com.codesquad.todolist.domain.History;
import com.codesquad.todolist.repository.CardRepository;
import com.codesquad.todolist.repository.HistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CardService {
    private final CardRepository cardRepository;
    private final HistoryRepository historyRepository;

    public CardService(CardRepository cardRepository, HistoryRepository historyRepository) {
        this.cardRepository = cardRepository;
        this.historyRepository = historyRepository;
    }

    public List<Card> viewCardById(Long columnId) {

        if (columnId==1) {
            return cardRepository.findToDoCards();
        }
        if (columnId==2) {
            return cardRepository.findDoingCards();
        }
        if (columnId==3) {
            return cardRepository.findDoneCards();
        }
        return null;
    }

    public Card create(Long columnId, String title, String contents){
        Card card = new Card(title, contents, columnId);
        cardRepository.save(card);
        createHistory(Action.ADD.toString(), card.getTitle(), columnId, null);
        return card;
    }

    public Card update(Long id, String title, String contents) {
        Card card = findCard(id);
        String beforeTitle = card.getTitle();
        card.update(title, contents);
        cardRepository.save(card);
        createHistory(Action.UPDATE.toString(), beforeTitle, card.getColumnId(), null);
        return card;
    }

    public void delete(Long id) {
        Card card = findCard(id);
        cardRepository.delete(card);
        createHistory(Action.REMOVE.toString(), card.getTitle(), card.getColumnId(), null);
    }

    public Card move(Long id, Long columnId) {
        Card card = findCard(id);
        Long fromColumnId = card.getColumnId();
        card.move(columnId);
        cardRepository.save(card);
        createHistory(Action.MOVE.toString(), card.getTitle(), fromColumnId, columnId);
        return card;
    }

    public Card findCard(Long id) {
        return cardRepository.findById(id).orElse(null);
    }

    public void createHistory(String action, String title, Long fromColumnId, Long toColumnId) {
        History history = new History(action, title, fromColumnId, toColumnId);
        historyRepository.save(history);
    }

}
