package com.codesquad.todolist.repository;

import com.codesquad.todolist.domain.Card;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface CardRepository extends CrudRepository<Card, Long> {

    @Query("SELECT * FROM CARD WHERE CARD.COLUMN_ID = :ID")
    Optional<List<Card>> findAllById(Long id);
}
