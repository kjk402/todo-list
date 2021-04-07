package com.codesquad.todolist.domain;

import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Card {
    private static final DateTimeFormatter FORMATTER_PATTERN = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    @Id
    private Long id;
    private String title;
    private String contents;
    private LocalDateTime createDateTime = LocalDateTime.now();
    private Long columnId;

    public Card(String title, String contents, Long columnId) {
        this.title = title;
        this.contents = contents;
        this.columnId = columnId;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContents() {
        return contents;
    }

    public Long getColumnId() { return columnId;}

    public String getCreateDateTime() {
        return createDateTime.format(FORMATTER_PATTERN);
    }
}
