package com.codesquad.todolist.contoroller;

import com.codesquad.todolist.domain.History;
import com.codesquad.todolist.repository.HistoryRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class HistoryController {

    private final HistoryRepository historyRepository;

    public HistoryController(HistoryRepository historyRepository) {
        this.historyRepository = historyRepository;
    }

    @GetMapping("/history")
    public ResponseEntity view() {
        return new ResponseEntity(historyRepository.findAll(), HttpStatus.OK);
    }

}
