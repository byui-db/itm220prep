-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `library` ;

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` ;
USE `library` ;

-- -----------------------------------------------------
-- Table `library`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`author` ;

CREATE TABLE IF NOT EXISTS `library`.`author` (
  `author_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_fname` VARCHAR(45) NOT NULL,
  `author_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book` ;

CREATE TABLE IF NOT EXISTS `library`.`book` (
  `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `book_title` VARCHAR(45) NOT NULL,
  `book_isbn` VARCHAR(45) NOT NULL,
  `book_publish_year` INT NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `book_fk1_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `book_fk1`
    FOREIGN KEY (`author_id`)
    REFERENCES `library`.`author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`genre` ;

CREATE TABLE IF NOT EXISTS `library`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`person` ;

CREATE TABLE IF NOT EXISTS `library`.`person` (
  `person_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_fname` VARCHAR(45) NOT NULL,
  `person_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`location` ;

CREATE TABLE IF NOT EXISTS `library`.`location` (
  `location_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`stock` ;

CREATE TABLE IF NOT EXISTS `library`.`stock` (
  `stock_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `book_id` INT UNSIGNED NOT NULL,
  `location_id` INT UNSIGNED NOT NULL,
  `stock_quantity` INT NOT NULL,
  PRIMARY KEY (`stock_id`),
  INDEX `stock_fk1_idx` (`book_id` ASC) VISIBLE,
  INDEX `stock_fk2_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `stock_fk1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `stock_fk2`
    FOREIGN KEY (`location_id`)
    REFERENCES `library`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`book_genre` ;

CREATE TABLE IF NOT EXISTS `library`.`book_genre` (
  `book_genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `book_id` INT UNSIGNED NOT NULL,
  `genre_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_genre_id`),
  INDEX `book_genre_fk1_idx` (`book_id` ASC) VISIBLE,
  INDEX `book_genre_fk2_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `book_genre_fk1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `book_genre_fk2`
    FOREIGN KEY (`genre_id`)
    REFERENCES `library`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`borrow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library`.`borrow` ;

CREATE TABLE IF NOT EXISTS `library`.`borrow` (
  `borrow_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `book_id` INT UNSIGNED NOT NULL,
  `person_id` INT UNSIGNED NOT NULL,
  `borrow_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  `return_date` DATE NULL,
  PRIMARY KEY (`borrow_id`),
  INDEX `borrow_fk1_idx` (`book_id` ASC) VISIBLE,
  INDEX `borrow_fk2_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `borrow_fk1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `borrow_fk2`
    FOREIGN KEY (`person_id`)
    REFERENCES `library`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
