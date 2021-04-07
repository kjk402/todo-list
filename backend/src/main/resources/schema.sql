
use todo;
DROP TABLE IF EXISTS card;

CREATE TABLE card
(
    id            int primary key auto_increment,
    title         varchar(45),
    contents       varchar(500),
    column_id  int
);
