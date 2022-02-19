SELECT SAL FROM EMP WHERE ENAME = 'JONES';

SELECT * FROM EMP WHERE SAL > 2975;

SELECT *
  FROM EMP 
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES');
            
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'SCOTT');
                    
SELECT E.EMPNO, E.NAME, E.JOB, E.SAL, D.DEPTNO, D.NAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL > (SELECT AVG(SAL)
                  FROM EMP);
                  
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20,30);
 
SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                 FROM EMP
                GROUP BY DEPTNO);
                
SELECT MAX(SAL)
  FROM EMP
 GROUP BY DEPTNO;
 
-- ANY, SOME 연산자
SELECT *
  FROM EMP
 WHERE SAL = ANY (SELECT MAX(SAL)
                    FROM EMP
                   GROUP BY DEPTNO);
                   
SELECT *
  FROM EMP
 WHERE SAL = SOME (SELECT MAX(SAL)
                     FROM EMP
                    GROUP BY DEPTNO);
                    
SELECT *
  FROM EMP
 WHERE SAL < ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;

SELECT SAL
  FROM EMP
 WHERE DEPTNO = 30;
 
SELECT * 
  FROM EMP
 WHERE SAL > ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
                   
-- ALL 연산자
SELECT *
  FROM EMP
 WHERE SAL < ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
                   
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
                   
--EXISTS 연산자
SELECT *
  FROM EMP
 WHERE EXISTS (SELECT DNAME
                 FROM DEPT
                WHERE DEPTNO = 10);
                
SELECT *
  FROM EMP
 WHERE EXISTS (SELECT DNAME
                 FROM DEPT
                WHERE DEPTNO = 50);
                
--다중열 서브쿼리
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                          GROUP BY DEPTNO);

-- 인라인 뷰 사용하기                         
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
       (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
--WITH절 사용하기
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D   AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
 WHERE E10.DEPTNO = D.DEPTNO;
 
SELECT EMPTNO, ENAME, JOB, SAL,
       (SELECT GRADE
          FROM SALGRADE
         WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
        DEPTNO,
        (SELECT DNAME
           FROM DEPT
          WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
  FROM EMP E;
 
