-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 22 2020 г., 16:07
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
-- Структура таблицы `projects`
--

CREATE TABLE `projects` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Название` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Автор` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `projects`
--

INSERT INTO `projects` (`ID`, `Название`, `Автор`) VALUES
(5, 'Авто', 1),
(1, 'Входящие', 1),
(4, 'Домашние дела', 1),
(3, 'Работа', 1),
(2, 'Учеба', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

CREATE TABLE `tasks` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Дата создания` date NOT NULL,
  `Статус` tinyint(1) NOT NULL,
  `Задача` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Файл` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Дата выполнения` date DEFAULT NULL,
  `Автор` int(10) UNSIGNED NOT NULL,
  `Категория` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tasks`
--

INSERT INTO `tasks` (`ID`, `Дата создания`, `Статус`, `Задача`, `Файл`, `Дата выполнения`, `Автор`, `Категория`) VALUES
(1, '2019-12-01', 0, 'Собеседование в IT компании', NULL, '2019-12-01', 1, 3),
(2, '2019-12-25', 0, 'Выполнить тестовое задание', NULL, '2019-12-25', 1, 3),
(3, '2019-12-21', 1, 'Сделать задание первого раздела', NULL, '2019-12-21', 1, 2),
(4, '2019-12-22', 0, 'Встреча с другом', NULL, '2019-12-22', 1, 1),
(5, '2019-12-21', 0, 'Купить корм для кота', NULL, NULL, 1, 4),
(6, '2019-12-21', 0, 'Заказать пиццу', NULL, NULL, 1, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Имя` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Дата регистрации` date NOT NULL,
  `Пароль` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`ID`, `Email`, `Имя`, `Дата регистрации`, `Пароль`) VALUES
(1, 'konstantin@gmail.com', 'Константин', '2019-04-01', 'Qwerty123'),
(2, 'byzovstepan13@gmail.com', 'Степан', '2020-09-09', 'root');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Уникальное название и автор` (`Название`,`Автор`) USING BTREE,
  ADD KEY `проект_ibfk_1` (`Автор`);

--
-- Индексы таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Автор` (`Автор`),
  ADD KEY `Проект` (`Категория`);

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
-- AUTO_INCREMENT для таблицы `projects`
--
ALTER TABLE `projects`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `tasks`
--
ALTER TABLE `tasks`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`Автор`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`Автор`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`Категория`) REFERENCES `projects` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
