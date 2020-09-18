           <section class="content__side">
                <h2 class="content__side-heading">Проекты</h2>

                <nav class="main-navigation">
                    <ul class="main-navigation__list">
                    	<?php foreach ($projects as $key => $projects): ?>

                        <li class="main-navigation__list-item">
                            <a class="main-navigation__list-item-link" href="#"><?=htmlspecialchars($projects['Название']); ?></a>
                            <span class="main-navigation__list-item-count"> <?=ret_cout_t($tasks, $projects['ID']); ?> </span>
                        </li>

                        <?php endforeach; ?>
                    </ul>
                </nav>

                <a class="button button--transparent button--plus content__side-button"
                   href="pages/form-project.html" target="project_add">Добавить проект</a>
            </section>

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
                        <input class="checkbox__input visually-hidden show_completed" type="checkbox" <?php if($show_complete_tasks === 1): ?>checked <?php endif; ?> >
                        <span class="checkbox__text">Показывать Статусные</span>
                    </label>
                </div>

                <table class="tasks">
                	<?php foreach ($tasks as $key => $tazk): ?>
                		<?php if(($show_complete_tasks === 1 && $tazk['Статус']) || !$tazk['Статус']): ?>
                    <tr class="tasks__item task <?php if($tazk['Статус'])echo('task--completed') ?> <?php if( strtotime($tasks[$key]['Дата выполнения']) - time() <= 86400)echo('task--important') ?>">
                        <td class="task__select">
                            <label class="checkbox task__checkbox">
                                <input class="checkbox__input visually-hidden task__checkbox" type="checkbox" value="1" <?php if($tazk['Статус'])echo('checked') ?>>
                                <span class="checkbox__text"><?=htmlspecialchars($tazk['Задача']); ?></span>
                            </label>
                        </td>

                        <td class="task__date"><?=$tazk['Дата выполнения']; ?></td>
                    </tr>
                    <?php endif; ?> 
                    <?php endforeach; ?>
                </table>
            </main>