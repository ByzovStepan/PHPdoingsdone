
-- --------------------------------------------------------

--
-- Структура таблицы `пользователь`
--

CREATE TABLE `пользователь` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Имя` varchar(255) NOT NULL,
  `Дата регистрации` date NOT NULL,
  `Пароль` varchar(30) NOT NULL
);

-- --------------------------------------------------------

--
-- Структура таблицы `проект`
--

CREATE TABLE `проект` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Название` varchar(255) NOT NULL,
  `Автор` int(10) UNSIGNED NOT NULL
);

-- --------------------------------------------------------

--
-- Структура таблицы `задача`
--

CREATE TABLE `задача` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Дата создания` date NOT NULL,
  `Статус` tinyint(1) NOT NULL,
  `Название` varchar(255) NOT NULL,
  `Файл` varchar(255) DEFAULT NULL,
  `Срок` date DEFAULT NULL,
  `Автор` int(10) UNSIGNED NOT NULL,
  `Проект` int(10) UNSIGNED NOT NULL
);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `пользователь`
--
ALTER TABLE `пользователь`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Индексы таблицы `проект`
--
ALTER TABLE `проект`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Уникальное название и автор` (`Название`,`Автор`) USING BTREE,
  ADD KEY `проект_ibfk_1` (`Автор`);

--
-- Индексы таблицы `задача`
--
ALTER TABLE `задача`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Автор` (`Автор`),
  ADD KEY `Проект` (`Проект`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `пользователь`
--
ALTER TABLE `пользователь`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `проект`
--
ALTER TABLE `проект`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `задача`
--
ALTER TABLE `задача`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `проект`
--
ALTER TABLE `проект`
  ADD CONSTRAINT `проект_ibfk_1` FOREIGN KEY (`Автор`) REFERENCES `пользователь` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `задача`
--
ALTER TABLE `задача`
  ADD CONSTRAINT `задача_ibfk_1` FOREIGN KEY (`Автор`) REFERENCES `пользователь` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `задача_ibfk_2` FOREIGN KEY (`Проект`) REFERENCES `проект` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

