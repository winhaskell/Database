http://www.dba-oracle.com/t_adv_plsql_first_last_methods.htm
--http://people.inf.elte.hu/nikovits/DB1/PLSQL/pl_00_doc_examples.txt
https://www.tutorialspoint.com/plsql/plsql_procedures.htm

 -- select * from NIKOVITS.SAL_CAT
 
--SELECT ROUND(45.923,2), ROUND(45.923,0),
-- ROUND(45.923,-1)
--FROM DUAL;
--SELECT ename, sal, MOD(sal, 5000)
--FROM NIKOVITS.EMP
 
-- Give the location, average salary by departments. (deptno, loc, avg_sal)
--select deptno, loc, avg_sal from NIKOVITS.EMP 

-- SELECT deptno, Avg(sal) AS avg_sal FROM NIKOVITS.EMP GROUP BY deptno


 --SELECT deptno,loc, Avg(sal) AS avg_sal FROM NIKOVITS.EMP e , NIKOVITS.DEPT d
 --where e.DEPTNO = d.DEPTNO
 -- GROUP BY deptno
 
-- http://myorastuff.blogspot.hu/2009/09/oracle-sql-questions.html
--65) Display all the records in emp table where salary should be less then or equal to ADAMS salary? 
--select * from NIKOVITS.EMP where sal <= (select sal from NIKOVITS.EMP where ename='ADAMS')
 
--delete NIKOVITS.EMP where deptno in(10,20); 

--select ename, avg(sal)  
--from NIKOVITS.EMP natural join NIKOVITS.DEPT
--group by deptno, ename 
--having count(ename) >=4;

--select * from NIKOVITS.EMP where trunc(sysdate-hiredate)/365 = (select min(trunc(sysdate-hiredate)/365) from NIKOVITS.EMP); 

--select count(distinct ename) from NIKOVITS.EMP;

--select * from likes2 natural join likes2;

--select * from NIKOVITS.dept

--SELECT e.deptno, ename, sal
--FROM NIKOVITS.EMP e, (SELECT deptno, MAX(sal) ms FROM NIKOVITS.EMP GROUP BY deptno) t
--WHERE e.deptno = t.deptno and e.sal = ms;
 
SELECT category, lowest_sal, highest_sal 
FROM NIKOVITS.sal_cat, NIKOVITS.emp 
WHERE sal BETWEEN lowest_sal AND highest_sal
GROUP BY category, lowest_sal, highest_sal HAVING count(distinct job)=1;


--set serveroutput on
DECLARE
  PROCEDURE elj2(p IN NUMBER);

  PROCEDURE elj1(p IN NUMBER) IS
  BEGIN
    IF p < 10 THEN  DBMS_OUTPUT.PUT_LINE(p); elj2(p+1);  END IF;
  END elj1;

  PROCEDURE elj2(p IN NUMBER) IS
  BEGIN
    IF p < 10 THEN  DBMS_OUTPUT.PUT_LINE(p); elj1(p*2);  END IF;
  END elj2;
BEGIN
  elj1(0);
END;
 

DECLARE

type type_aa

IS

  TABLE OF NUMBER INDEX BY VARCHAR2(1);

  l_aa_var1 type_aa;

BEGIN

  l_aa_var1('A'):=65;

  l_aa_var1('B'):=66;

  l_aa_var1('C'):=67;

  l_aa_var1('D'):=68;

  l_aa_var1('E'):=69;

  dbms_output.put_line('The first and last index value of the nested table type L_AA_VAR1 is '||l_aa_var1.first||' and '||l_aa_var1.last);

END;


DECLARE
   CURSOR c1 is
      SELECT ename, empno, sal FROM emp
         ORDER BY sal DESC;   -- start with highest paid employee
   my_ename VARCHAR2(10);
   my_empno NUMBER(4);
   my_sal   NUMBER(7,2);
BEGIN
   OPEN c1;
   FOR i IN 1..5 LOOP
      FETCH c1 INTO my_ename, my_empno, my_sal;
      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */
      INSERT INTO temp VALUES (my_sal, my_empno, my_ename);
      COMMIT;
   END LOOP;
   CLOSE c1;
END;



DECLARE
    v_sal employee.sal%TYPE;
BEGIN


    INSERT INTO employee VALUES (6, 'TOM LEE', 10000);


    UPDATE employee SET sal = sal + 5000 WHERE empno = 6;

      SELECT sal INTO v_sal FROM employee WHERE empno = 6;

    DBMS_OUTPUT.PUT_LINE('Salary increased to ' || v_sal); 

    DELETE FROM employee WHERE empno = 6;

      COMMIT;
END;




CREATE OR REPLACE PROCEDURE Get_TotalSal_ByDept (
    p_recordset OUT SYS_REFCURSOR) AS 
BEGIN 
    OPEN p_recordset FOR
        select SUM(sal) TotalDeptSal, deptno 
        from emp
        group by deptno;
END;




declare
      v_seed number := &numb;
      v_hold number := 1;
   begin
      for i in reverse 1 .. v_seed loop
        v_hold := v_hold * i;
      end loop;
      dbms_output.put_line ('!'||v_seed||' = '||v_hold);
   end;
   
   
CREATE OR REPLACE PROCEDURE greetings 
AS 
BEGIN 
   dbms_output.put_line('Hello World!'); 
END;

EXECUTE greetings;
