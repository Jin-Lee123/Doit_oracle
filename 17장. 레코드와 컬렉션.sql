--레코드 정의해서 사용하기
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno NUMBER(2) NOT NULL := 99,
        dnama DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 99;
    dept_rec.dnama := 'DATABASE';
    dept_rec.loc := 'SEOUL';
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dnama);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
END;
/

--DEPT_RECORD 테이블 생성하기
CREATE TABLE DEPT_RECORD
AS SELECT * FROM DEPT;

--DEPT_RECORD 테이블 생성하기(생성된 테이블 조회)
SELECT * FROM DEPT_RECORD;

--레코드를 사용하여 INSERT 하기
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno NUMBER(2) NOT NULL := 99,
        dnama DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 99;
    dept_rec.dnama := 'DATABASE';
    dept_rec.loc := 'SEOUL';
INSERT INTO DEPT_RECORD
VALUES dept_rec;
END;
/

--레코드를 사용하여 INSERT 하기(생성된 테이블 조회)
SELECT * FROM DEPT_RECORD;

--레코드를 사용하여 UPDATE하기
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno NUMBER(2) NOT NULL := 99,
        dnama DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 50;
    dept_rec.dnama := 'DATABASE';
    dept_rec.loc := 'SEOUL';

    UPDATE DEPT_RECORD
    SET ROW = dept_rec
    WHERE DEPTNO = 99;
END;
/

--레코드를 사용하여 UPDATE하기(생성된 테이블 조회)
SELECT * FROM DEPT_RECORD;

--레코드에 다른 레코드 포함히기
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dnama DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
    TYPE REC_EMP IS RECORD(
        empno EMP.DEPTNO%TYPE,
        ename EMP.DNAME%TYPE,
        dinfo REC_DEPT
        );
BEGIN
    SELECT E.EMPNO, E.NENAME, D.DEPTNO, D.DNAME, D.LOC
    
        INTO emp_rec.empno, emp_rec.ename, 
             emp_rec.dinfo.deptno,
             emp_rec.dinfo.dname,
             emp_rec.dinfo.loc
        FROM EMP E, DEPT D
    WHERE E.DETPNO = D.DEPTNO
    AND E.EMPNO = 7788;
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || emp_rec.dinfo.loc);
END;
/

--연관 배열 사용하기
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
INDEX BY PLS_INTEGER;

    text_arr ITAB_EX;
    
BEGIN
    text_arr(1) := '1st data';
    text_arr(2) := '2st data';
    text_arr(3) := '3st data';
    text_arr(4) := '4st data';
    
    DBMS_OUTPUT.PUT_LINE('text_arr(1) : ' || text_arr(1));
    DBMS_OUTPUT.PUT_LINE('text_arr(2) : ' || text_arr(2));
    DBMS_OUTPUT.PUT_LINE('text_arr(3) : ' || text_arr(3));
    DBMS_OUTPUT.PUT_LINE('text_arr(4) : ' || text_arr(4));
END;
/

--연관 배열 자료형에 레코드 사용하기
DECLARE
    TPYE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dname DEPT.DNAME%TYPE
    );
    
    TYPE ISAB_DEPT IS TABLE OF REC_DEPT
        INDEX BY PLS_INTEGER;
        
    dept_arr ITAB_DEPT;
    idx PLS_INTEGER := 0;
    
BEGIN
    FOR i IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
        idx := idx + 1;
        dept_arr(idx).deptno := i.DEPTNO;
        dept_arr(idx).dname := i.DNAME;
        
        DBMS_OUTPUT.PUT_LINE(
            dept_arr(idx).deptno || ' : ' || dept_arr(idx).dname);
    END LOOP;
END;
/

--%ROWTYPE으로 연관 배열 자료형 지정하기
DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
        INDEX BY PLS_INTEGER;
        
    dept_arr ITAB_DEPT;
    idx PLS_INTEGER := 0;
    
BEGIN
    FOR i IN(SELECT * FROM DEPT) LOOP
        idx := idx + 1;
        dept_arr(idx).deptno := i.DEPTNO;
        dept_arr(idx).dname := i.DNAME;
        dept_arr(idx).loc := i.LOC;
        
        DBMS_OUTPUT.PUT_LINE(
            dept_arr(idx).deptno || ' : ' ||
            dept_arr(idx).dname || ' : ' ||
            dept_arr(idx).loc);
    END LOOP;
END;
/

--컬렉션 메서드 사용하기
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
INDEX BY PLS_INTEGER;

    text_arr ITAB_EX;
    
BEGIN
    text_arr(1) := '1st date';
    text_arr(2) := '2st date';
    text_arr(3) := '3st date';
    text_arr(50) := '50st date';
    
    DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT):
    DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST):
    DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST):
    DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50)):
    DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50)):
    
END;
/