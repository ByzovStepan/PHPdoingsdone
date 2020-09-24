<?php

//Получение проекта
function getCategory($con, $user_id) {
    $sql = "SELECT ID, Name, Author, (SELECT COUNT(*) FROM `tasks` WHERE `Project` = `categories`.ID) AS `Quantity`  FROM `categories` WHERE `Author` = ".intval($user_id);
    $result = mysqli_query($con, $sql);
    $ReceivedCategory = mysqli_fetch_all($result, MYSQLI_ASSOC);
    return $ReceivedCategory;
}

//Получение задач
function getTasks($con, $user_id) {
    $sql = "SELECT * FROM `tasks` WHERE `Author` = " . intval($user_id)." ORDER BY ID DESC";
    $result = mysqli_query($con, $sql);
    $ReceivedTask = mysqli_fetch_all($result, MYSQLI_ASSOC);
    return $ReceivedTask;
}

//Получение id проекта по его названию
function getCategoryIDByName($con, $user_id, $CategoryName) 
{
    $sql = "SELECT ID FROM `categories` WHERE `Author` = " . $user_id . " AND `Name` = '" . strval($CategoryName) . "'";
    $result = mysqli_query($con, $sql);
    $CategoryID_List =  mysqli_fetch_all($result, MYSQLI_ASSOC);   
    if(count($CategoryID_List)!=0){
        $CategoryID =  array_column($CategoryID_List, 'ID');    
    	return $CategoryID[0];
	}
	return null;
}

//Получение задач по id проекта
function getTasksByID($con, $user_id, $CategoryID) 
{
    $sql =  "SELECT * FROM `tasks` WHERE `Author` = ".$user_id." AND `Project` = ".$CategoryID." ORDER BY ID DESC";
    $result = mysqli_query($con, $sql);
    $ReceivedTask = mysqli_fetch_all($result, MYSQLI_ASSOC);
    return $ReceivedTask;
}

//Добавление новой задачи
function addTask($con, $name, $file, $date_c = null, $user_id, $proj) 
{
    if(empty($date_c)) {$date_c = null;}; 
    print($file);
    if(empty($file)) {$file = null;}; 
		
		// Работа с подготовленными выражениями // 
		$sql = "INSERT INTO `tasks` (`Date_of_creation`, `Status`, `Name`, `File`, `Date_of_completion`, `Author`, `Project`) VALUES (NOW(), 0, ?, ?, ?, ?, ?)";
		
		//Функция вернет объект подготовленного выражения
		$stmt = mysqli_prepare($con, $sql);

		//Подставляем значения с помощью функции
		mysqli_stmt_bind_param($stmt, 'sssii', $name, $file, $date_c, $user_id, $proj);
		
    //Отправляем обратно в базу данных для исполнения
		mysqli_stmt_execute($stmt);
		
		//Получить объект результата после выполненияподготовленного выражения
    $res = mysqli_stmt_get_result($stmt);


    return true;
}

        
?>
