-- База данных «Страны и города мира».
-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
-- mysql> SELECT _cities.title as city_name, _regions.title as region_name, _countries.title as country_name FROM _cities JOIN _regions ON _cities.region_id = _regions.id JOIN _countries ON _cities.country_id = _countries.id LIMIT 10;
-- +--------------+-----------------------+-----------+
-- | title        | title                 | title     |
-- +--------------+-----------------------+-----------+
-- | Отрадное     | Ленинградская область | Россия    |
-- | Чоп          | Закарпатская область  | Украина   |
-- | Череповец    | Вологодская область   | Россия    |
-- | Buenos Aires | Distrito Federal      | Аргентина |
-- | Волгоград    | Волгоградская область | Россия    |
-- | Северодвинск | Архангельская область | Россия    |
-- | Борок        | Ярославская область   | Россия    |
-- | Torino       | Regione Piemonte      | Италия    |
-- | Абакан       | Хакасия               | Россия    |
-- | Альметьевск  | Татарстан             | Россия    |
-- +--------------+-----------------------+-----------+
-- 10 rows in set (0.00 sec)

-- 2. Выбрать все города из Московской области.
-- mysql> SELECT _regions.title as region_name, _cities.title as city_name FROM _regions JOIN _cities ON _regions.id = _cities.region_id WHERE _regions.title = 'Московская область' LIMIT 5;
-- +--------------------+-----------+
-- | region_name        | city_name |
-- +--------------------+-----------+
-- | Московская область | Балашиха  |
-- | Московская область | Видное    |
-- | Московская область | Жуковский |
-- | Московская область | Коломна   |
-- | Московская область | Люберцы   |
-- +--------------------+-----------+
-- 5 rows in set (0.00 sec)


---------------------------------------------------

-- База данных «Сотрудники».
-- 1. Выбрать среднюю зарплату по отделам.
-- mysql> SELECT departments.dept_name, AVG(salaries.salary) FROM departments JOIN dept_emp ON departments.dept_no = dept_emp.dept_no JOIN salaries ON dept_emp.emp_no = salaries.emp_no GROUP BY departments.dept_name;
-- +--------------------+----------------------+
-- | dept_name          | AVG(salaries.salary) |
-- +--------------------+----------------------+
-- | Customer Service   |           58770.3665 |
-- | Development        |           59478.9012 |
-- | Finance            |           70489.3649 |
-- | Human Resources    |           55574.8794 |
-- | Marketing          |           71913.2000 |
-- | Production         |           59605.4825 |
-- | Quality Management |           57251.2719 |
-- | Research           |           59665.1817 |
-- | Sales              |           80667.6058 |
-- +--------------------+----------------------+
-- 9 rows in set (1 min 20.54 sec)

-- 2. Выбрать максимальную зарплату у сотрудника.
-- Максимальная зарплата у всех сотрудников
-- mysql> SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) as name, MAX(salaries.salary) as max_salary FROM employees LEFT JOIN salaries ON employees.emp_no = salaries.emp_no GROUP BY employees.emp_no ORDER BY max_salary DESC LIMIT 10;
-- +--------+-------------------+------------+
-- | emp_no | name              | max_salary |
-- +--------+-------------------+------------+
-- |  43624 | Tokuyasu Pesch    |     158220 |
-- | 254466 | Honesty Mukaidono |     156286 |
-- |  47978 | Xiahua Whitcomb   |     155709 |
-- | 253939 | Sanjai Luders     |     155513 |
-- | 109334 | Tsutomu Alameldin |     155377 |
-- |  80823 | Willard Baca      |     154459 |
-- | 493158 | Lidong Meriste    |     154376 |
-- | 205000 | Charmane Griswold |     153715 |
-- | 266526 | Weijing Chenoweth |     152710 |
-- | 237542 | Weicheng Hatcliff |     152687 |
-- +--------+-------------------+------------+
-- 10 rows in set (3.55 sec)
-- Максимальная зарплата у одного сотрудника
-- mysql> SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) as name, MAX(salaries.salary) as max_salary FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no WHERE employees.emp_no = 43624 GROUP BY employees.emp_no ORDER BY max_salary DESC LIMIT 10;
-- +--------+----------------+------------+
-- | emp_no | name           | max_salary |
-- +--------+----------------+------------+
-- |  43624 | Tokuyasu Pesch |     158220 |
-- +--------+----------------+------------+
-- 1 row in set (0.00 sec)

-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
-- 4. Посчитать количество сотрудников во всех отделах.
-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
-- mysql> SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) as name, MAX(salaries.salary) as max_salary FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no WHERE employees.emp_no = 43624 GROUP BY employees.emp_no ORDER BY max_salary DESC LIMIT 10;
-- +--------+----------------+------------+
-- | emp_no | name           | max_salary |
-- +--------+----------------+------------+
-- |  43624 | Tokuyasu Pesch |     158220 |
-- +--------+----------------+------------+
-- 1 row in set (0.00 sec)

-- mysql>