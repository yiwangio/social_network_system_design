# social_network_system_design
Домашнее задание по курсу System Design
System Design социальной сети для курса по System Design(https://balun.courses/courses/system_design)

## Описание
- публикация постов из путешествий с фотографиями, небольшим описанием и привязкой к конкретному месту путешествия;
- оценка и комментарии постов других путешественников;
- подписка на других путешественников, чтобы следить за их активностью;
- поиск популярных мест для путешествий и просмотр постов с этих мест;
- просмотр ленты других путешественников;

> Что касается будущей аудитории социальной сети - у бизнеса есть огромные средства для рекламы и продвижения социальной сети, поэтому пользовательская база будет постепенно линейно расти и через год достигнет примерно 10 000 000 уникальных пользователей в день, после чего также будет продолжать расти. Бизнес пока нацелен только на аудиторию стран СНГ (*на зарубежный рынок выходить планов нет*). Будущая система должна быть очень надежной, а также, чтобы с ней было удобно взаимодействовать, используя мобильные устройства и браузер.


## Функциональные требования
- возможность пользователя создать пост, состоящий из текста, медиa, и локации
  - возможность изменять пост, удалять
- Поиск пользователя/места
- возможность поставить/убрать оценку (лайк/огонь/смех/дизлайк)
- добавления комментария к посту. Состоит только из текста
- механизм подписки/отписки от других пользователей
- лента пользователя. Состоит из постов других пользователей, на которых оформлена подписка
- аккаунт пользователя. Представляет из себя ленту постов только этого пользователя
- место. Состоит из рейтинга, популярности и фотографий пользователей, которые поставили локацию этого места на своих фотографиях
- Мобильное приложение и web версия
- Сжатие фотографий для экономии места

## Нефункциональное требования
- DAU 10 000 000
- Поведение пользователя
  - 3 раза в день ежедневно
  - среднее время на сервисе 40 минут
  - 2 поисковых запроса в день
  - в день просмотрел 60 постов
    - комменты смотрит у 15
    - 10 комментариев в месяц пишет сам
    - 30 оценок в день ставит
  - в среднем 2 поста в месяц выкладывает пользователь
- сезонность - лето/новый год/майские
- SLA 99.95
- храним все данные всегда
- страны СНГ
- Тайминги
  - загрузка собственного поста <= 2 сек
  - загрузка обновлений ленты <= 1 сек
    - загрузка медиа <= 2 сек
  - загрузка комментариев <= 1 сек
  - Поиск пользователя/места <= 2 сек

## Нагрузка    
### Поиск 
RPS = 10 000 000 * 2 / 86400 = 231
traffic = 231 * 100б * 10 постов = 231 КБ/sec


### Посты
_**Таблица**_
- id 4б
- user id 4б
- desc 1600 б
- media (макс. 800 КБ)

просмотр
RPS(read) = 10 000 000 * 60 / 86400 = 7000 
Traffic(read) =  5.6 GB / sec

загрузка
RPS (write) = 10 000 000 / 15 / 86400 = 77
Traffic = 77 * 800 = 61 MB / sec

### Комменты
_**Таблица**_
- id 4б
- user id 4б
- post id 4б
- desc 1600 б

получение  
RPS(read) = 10 000 000 * 15 / 86400 = 1750 
Traffic(read) =  1750 * 1.6 = 2.8 MB / sec

RPS (write) = 10 000 000 / 3 / 86400 = 385
Traffic = 385 * 1.6 = 0.6 MB / sec


### Реакции
_**Таблица**_
- id 4б
- user_id 4б
- post_id 4б
- reactions 1б

RPS(write) = 10 000 000 * 30 / 86400 = 3472
Traffic(write) = 3472 * 13б = 45 КБ / сек

RPS (READ) = 10 000 000 * 60 / 86400 = 7000
traffic = 7000 * 13б = 91 КБ / сек



