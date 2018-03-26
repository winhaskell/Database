Queries for the following tables
--------------------------------
NIKOVITS.EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
NIKOVITS.DEPT(deptno, dname, loc)
NIKOVITS.SAL_CAT(category, lowest_sal, highest_sal)
---------------------------------------------------

-- (Salary categories)
CREATE TABLE Sal_cat
 (category NUMERIC, 
  lowest_sal NUMERIC, 
  highest_sal NUMERIC
);

Sal_cat 
-------------
1   700  1200
2  1201  1400
3  1401  2000
4  2001  3000
5  3001  9999



Queries for Built-in Functions
------------------------------
List the employees whose salary is divisible with 15.
SELECT ename, sal FROM emp WHERE mod(sal, 15) = 0;

List the employees, whose hiredate is greater than 1982.01.01.
SELECT ename, hiredate FROM emp WHERE hiredate > to_date('1982.01.01', 'yyyy.mm.dd');

List the employees where the second character of his name is 'A'.
SELECT ename FROM emp WHERE substr(ename,2,1) = 'A';

List the employees whose name contains two 'L'-s. (use some built-in function)
SELECT ename FROM emp WHERE instr(ename,'L', 1, 2) > 0;

List the last 3 characters of the employees' names.
SELECT ename, substr(ename,-3) FROM emp;

List the emloyees whose name has a 'T' in the last but one position.
SELECT ename FROM emp WHERE substr(ename, -2, 1)= 'T';

List the square root of the salaries rounded to 2 decimals and the integer part of it.
SELECT round(sqrt(sal), 2), trunc(round(sqrt(sal), 2), 0)  FROM emp;

In which month was the hiredate of ADAMS? (give the name of the month)
Give the number of days since ADAMS's hiredate. 
SELECT hiredate, trunc(sysdate - hiredate), to_char(hiredate, 'Month')  
FROM emp WHERE ename = 'ADAMS';

List the employees whose hiredate was Tuesday. (take care of the name of the day)
-- alter session set nls_date_language='english';
SELECT ename, hiredate FROM emp WHERE to_char(hiredate, 'day') LIKE 'tuesday%';

Give the manager-employee name pairs where the length of the two names are equal.
SELECT e1.ename mgr_name, e2.ename
FROM emp e1, emp e2 
WHERE e1.empno = e2.mgr and length(e1.ename) = length(e2.ename);

List the employees whose salary is in category 1. (see Sal_cat table)
SELECT ename, category FROM emp, sal_cat
WHERE sal BETWEEN lowest_sal AND highest_sal AND category=1;

List the employees whose salary category is an is even number.
SELECT ename, category FROM emp, sal_cat
WHERE sal BETWEEN lowest_sal AND highest_sal AND mod(category,2)=0;

Give the number of days between the hiredate of KING and the hiredate of JONES.
SELECT k.hiredate - j.hiredate FROM emp k, emp j 
WHERE k.ename='KING' AND j.ename='JONES';

Give the name of the day (e.g. Monday) which was the last day of the month in which KING's hiredate was.
SELECT to_char(last_day(hiredate), 'day') FROM emp WHERE ename='KING';

Give the name of the day (e.g. Monday) which was the first day of the month in which KING's hiredate was.
SELECT to_char(trunc(hiredate, 'month'), 'day') FROM emp WHERE ename='KING';

Give the names of employees whose department name contains a letter 'C' and whose salary category >= 4.
SELECT ename, dname, category FROM emp e, dept d, sal_cat sc
WHERE sal BETWEEN lowest_sal AND highest_sal AND e.deptno = d.deptno
AND dname LIKE '%C%' AND category >= 4;

List the name and salary of employees, and a charater string where one '#' denotes 1000 (rounded)
(So if the salary is 1800 then -> ##)
-- Take care of rpad function. rpad('', 3, 'x') = rpad(null, 3, 'x')
SELECT ename, sal, rpad('#', round(sal, -3)/1000, '#') FROM emp;

