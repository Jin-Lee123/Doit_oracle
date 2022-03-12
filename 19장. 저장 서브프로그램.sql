--프로시저 생성하기
CREATE OR REPLACE PROCEDURE pro_noparam
IS
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_EMPNO);
END;
/

--생성한 프로시저 실행하기
SET SERVEROUTPUT ON;
EXECUTE pro_noparam;

--익명 블록에서 프로시저 샐행하기
BEGIN
    pro_noparam;
END;
/

--USER_SOURCE를 통해 프로시저 확인하기(토드)
SELECT *
  FROM USER_SOURCE
 WHERE NAME = 'PRO_NOPARAM';
 
 --USER_SOURCE를 통해 프로시저 확인하기(SQLPLUS)
SELECT TEXT
  FROM USER_SOURCE
 WHERE  NAME = 'PRO_NOPARAM';
 
 --프로시저 삭제하기
 DROP PROCEDURE PRO_NOPARAM;
 
 --프로시저에 파라미터 지정하기
 CREATE OR REPLACE PROCEDURE pro_param_in
 (
    param1 IN NUMBER,
    param2 NUMBER,
    param3 NUMBER := 3,
    param4 NUMBER DEFAULT 4
)
IS

BEGIN
    DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
    DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
    DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
    DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;
/

--파라미터를 입력하여 프로시저 사용하기
EXECUTE pro_param_in(1,2,9,8);

--기본값이 저정된 파라미터 입력을 제외하고 프로시저 사용하기
EXECUTE pro_param_in(1,2);

--실행에 필요한 개수보다 적은 파라미터를 입력하여 프로시저 실행하기
EXECUTE pro_param_in(1);  --에러

--파라미터 이름을 활용하여 프로시저에 값 입력하기
EXECUTE pro_param_in(param1 => 10, param2 => 20);

--OUT 모드 파라미터 정의하기
CREATE OR REPLACE PROCEDURE pro_param_out
(
    in_empno IN EMP.EMPNO%TYPE,
    out_ename OUT EMP.ENAME%TYPE,
    out_sal OUT EMP.SAL%TYPE
)
IS

BEGIN
    SELECT ENAME, SAL INTO out_ename, out_sal
      FROM EMP
     WHERE EMPNO = in_empno;
END pro_param_out;
/

--OUT 모드 파리미터 사용하기
DECLARE
    v_ename EMP.ENAME%TYPE;
    v_sal EMP.SAL%TYPE;
BEGIN
    pro_param_out(7788, v_ename, v_sal);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;
/

--IN OUT 모드 파리미터 정의하기
CREATE OR REPLACE PROCEDURE pro_param_inout
(
    inout_no IN OUT NUMBER
)
IS

BEGIN
    inout_no := inout_no * 2;
END pro_param_inout;
/

--IN OUT 모드 파라미터 사용하기
DECLARE
    no NUMBER;
BEGIN
    no := 5;
    pro_param_inout(no);
    DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;
/

--생성할 때 오류가 발생하는 프로시저 알아보기
CREATE OR REPLACE PROCEDURE pro_err
IS
    err_no NUMBER;
BEGIN
    err_no = 100;
    DBMS_OUTPUT.PUT_LINE('err_no : ' || err_no);
END pro_err;
/

--SHOW ERRORS 명령어로 오류 확인하기
SHOW ERRORS;

--USER_ERRORS로 오류 확인하기
SELECT *
  FROM USER_ERRORS
 WHERE NAME ='PRO_ERR';
 
--함수 생성하기
CREATE OR REPLACE FUNCTION func_aftertax(
    sal IN NUMBER
)
RETURN NUMBER
IS
    tax NUMBER := 0.05;
BEGIN
    RETURN (ROUND(sal - (sal * tax)));
END func_aftertax;
/

--PL/SQL 에서 함수 사용하기
DECLARE
    aftertax NUMBER;
BEGIN
    aftertax := func_aftertax(3000);
    DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
END;
/

--SAL에서 함수 사용하기
SELECT func_aftertax(3000)
  FROM DUAL;
  
--함수에 테이블 데이터 사용하기
SELECT EMPNO, ENAME, SAL, func_aftertax(SAL) AS AFTERTAX
  FROM EMP;
  
--함수 삭제하기
DROP FUNCTION func_aftertax;

--패키지 생성하기
CREATE OR REPLACE PACKAGE pkg_example
IS
    spec_no NUMBER := 10;
    FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

--패키지 명세 확인하기
SELECT TEXT
  FROM USER_SOURCE
 WHERE TYPE = 'PACKAGE'
   AND NAME = 'PKG_EXAMPLE';
   
--패키지 명세 확인하기 (DESC 명령어 조회)
DESC pkg_example;

