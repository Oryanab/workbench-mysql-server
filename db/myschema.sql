-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS seniors DEFAULT CHARACTER SET utf8 ;
USE seniors ;

-- -----------------------------------------------------
-- Table seniors.teachers
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.teachers (
  id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  age INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seniors.subjects
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.subjects (
  ID INT NOT NULL,
  subject_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE INDEX id_UNIQUE (ID ASC) VISIBLE,
  UNIQUE INDEX name_UNIQUE (subject_name ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seniors.students
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.students (
  ID INT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seniors.classes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.classes (
  ID INT NOT NULL,
  class_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID, class_name),
  UNIQUE INDEX class_name_UNIQUE (class_name ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seniors.students_has_classes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.students_has_classes (
  students_ID INT NOT NULL,
  classes_ID INT NOT NULL,
  classes_class_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (students_ID, classes_ID, classes_class_name),
  INDEX fk_students_has_classes_classes1_idx (classes_ID ASC, classes_class_name ASC) VISIBLE,
  INDEX fk_students_has_classes_students_idx (students_ID ASC) VISIBLE,
  CONSTRAINT fk_students_has_classes_students
    FOREIGN KEY (students_ID)
    REFERENCES seniors.students (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_students_has_classes_classes1
    FOREIGN KEY (classes_ID , classes_class_name)
    REFERENCES seniors.classes (ID , class_name)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seniors.teachers_has_subjects
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.teachers_has_subjects (
  teachers_id INT NOT NULL,
  subjects_ID INT NOT NULL,
  PRIMARY KEY (teachers_id, subjects_ID),
  INDEX fk_teachers_has_subjects_subjects1_idx (subjects_ID ASC) VISIBLE,
  INDEX fk_teachers_has_subjects_teachers1_idx (teachers_id ASC) VISIBLE,
  CONSTRAINT fk_teachers_has_subjects_teachers1
    FOREIGN KEY (teachers_id)
    REFERENCES seniors.teachers (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_teachers_has_subjects_subjects1
    FOREIGN KEY (subjects_ID)
    REFERENCES seniors.subjects (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seniors.students_has_teachers_has_subjects
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seniors.students_has_teachers_has_subjects (
  students_ID INT NOT NULL,
  teachers_has_subjects_teachers_id INT NOT NULL,
  teachers_has_subjects_subjects_ID INT NOT NULL,
  PRIMARY KEY (students_ID, teachers_has_subjects_teachers_id, teachers_has_subjects_subjects_ID),
  INDEX fk_students_has_teachers_has_subjects_teachers_has_subjects_idx (teachers_has_subjects_teachers_id ASC, teachers_has_subjects_subjects_ID ASC) VISIBLE,
  INDEX fk_students_has_teachers_has_subjects_students1_idx (students_ID ASC) VISIBLE,
  CONSTRAINT fk_students_has_teachers_has_subjects_students1
    FOREIGN KEY (students_ID)
    REFERENCES seniors.students (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_students_has_teachers_has_subjects_teachers_has_subjects1
    FOREIGN KEY (teachers_has_subjects_teachers_id , teachers_has_subjects_subjects_ID)
    REFERENCES seniors.teachers_has_subjects (teachers_id , subjects_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
