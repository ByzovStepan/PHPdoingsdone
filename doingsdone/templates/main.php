<?php
    $DisplayCompletedTasks = 0;
		$errors = [];
		
		if (isset($_GET['show_completed'])) 
		{
        $DisplayCompletedTasks = intval($_GET['show_completed']);
    }

		if (isset($_GET['project'])) 
		{
				$CategoryName = DefendFromSqlInjection($_GET['project']);

        $CategoryID = getCategoryIDByName($con, $user_id, $CategoryName);

				if($CategoryID!==null)
				{
            $ReceivedTask = getTasksByID($con, $user_id, $CategoryID);
						if(count($ReceivedTask) === 0)
						{
							$errors['Список задач пуст'] = 'Сначала нужно добавить задачу';
						};
				}
				else
				{
            http_response_code(404);
            $errors['Ошибка 404'] = 'Ресурс в запрашиваемой локации не найден';
            $ReceivedTask = [];
        }
		}
		else
		{
        $ReceivedTask = getTasks($con, $user_id);
				if(count($ReceivedTask) === 0)
				{
					$errors['Список задач пуст'] = 'Сначала нужно добавить задачу';
				};
    }

?>

<!-- *** Категории *** -->
<section class="content__side">
    <h2 class="content__side-heading">Проекты</h2>

    <nav class="main-navigation">
        <ul class="main-navigation__list">
        	<?php foreach ($ReceivedCategory as $key => $category): ?>

            <li class="main-navigation__list-item <?= $category['Name'] === htmlspecialchars($_GET['project']) ? "main-navigation__list-item--active":"" ?>">
                <a class="main-navigation__list-item-link" href="index.php?project=<?=htmlspecialchars($category['Name']). (isset($_GET['show_completed']) ? "&show_completed=".$_GET['show_completed'] : "") ?>"><?=htmlspecialchars($category['Name']); ?></a>
                <span class="main-navigation__list-item-count"> <?=$category['Quantity']; ?> </span>
            </li>

            <?php endforeach; ?>
        </ul>
    </nav>

    <a class="button button--transparent button--plus content__side-button"
       href="pages/form-project.html" target="project_add">Добавить проект</a>
</section>

<!-- *** Задачи *** -->
<main class="content__main">
    <h2 class="content__main-heading">Список задач</h2>

    <form class="search-form" action="index.php" method="post" autocomplete="off">
        <input class="search-form__input" type="text" name="" value="" placeholder="Поиск по задачам">

        <input class="search-form__submit" type="submit" name="" value="Искать">
    </form>

    <div class="tasks-controls">
        <nav class="tasks-switch">
            <a href="/" class="tasks-switch__item tasks-switch__item--active">Все задачи</a>
            <a href="/" class="tasks-switch__item">Повестка дня</a>
            <a href="/" class="tasks-switch__item">Завтра</a>
            <a href="/" class="tasks-switch__item">Просроченные</a>
        </nav>

        <label class="checkbox">
            <input class="checkbox__input visually-hidden show_completed" type="checkbox" <?php if($DisplayCompletedTasks === 1): ?>checked <?php endif; ?> >
            <span class="checkbox__text">Показывать выполненные</span>
        </label>
    </div>

    <table class="tasks">
      <?php 
				if(count($errors) != 0)
					{
						foreach ($errors as $key => $value) 
						{
							 echo 
							 "<h1 style='margin: 50px 0px 0px 50px'>
							 ".$key.": 
							 <br>"
							 .$value."</h1>";
            }
          }
      ?>

    	<?php foreach ($ReceivedTask as $key => $task): ?>
    		<?php if(($DisplayCompletedTasks === 1 && $task['Status']) || !$task['Status']): ?>
        <tr class="tasks__item task <?php if($task['Status'])echo('task--completed') ?> <?php if( isset($ReceivedTask[$key]['Date_of_completion']) && strtotime($ReceivedTask[$key]['Date_of_completion']) - time() <= 86400)echo('task--important') ?>">
            <td class="task__select">
                <label class="checkbox task__checkbox">
                    <input class="checkbox__input visually-hidden task__checkbox" type="checkbox" value="1" <?php if($task['Status'])echo('checked') ?>>
                    <span class="checkbox__text"><?=htmlspecialchars($task['Name']) ?></span>
                </label>
            </td>
            <?= isset($task['File']) ? '<td class="task__file"> <a class="download-link" href="'.$task['File'].'">'.getNameFileByURl($task['File']).'</a> </td>' : ""?>

        
            <?='<td class="task__date">'.$task['Date_of_completion'].'</td>'?>
        </tr>
        <?php endif; ?>
        <?php endforeach; ?>
    </table>
</main>