--패키지 본문 생성하기
CREATE OR REPLACE PACKAGE BOOY pkg_example
IS
    boby_no NUMBER := 10;
    
    FUNCTION func_aftertax(sal NUMBER) RETRUN NUMBER
        IS
            tax NUMBER := 0.05;
        BEGIN
            RETURN (ROUND(sal - (sal * tax)));
    END func_aftertax;
    
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
        IS
            out_ename EMP.ENAME%TYPE;
            out_sal EMP.SAL%TYPE;
        BEGIN
            SELECT ENAME, SAL INTO out_ename, out_sal
              FROM EMP
             WHERE EMPNO = in_empno;
             
             DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
             DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;
        
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
        IS
            out_dname EMP.DNAME%TYPE;
            out_loc EMP.LOC%TYPE;
        BEGIN
            SELECT DNAME, LOC INTO out_dname, out_loc
             FROM EMP
            WHERE EMPNO = in_deptno;
             
            DBMS_OUTPUT.PUT_LINE('DNAME : ' || out_dname);
            DBMS_OUTPUT.PUT_LINE('LOC : ' || out_loc);
    END pro_dept;
END;
/

--프로시저 오버로드하기
CREATE OR REPLACE PACKAGE pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_emp(in_empno IN EMP.ENAME%TYPE);
END;
/

--패키지 본문에서 오버로드된 프로시저 작성하기
CREATE OR REPLACE PACKAGE BOOY pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
        IS
            out_ename EMP.ENAME%TYPE;
            out_sal EMP.SAL%TYPE;
        BEGIN
            SELECT ENAME, SAL INTO out_ename, out_sal
              FROM EMP
             WHERE EMPNO = in_empno;
             
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;
    
    PROCEDURE pro_emp(in_ename IN EMP.ENAME%TYPE)
        IS
            out_ename EMP.ENAME%TYPE;
            out_sal EMP.SAL%TYPE;
        BEGIN
            SELECT ENAME, SAL INTO out_ename, out_sal
              FROM EMP
             WHERE EMPNO = in_ename;
             
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;
    
END;
/

--패키지 포함돤 서브 프로그램 실행하기
BEGIN
    DBMS_OUTPUT.PUT_LINE('--pkg_example.func_aftertax(3000)--');
    DBMS_OUTPUT.PUT_LINE('after-tax:' || pkg_example.func_aftertax(3000));
    
    DBMS_OUTPUT.PUT_LINE('--pkg_example.pro_emp(7788)--');
    pkg_example.pro_emp(7788);
    
    DBMS_OUTPUT.PUT_LINE('--pkg_example.pro_dept(10)--');
    pkg_example.pro_dept(10);
    
    DBMS_OUTPUT.PUT_LINE('--pkg_overload.pro_emp(7788)--');
    pkg_overload.pro_emp(7788);
    
    DBMS_OUTPUT.PUT_LINE('--pkg_overload.pro_emp(''SCOTT'')--');
    pkg_overload.pro_emp('SCOTT');
END;
/

--EMP_TRG 테이블 생성하기
CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;
    
--DML 실행 전에 수행할 트리거 생성하기
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR(sysdate, 'DY') IN ('토', '일') THEN
        IF INSERTING THEN
            raise_application_error(-20000, '주말 사원정보 추가 불가');
        ELSIF UPDATING THEN
            raise_application_error(-20001, '주말 사원정보 수정 불가');
        ELSIF DELETING THEN
            raise_application_error(-20002, '주말 사원종보 삭제 불가');
        ELSE
            raise_application_error(-20003, '주말 사원종보 변경 불가');
        END IF;
    END IF;
END;
/

--평일 날짜로 EMP_TRG테이블 UPDATE 하기
UPDATE emp_trg SET sal = 3500 WHERE empno = 7788;  

--주말 날짜에 EMP_TRG 테이블 UPDATE 하기
UPDATE emp_trg SET sal = 3500 WHERE empno = 7788;

--EMP_TRG_LOG 테이블 생성하기
CREATE TABLE EMP_TRG_LOG(
    TABLENAME VARCHAR2(10),
    DML_TYPE VARCHAR2(10),
    EMPNO NUMBER(4),
    USER_NAME VARCHAR2(30),
    CHANGE_DATE DATE
);

--DML 실행 후 수행할 트리거 생성하기
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW

BEGIN

    IF INSERTING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'INSERT', :new.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
        
    ELSIF UPDATING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'UPDATE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
      
    ELSIF DELETING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
  
    END IF;
END;
/

--EMP_TRG 테이블에 INSERT 하기
INSERT INTO EMP_TRG
    VALUES (9999, 'TestEmp', 'CLERK', 7788, TO_DATE('2018-03-03', 'YYYY-MM-DD'), 1200, NULL, 20);   

COMMIT;

SELECT * FROM EMP_ERG;

--EMP_TRG_LOG 테이블 INSERT 기록 확인하기
SELECT * FROM EMP_TRG_LOG;

--EMP_TRG 테이블에 UPDATE 하기
UPDATE EMP_TRG
   SET SAL = 1300
 WHERE MGR = 7788;
 
COMMIT;

--USER_TRIGGERS로 트리거 정보 확인하기
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME, STATUS
  FROM USER_TRIGGERS;