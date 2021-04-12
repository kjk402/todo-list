
use todo;
DROP TABLE IF EXISTS card;
DROP TABLE IF EXISTS history;

CREATE TABLE card
(
    id            int primary key auto_increment,
    title         varchar(45),
    contents       varchar(500),
    column_id  int
);

CREATE TABLE history
(
  id  int primary key auto_increment,
  action        varchar(45),
  title         varchar(45),
  from_column_id     int,
  to_column_id       int
);
