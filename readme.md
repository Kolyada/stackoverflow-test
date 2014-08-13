# Тестовое задание

#### Задание:
- Принять юзернейм пользователя stackoverflow
- Показать список вопросов, на которые этому пользователю интересно посмотреть
- Ограничение по времени: 3 часа

#### Решение

##### Время:
- Постановка задачи - 1 час
- Разработка - 3 часа
- Тестирование, деплой и этот документ - 1 час

##### Использование API:
- /users - загрузка списка пользователей по nickname
- /users/id/tags - загрузка тэгов, где пользователь принимал участие
- /question - загрузка вопросов по тэгу

##### Кэширование
- по запросу пользователя выполняется поиск в локальной БД
- при отсутствии результатов делается запрос к API и результат помещается в БД
- при переходе на страницу пользователя выполняется поиск 5 тэгов с его участием (эта информация далее не обновляется)
- при отсутствии тэгов выполняется запрос к API и результат помещается в БД для дальнейшего использования
- для каждого тэга проверяется наличие актуальных (1 сутки) вопросов в локальной БД
- при отсутствии вопросов делается запрос к API и результат помещается в БД
- пользователю отправляется страница с результатами

### [Пример](http://aip-stackoverflow-test.herokuapp.com/ "Heroku") на Heroku
### [Репозиторий](https://github.com/Kolyada/stackoverflow-test "github") на Github


моя почта: 89anisim89@gmail.com