# Лабораторная работа №1 
Данный код на Prolog представляет собой базу знаний о работниках некоторой компании и всей информации о них.

Ниже перечислены основные элементы кода:

### 1. Факты
>сотрудник(1, 'Иванов Иван Иванович', м, date(1990,01,01), date(2020,01,01)).

Содержит информацию о сотруднике. Сотрудник(Id, Имя, Пол, Дата_рождения, Дата_приема_на_работу).

>отдел(1,"Маркетинг").

Содержит информацию об отделе. Отдел(Id, Название).

>должность(1, "Начальник отдела", "Отвечает за работу отдела маркетинга", 1).

Содержит информацию о должности. Должность(Id, Название, Описание, Id_отдела).

>подчинение(1,2).

Содержит информацию о подчинении отделов. подчинение(отдел_1, отдел_2).

>занимает(1, 5, date(2020,01,01)).

Содержит информацию о занимаемой должности сотрудником. Занимает(Id_сотрудника, Id_должности, Дата начала).

>зарплата(1, 50000).

Содержит информацию о зарплате конкретного сотрудника. Зарплата(Id_сотрудника, Значение).

### 2. Правила
* **вывести_сотрудников** - Вывод всех сотрудников организации.
* **список_сотрудников_отдела** - Выводит список сотрудников того отдела, который вводит пользователь.
* **вывести_руководителей** - Вывод всех руководителей отделов.
* **вывести_заместителей** - Вывод всех заместителей отделов.
* **подчинение_отделов** - Показывает какой отдел какому подчиняется.
* **возраст_на_момент_приёма** - Показывает сколько было лет сотруднику когда он устроился на работу.
* **начальник** - Показывает иерархию сотрудников в отделе "Маркетинг".
* **годовая_зарплата** - Выводит годовую зарплату сотрудника.

### 3. Домен
>money=integer.

Определяется домен money, который имеет тип integer.

---

### Задача
Написать программу на прологе внутри приложения PIE (Prolog Inference Engine)
### Критерии:
- Выбрать предметную область
- Реализовать программу в соответствии с выбранной предметной областью
- В программе должно быть реализовано не менее 10 фактов
- В программе должно быть реализовано не менее 3 правил
