-- ДЗ4, пункти 1–2. База LibraryManagement і тестові рядки.

CREATE DATABASE IF NOT EXISTS LibraryManagement
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE LibraryManagement;

DROP TABLE IF EXISTS borrowed_books;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
  author_id INT NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (author_id)
) ENGINE=InnoDB;

CREATE TABLE genres (
  genre_id INT NOT NULL AUTO_INCREMENT,
  genre_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (genre_id)
) ENGINE=InnoDB;

CREATE TABLE books (
  book_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  publication_year YEAR NULL,
  author_id INT NULL,
  genre_id INT NULL,
  PRIMARY KEY (book_id),
  KEY idx_books_author (author_id),
  KEY idx_books_genre (genre_id),
  CONSTRAINT fk_books_author FOREIGN KEY (author_id) REFERENCES authors (author_id),
  CONSTRAINT fk_books_genre FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
) ENGINE=InnoDB;

CREATE TABLE users (
  user_id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB;

CREATE TABLE borrowed_books (
  borrow_id INT NOT NULL AUTO_INCREMENT,
  book_id INT NOT NULL,
  user_id INT NOT NULL,
  borrow_date DATE NOT NULL,
  return_date DATE NULL,
  PRIMARY KEY (borrow_id),
  KEY idx_borrowed_book (book_id),
  KEY idx_borrowed_user (user_id),
  CONSTRAINT fk_borrowed_book FOREIGN KEY (book_id) REFERENCES books (book_id),
  CONSTRAINT fk_borrowed_user FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=InnoDB;

INSERT INTO authors (author_name) VALUES
  ('Іван Багряний'),
  ('Леся Українка');

INSERT INTO genres (genre_name) VALUES
  ('Поезія'),
  ('Проза');

-- MySQL YEAR приймає 1901–2155, тому рік видання має бути в цьому діапазоні.
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES
  ('Тигролови', 1944, 1, 2),
  ('Лісова пісня', 1911, 2, 1);

INSERT INTO users (username, email) VALUES
  ('marta', 'marta@example.com'),
  ('oleh', 'oleh@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES
  (1, 1, '2026-03-01', '2026-03-20'),
  (2, 2, '2026-03-05', NULL);
