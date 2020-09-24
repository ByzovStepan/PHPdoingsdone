-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 24 2020 г., 23:45
-- Версия сервера: 5.7.29
-- Версия PHP: 7.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `doingsdonebyzov`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Author` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`ID`, `Name`, `Author`) VALUES
(5, 'Авто', 1),
(10, 'Авто', 2),
(1, 'Входящие', 1),
(6, 'Входящие', 2),
(4, 'Домашние дела', 1),
(9, 'Домашние дела', 2),
(3, 'Работа', 1),
(8, 'Работа', 2),
(2, 'Учеба', 1),
(7, 'Учеба', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

CREATE TABLE `tasks` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Date_of_creation` date NOT NULL,
  `Status` tinyint(1) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `File` varchar(255) DEFAULT NULL,
  `Date_of_completion` date DEFAULT NULL,
  `Author` int(10) UNSIGNED NOT NULL,
  `Project` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tasks`
--

INSERT INTO `tasks` (`ID`, `Date_of_creation`, `Status`, `Name`, `File`, `Date_of_completion`, `Author`, `Project`) VALUES
(1, '2020-06-04', 0, 'Собеседование в IT компании', NULL, '2020-06-04', 1, 3),
(2, '2019-12-25', 0, 'Выполнить тестовое задание', NULL, '2019-12-25', 1, 3),
(3, '2019-12-21', 1, 'Сделать задание первого раздела', NULL, '2019-12-21', 1, 2),
(4, '2019-12-22', 0, 'Встреча с другом', NULL, '2019-12-22', 1, 1),
(5, '2001-04-13', 0, 'Купить корм для кота', NULL, NULL, 1, 4),
(7, '2020-06-04', 0, 'Собеседование в IT компании', NULL, '2020-06-04', 2, 8),
(8, '2019-12-25', 0, 'Выполнить тестовое задание', NULL, '2019-12-25', 2, 8),
(9, '2019-12-21', 1, 'Сделать задание первого раздела', NULL, '2019-12-21', 2, 7),
(10, '2019-12-22', 0, 'Встреча с другом', NULL, '2019-12-22', 2, 6),
(11, '2001-04-13', 0, 'Купить корм для кота', NULL, NULL, 2, 9),
(15, '2020-09-24', 0, 'Тест добавления помыть посуду', NULL, '2020-09-30', 1, 4),
(16, '2020-09-25', 0, 'Тест  прикрепления файла', 'uploads/2020-07-19.jpg', '2020-09-25', 1, 2),
(19, '2020-09-25', 0, 'Успешный тест файла', 'uploads/logo.png', '2020-09-26', 1, 1),
(22, '2020-09-25', 0, 'Выпить таблетки', NULL, '2020-09-25', 1, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `RegistrationDate` date NOT NULL,
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`ID`, `Email`, `Name`, `RegistrationDate`, `Password`) VALUES
(1, 'user-konstantin@gmail.com', 'Константин', '2020-09-07', 'Qwerty123'),
(2, 'byzovstepan13@gmail.com', 'Степан', '2001-04-13', 'Stepa13042001');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Уникальное название и автор` (`Name`,`Author`) USING BTREE,
  ADD KEY `проект_ibfk_1` (`Author`);

--
-- Индексы таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Author` (`Author`),
  ADD KEY `project` (`Project`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `tasks`
--
ALTER TABLE `tasks`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`Author`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`Author`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`Project`) REFERENCES `categories` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
