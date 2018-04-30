-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema quizza
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `quizza` ;

-- -----------------------------------------------------
-- Schema quizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quizza` DEFAULT CHARACTER SET utf8mb4 ;
USE `quizza` ;

-- -----------------------------------------------------
-- Table `quizza`.`admins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`admins` ;

CREATE TABLE IF NOT EXISTS `quizza`.`admins` (
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `pass` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `quizza`.`departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`departments` ;

CREATE TABLE IF NOT EXISTS `quizza`.`departments` (
  `dept_code` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `dept_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`dept_code`),
  UNIQUE INDEX `dept_name_UNIQUE` (`dept_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `quizza`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`subjects` ;

CREATE TABLE IF NOT EXISTS `quizza`.`subjects` (
  `subject_code` VARCHAR(8) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `subject_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `branch` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `semester` INT(2) NULL DEFAULT NULL,
  `subject_passkey` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `no_of_quizzes` INT(3) NOT NULL,
  PRIMARY KEY (`subject_code`),
  INDEX `fk_subjects_1_idx` (`branch` ASC),
  CONSTRAINT `fk_subjects_1`
    FOREIGN KEY (`branch`)
    REFERENCES `quizza`.`departments` (`dept_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `quizza`.`questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`questions` ;

CREATE TABLE IF NOT EXISTS `quizza`.`questions` (
  `question_id` INT(11) NOT NULL AUTO_INCREMENT,
  `sub_code` VARCHAR(8) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `quiz_number` INT(3) NOT NULL,
  `question` VARCHAR(400) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `answer` VARCHAR(80) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `option_2` VARCHAR(80) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `option_3` VARCHAR(80) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `option_4` VARCHAR(80) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  INDEX `fk_questions_1` (`sub_code` ASC),
  CONSTRAINT `fk_questions_1`
    FOREIGN KEY (`sub_code`)
    REFERENCES `quizza`.`subjects` (`subject_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 83
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `quizza`.`quiz`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`quiz` ;

CREATE TABLE IF NOT EXISTS `quizza`.`quiz` (
  `subject_code` VARCHAR(8) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `quiz_no` INT(3) NOT NULL,
  PRIMARY KEY (`subject_code`, `quiz_no`),
  CONSTRAINT `fk_quiz_1`
    FOREIGN KEY (`subject_code`)
    REFERENCES `quizza`.`subjects` (`subject_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `quizza`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`students` ;

CREATE TABLE IF NOT EXISTS `quizza`.`students` (
  `usn` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `password` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `branch` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `semester` INT(1) NOT NULL,
  PRIMARY KEY (`usn`),
  INDEX `branch_idx` (`branch` ASC),
  CONSTRAINT `branch`
    FOREIGN KEY (`branch`)
    REFERENCES `quizza`.`departments` (`dept_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `quizza`.`scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quizza`.`scores` ;

CREATE TABLE IF NOT EXISTS `quizza`.`scores` (
  `usn` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `subject_code` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `quiz_no` INT(3) NOT NULL,
  `score` INT(4) NOT NULL,
  PRIMARY KEY (`usn`, `subject_code`, `quiz_no`),
  INDEX `fk_scores_subcode_idx` (`subject_code` ASC),
  INDEX `fk_scores_quizno_idx` (`quiz_no` ASC),
  CONSTRAINT `fk_scores_subcode`
    FOREIGN KEY (`subject_code`)
    REFERENCES `quizza`.`quiz` (`subject_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_scores_usn`
    FOREIGN KEY (`usn`)
    REFERENCES `quizza`.`students` (`usn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

USE `quizza` ;

-- -----------------------------------------------------
-- procedure spGetQuizzes
-- -----------------------------------------------------

USE `quizza`;
DROP procedure IF EXISTS `quizza`.`spGetQuizzes`;

DELIMITER $$
USE `quizza`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetQuizzes`( in student_usn varchar(10) )
BEGIN
	select q.subject_code, subject_name, q.quiz_no
	from quiz q, subjects s
	where q.subject_code in 
	( 
		select s.subject_code
		from subjects where 
		branch in 
		(
			select branch from students where usn = student_usn
		)   
		and
		semester in 
		(
			select semester from students where usn = student_usn 
		) 
	)
    and 
    q.subject_code = s.subject_code
    and
    (q.subject_code, q.quiz_no)
    not in
		(
			select sc.subject_code, sc.quiz_no
			from scores sc, subjects s
			where sc.usn = student_usn
		)
    
    
    order by quiz_no,subject_code;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `quizza`;

DELIMITER $$

USE `quizza`$$
DROP TRIGGER IF EXISTS `quizza`.`questions_AFTER_INSERT` $$
USE `quizza`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `quizza`.`questions_AFTER_INSERT`
AFTER INSERT ON `quizza`.`questions`
FOR EACH ROW
BEGIN
	
    IF(
		select count(*) 
		from questions 
		where sub_code = ( new.sub_code ) 
		and quiz_number = ( new.quiz_number )
    ) = 10 
    then
		insert into quiz values (new.sub_code, new.quiz_number);
	end if;
END$$


DELIMITER ;
