<?php

$errors_keys = [];


if ($_SERVER['REQUEST_METHOD'] == 'POST') 
{
    $errors = [];

    $len =  inputStrIsValid(2, 255, $_POST['name']);
		if (isset($len)) 
		{
        $errors['name'] = $len;
    }

		if (empty($_POST['project'])) 
		{
        $errors['project'] = 'Не выбран проект';
    }

		if (!empty($_POST['date'])) 
		{
				if (!is_date_valid($_POST['date']) ) 
				{
            $errors['date'] = 'Дата должна быть в формате: ГГГГ-ММ-ДД';
				}
				else if(strtotime("today") > strtotime($_POST['date']))
				{
            $errors['date'] = 'Введенная дата должна быть больше или равна текущей';
        }
    }

		// 2МБ = 2097152 Б
    if (isset($_FILES) && $_FILES['file']['error'] == 0 && $_FILES['file']['size'] > 2097152){          
        $errors['file'] = 'Максимальный вес прикрепляемого файла не должен превышать 2МБ ';
    }

		if (count($errors)) 
		{
        $errors_keys = array_keys($errors);
		}
		else
		{
        if (isset($_FILES) && $_FILES['file']['error']==0) {

                $file_name = $_FILES['file']['name'];
                $file_url = 'uploads/' . $file_name;

                move_uploaded_file($_FILES['file']['tmp_name'], $file_url);
        }

        addTask($con, $_POST['name'], $file_url, empty($_POST['date'])? null: $_POST['date'], $user_id, $_POST['project']);
        header("Location: /index.php?project=".$ReceivedCategory[array_search($_POST['project'], array_column($ReceivedCategory, "ID"))]['Name']);
    }
}

?>
<!-- *** Категории *** -->
<section class="content__side">
    <h2 class="content__side-heading">Проекты</h2>

    <nav class="main-navigation">
        <ul class="main-navigation__list">
        	<?php foreach ($ReceivedCategory as $key => $category): ?>

            <li class="main-navigation__list-item">
                <a class="main-navigation__list-item-link" href="index.php?project=<?=htmlspecialchars($category['Name']); ?>"><?=htmlspecialchars($category['Name']); ?></a>
                <span class="main-navigation__list-item-count"> <?=$category['Quantity']; ?> </span>
            </li>

            <?php endforeach; ?>
        </ul>
    </nav>

    <a class="button button--transparent button--plus content__side-button"
       href="pages/form-project.html" target="project_add">Добавить проект</a>
</section>


<!-- *** Форма добавления задачи *** -->
<main class="content__main">

    <h2 class="content__main-heading">Добавление задачи</h2>

				<form class="form"  action="" method="POST" autocomplete="off" enctype="multipart/form-data">
				
				<!-- *** Ввод названия задачи *** -->	
				<div class="form__row">
            <label class="form__label" for="name">Название <sup>*</sup></label>
            <input class="form__input <?= in_array('name', $errors_keys)? "form__input--error":"" ?>" type="text" name="name" id="name" value="<?=getPostVal('name')?>" placeholder="Введите название" required maxlength="255">
            <?= in_array('name', $errors_keys)? "<p class='form__message'>".$errors['name']."</p>":"" ?>
          </div>

					<!-- *** Выбор проекта *** -->
          <div class="form__row">
            <label class="form__label" for="project">Проект <sup>*</sup></label>
            <select class="form__input form__input--select <?= in_array('project', $errors_keys)? "form__input--error":"" ?>" name="project" id="project" required>
                <option value="" selected disabled hidden>Выберите проект</option>
                <?php foreach ($ReceivedCategory as $key => $category): ?>
                    <option  <?= isset($_POST['project']) && htmlspecialchars($category['ID']) === $_POST['project'] ?"selected":"" ?> value="<?=htmlspecialchars($category['ID']); ?>"><?=htmlspecialchars($category['Name']); ?></option>              
                <?php endforeach; ?>
            </select>
            <?= in_array('project', $errors_keys)? "<p class='form__message'>".$errors['project']."</p>":"" ?>
          </div>

					<!-- *** Дата *** -->
          <div class="form__row">
            <label class="form__label " for="date">Дата выполнения</label>

            <input class="form__input form__input--date <?= in_array('date', $errors_keys)? "form__input--error":"" ?>" type="text" name="date" id="date" value="<?=getPostVal('date')?>" placeholder="ГГГГ-ММ-ДД">
            <?= in_array('date', $errors_keys)? "<p class='form__message'>".$errors['date']."</p>":"" ?>
          </div>

					<!-- *** Файл *** -->
          <div class="form__row">
            <label class="form__label" for="file">Файл</label>

            <div class="form__input-file">
              <input  class="visually-hidden" type="file" name="file" id="file" value="<?=$_FILES['file']?>">
              <label class="button button--transparent <?= in_array('file', $errors_keys)? "form__input--error":"" ?>" for="file">
                <span>Выберите файл</span>
              </label>
            </div>
            <?= in_array('file', $errors_keys)? "<p. class='form__message'>".$errors['file']."</p>":"" ?>
          </div>


					<!-- *** Отправить форму *** -->
          <div class="form__row form__row--controls">
            <input class="button" type="submit" name="" value="Добавить">
          </div>
        </form>
</main>
