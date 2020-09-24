<?php

require_once("connection.php");
require_once("queries.php");
require_once("helpers.php");

$user_id = intval(1);

if(!$con)
{
	print("Ошибка подключения: " . mysqli_connect_error());
}
else
{
	$ReceivedCategory = getCategory($con, $user_id);
	if (isset($_GET['addTask'])) //Проверка на NUll
	{
		$page_content = include_template('add.php',
		    [	'con' => $con,
		    	'user_id' => $user_id,
		    	'ReceivedCategory' => $ReceivedCategory	]);
		$title = 'Добавление задачи';
	}
	else
	{
		$page_content = include_template('main.php',
		    [	'con' => $con,
		    	'user_id' => $user_id,
		    	'ReceivedCategory' => $ReceivedCategory ]);
		$title = 'Дела в порядке';
	}
	$layout_content = include_template('layout.php', [
		'content' => $page_content,
		'title' => $title
	]);
	print($layout_content);
}
?>

