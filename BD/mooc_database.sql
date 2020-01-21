-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  Dim 28 avr. 2019 à 23:20
-- Version du serveur :  10.1.38-MariaDB
-- Version de PHP :  7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  'mooc_database'
--

/*******************************************************/
/********************** DROP ***********************/
/*******************************************************/

DROP TABLE IF EXISTS has_an;
DROP TABLE IF EXISTS contains;
DROP TABLE IF EXISTS teaches;
DROP TABLE IF EXISTS apply_to;
DROP TABLE IF EXISTS parent;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS topic;
DROP TABLE IF EXISTS level;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS subscription;


/*******************************************************/
/********************** CREATION ***********************/
/*******************************************************/

-- --------------------------------------------------------

--
-- Structure de la table `parent`
--

CREATE TABLE `parent` (
  `Id_parent` int(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Lname` varchar(20) NOT NULL,
  `Fname` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `age` int(2) NOT NULL,
  `id_student` int(20) NOT NULL,
  PRIMARY KEY(Id_parent)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `student`
--

CREATE TABLE `student` (
  `Id_student` int(30) NOT NULL,
  `Email` varchar(30) NOT NULL,  
  `Lname` varchar(20) NOT NULL,
  `age` int(2) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `FName` varchar(20) NOT NULL,
  PRIMARY KEY(Id_student)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `teacher`
--

CREATE TABLE `teacher` (
  `Id_teacher` int(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Lname` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `FName` varchar(20) NOT NULL,
  `age` int(2) NOT NULL,
  PRIMARY KEY(Id_teacher)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `Id_user` int(11) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Lname` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `FName` varchar(20) NOT NULL,
  `age` int(2) NOT NULL,
  PRIMARY KEY(Id_user)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Structure de la table `level`
--

CREATE TABLE `level` (
  `Id_level` int(11) NOT NULL,
  `label` varchar(30) NOT NULL,
  `Id_STUDENT` int(11) NOT NULL,
  PRIMARY KEY(Id_level)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `topic`
--

CREATE TABLE `topic` (
  `Id_topic` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `Id_COURSE` int(11) NOT NULL,
  PRIMARY KEY(Id_topic)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `teaches`
--

CREATE TABLE `teaches` (
  `Id_TEACHER` int(11) NOT NULL,
  `Id_TOPIC` int(11) NOT NULL,
  PRIMARY KEY(Id_TEACHER,Id_TOPIC)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `contains`
--

CREATE TABLE `contains` (
  `Id_LEVEL` int(11) NOT NULL,
  `Id_TOPIC` int(11) NOT NULL,
  PRIMARY KEY(Id_LEVEL,Id_TOPIC)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `course`
--

CREATE TABLE `course` (
  `Id_course` int(11) NOT NULL,
  `name` varchar(11) NOT NULL,
  `chaptersNumber` int(11) NOT NULL,
  PRIMARY KEY(Id_course)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table subscription
--

CREATE TABLE `subscription` (
  `Id_subscription` int(11) NOT NULL,
  `Subname` varchar(11) NOT NULL,
  `price` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  PRIMARY KEY(Id_subscription)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `account`
--

CREATE TABLE `account` (
  `Id_account` int(11) NOT NULL,
  `passwd` varchar(30) NOT NULL,
  PRIMARY KEY(Id_account)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `has_an`
--

CREATE TABLE `has_an` (
  `Id_USER` int(11) NOT NULL,
  `Id_ACCOUNT` int(11) NOT NULL,
  PRIMARY KEY(Id_USER,Id_ACCOUNT)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Structure de la table `apply_to`
--

CREATE TABLE `apply_to` (
  `Id_USER` int(11) NOT NULL,
  `Id_SUBSCRIPTION` int(11) NOT NULL,
  PRIMARY KEY(Id_USER,Id_SUBSCRIPTION)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*******************************************************/
/******************** FOREIGN KEYS *********************/
/*******************************************************/

ALTER TABLE `teacher`
ADD CONSTRAINT FK_TEACHER_USER FOREIGN KEY  (Id_teacher) REFERENCES `user` (Id_user);

ALTER TABLE `parent`
ADD CONSTRAINT FK_PARENT_USER FOREIGN KEY  (Id_parent) REFERENCES `user` (Id_user);

ALTER TABLE `student`
ADD CONSTRAINT FK_STUDENT_USER FOREIGN KEY  (Id_student) REFERENCES `user` (Id_user);

ALTER TABLE `level`
ADD CONSTRAINT FK_LEVEL_STUDENT FOREIGN KEY  (Id_STUDENT) REFERENCES `student` (id_student);

ALTER TABLE `has_an`
ADD CONSTRAINT FK_HAS_ACCOUNT FOREIGN KEY  (Id_ACCOUNT) REFERENCES `account` (Id_account),
ADD CONSTRAINT FK_HAS_USER FOREIGN KEY  (Id_USER) REFERENCES `user` (Id_user);

ALTER TABLE `teaches`
ADD CONSTRAINT FK_TEACHES_TEACHER FOREIGN KEY  (Id_TEACHER) REFERENCES `teacher` (Id_teacher),
ADD CONSTRAINT FK_TEACHES_TOPIC FOREIGN KEY  (Id_TOPIC) REFERENCES `topic` (Id_topic);

ALTER TABLE `topic`
ADD CONSTRAINT FK_TOPIC_COURSE FOREIGN KEY  (Id_COURSE) REFERENCES `course` (Id_course);

ALTER TABLE `apply_to`
ADD CONSTRAINT FK_APPLYTO_USER FOREIGN KEY  (Id_USER) REFERENCES `user` (Id_user),
ADD CONSTRAINT FK_APPLYTO_SUBSCRIPTION FOREIGN KEY  (Id_SUBSCRIPTION) REFERENCES `subscription` (Id_subscription);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
