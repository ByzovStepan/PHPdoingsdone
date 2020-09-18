<?php

 
$show_complete_tasks = rand(0, 1);

$user_id = 1;


function esc($str) {
	$text = htmlspecialchars($str);
	return $text;
}


function ret_cout_t($mas, $prj){
	$cp = 0;
	foreach ($mas as $key => $ts){
	 if($ts['Категория'] === $prj){$cp++;};
	};
	return $cp;
};

$con = mysqli_connect("doingsdone", "root", "root","doingsdonebyzov");
if ($con == false) {
	print("Ошибка подключения: " . mysqli_connect_error());
}
 else {
	print("Соединение установлено");
	// выполнение запросов

		$sql = "SELECT * FROM projects WHERE Автор=" .$user_id;
    $result = mysqli_query($con, $sql);
    $projects = mysqli_fetch_all($result, MYSQLI_ASSOC);

    $sql = "SELECT * FROM tasks WHERE Автор=" .$user_id;
    $result = mysqli_query($con, $sql);
    $tasks = mysqli_fetch_all($result, MYSQLI_ASSOC);
}
mysqli_set_charset($con, "utf8");

require_once("helpers.php");

$page_content = include_template('main.php', ['projects' => $projects,'tasks' => $tasks, 'show_complete_tasks' => $show_complete_tasks]);

$layout_content = include_template('layout.php', [
'content' => $page_content,
'title' => 'Дела в порядке'
]);
print($layout_content);


?>