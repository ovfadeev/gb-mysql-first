USE 'employees';
-- База данных «Страны и города мира».
-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
SELECT
  ci.title as city_name,
  r.title as region_name,
  co.title as country_name
FROM _cities ci
  JOIN _regions r ON ci.region_id = r.id
JOIN _countries co ON ci.country_id = co.id
LIMIT 10;
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
SELECT r.title as region_name, c.title as city_name
FROM _regions r
JOIN _cities ci ON r.id = ci.region_id
WHERE r.title = 'Московская область'
LIMIT 5;
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
SELECT
  dp.dept_name as dept_name,
  AVG(s.salary) as avg_salary
FROM departments dp
  JOIN dept_emp de ON dp.dept_no = de.dept_no
  JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY dp.dept_name;
-- +--------------------+------------+
-- | dept_name          | avg_salary |
-- +--------------------+------------+
-- | Customer Service   | 58770.3665 |
-- | Development        | 59478.9012 |
-- | Finance            | 70489.3649 |
-- | Human Resources    | 55574.8794 |
-- | Marketing          | 71913.2000 |
-- | Production         | 59605.4825 |
-- | Quality Management | 57251.2719 |
-- | Research           | 59665.1817 |
-- | Sales              | 80667.6058 |
-- +--------------------+------------+
-- 9 rows in set (2.53 sec)

-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT
  e.emp_no,
  CONCAT(e.first_name, ' ', e.last_name) as name,
  MAX(s.salary) as max_salary
FROM employees e
  JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY max_salary
DESC LIMIT 10;
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
-- 10 rows in set (1.93 sec)

-- 2.1 Максимальная зарплата у одного сотрудника
SELECT
  e.emp_no,
  CONCAT(e.first_name, ' ', e.last_name) as name,
  MAX(s.salary) as max_salary
FROM employees e
  JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY max_salary DESC
LIMIT 1;
-- +--------+----------------+------------+
-- | emp_no | name           | max_salary |
-- +--------+----------------+------------+
-- |  43624 | Tokuyasu Pesch |     158220 |
-- +--------+----------------+------------+
-- 1 row in set (0.00 sec)

-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM employees
WHERE emp_no = (
  SELECT s.emp_no
  FROM salaries s
  WHERE s.salary = (
    SELECT MAX(salary)
    FROM salaries
  )
  LIMIT 1
);

-- 4. Посчитать количество сотрудников во всех отделах.
SELECT
  dp.dept_name,
  COUNT(de.emp_no) as count
FROM departments dp
  JOIN dept_emp de ON de.dept_no = dp.dept_no
GROUP BY dp.dept_no;
-- +--------------------+-------+
-- | dept_name          | count |
-- +--------------------+-------+
-- | Marketing          | 20211 |
-- | Finance            | 17346 |
-- | Human Resources    | 17786 |
-- | Production         | 73485 |
-- | Development        | 85707 |
-- | Quality Management | 20117 |
-- | Sales              | 52245 |
-- | Research           | 21126 |
-- | Customer Service   | 23580 |
-- +--------------------+-------+
-- 9 rows in set (0.14 sec)

-- 4.2 По настоящее время
SELECT
  dp.dept_name,
  COUNT(de.emp_no) as count
FROM departments dp
  JOIN dept_emp de
    ON de.dept_no = dp.dept_no
    AND de.to_date > NOW()
GROUP BY dp.dept_no;
-- +--------------------+-------+
-- | dept_name          | count |
-- +--------------------+-------+
-- | Marketing          | 14842 |
-- | Finance            | 12437 |
-- | Human Resources    | 12898 |
-- | Production         | 53304 |
-- | Development        | 61386 |
-- | Quality Management | 14546 |
-- | Sales              | 37701 |
-- | Research           | 15441 |
-- | Customer Service   | 17569 |
-- +--------------------+-------+
-- 9 rows in set (0.66 sec)


-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
-- тут есть ошибка в том что он считает количество выплат ЗП и их сумму...
-- в таблице сотрудников всего 300000+
SELECT
  dp.dept_name,
  COUNT(de.emp_no) as count,
  SUM(s.salary) as sum_salary
FROM departments dp
  JOIN dept_emp de
    ON de.dept_no = dp.dept_no
  JOIN salaries s
    ON de.emp_no = s.emp_no
GROUP BY dp.dept_no;
-- +--------------------+--------------+-------------+
-- | dept_name          | count_salary | max_salary  |
-- +--------------------+--------------+-------------+
-- | Human Resources    |       168490 |  9363811425 |
-- | Quality Management |       189781 | 10865203635 |
-- | Finance            |       165285 | 11650834677 |
-- | Research           |       200615 | 11969730427 |
-- | Customer Service   |       223644 | 13143639841 |
-- | Marketing          |       190861 | 13725425266 |
-- | Sales              |       496235 | 40030089342 |
-- | Production         |       697158 | 41554438942 |
-- | Development        |       810026 | 48179456393 |
-- +--------------------+--------------+-------------+
-- 9 rows in set (13.21 sec)
