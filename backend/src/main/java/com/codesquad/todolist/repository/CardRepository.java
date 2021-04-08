package com.codesquad.todolist.repository;

import com.codesquad.todolist.domain.Card;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface CardRepository extends CrudRepository<Card, Long> {

    @Query("SELECT * FROM CARD WHERE CARD.COLUMN_ID = 1")
    List<Card> findToDoCards();

    @Query("SELECT * FROM CARD WHERE CARD.COLUMN_ID = 2")
    List<Card> findDoingCards();

    @Query("SELECT * FROM CARD WHERE CARD.COLUMN_ID = 3")
    List<Card> findDoneCards();
}
