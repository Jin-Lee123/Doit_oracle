--���ν��� �����ϱ�
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

--������ ���ν��� �����ϱ�
SET SERVEROUTPUT ON;
EXECUTE pro_noparam;

--�͸� ��Ͽ��� ���ν��� �����ϱ�
BEGIN
    pro_noparam;
END;
/

--USER_SOURCE�� ���� ���ν��� Ȯ���ϱ�(���)
SELECT *
  FROM USER_SOURCE
 WHERE NAME = 'PRO_NOPARAM';
 
 --USER_SOURCE�� ���� ���ν��� Ȯ���ϱ�(SQLPLUS)
SELECT TEXT
  FROM USER_SOURCE
 WHERE  NAME = 'PRO_NOPARAM';
 
 --���ν��� �����ϱ�
 DROP PROCEDURE PRO_NOPARAM;
 
 --���ν����� �Ķ���� �����ϱ�
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

--�Ķ���͸� �Է��Ͽ� ���ν��� ����ϱ�
EXECUTE pro_param_in(1,2,9,8);

--�⺻���� ������ �Ķ���� �Է��� �����ϰ� ���ν��� ����ϱ�
EXECUTE pro_param_in(1,2);

--���࿡ �ʿ��� �������� ���� �Ķ���͸� �Է��Ͽ� ���ν��� �����ϱ�
EXECUTE pro_param_in(1);  --����

--�Ķ���� �̸��� Ȱ���Ͽ� ���ν����� �� �Է��ϱ�
EXECUTE pro_param_in(param1 => 10, param2 => 20);

--OUT ��� �Ķ���� �����ϱ�
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

--OUT ��� �ĸ����� ����ϱ�
DECLARE
    v_ename EMP.ENAME%TYPE;
    v_sal EMP.SAL%TYPE;
BEGIN
    pro_param_out(7788, v_ename, v_sal);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;
/

--IN OUT ��� �ĸ����� �����ϱ�
CREATE OR REPLACE PROCEDURE pro_param_inout
(
    inout_no IN OUT NUMBER
)
IS

BEGIN
    inout_no := inout_no * 2;
END pro_param_inout;
/

--IN OUT ��� �Ķ���� ����ϱ�
DECLARE
    no NUMBER;
BEGIN
    no := 5;
    pro_param_inout(no);
    DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;
/

--������ �� ������ �߻��ϴ� ���ν��� �˾ƺ���
CREATE OR REPLACE PROCEDURE pro_err
IS
    err_no NUMBER;
BEGIN
    err_no = 100;
    DBMS_OUTPUT.PUT_LINE('err_no : ' || err_no);
END pro_err;
/

--SHOW ERRORS ��ɾ�� ���� Ȯ���ϱ�
SHOW ERRORS;

--USER_ERRORS�� ���� Ȯ���ϱ�
SELECT *
  FROM USER_ERRORS
 WHERE NAME ='PRO_ERR';
 
--�Լ� �����ϱ�
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

--PL/SQL ���� �Լ� ����ϱ�
DECLARE
    aftertax NUMBER;
BEGIN
    aftertax := func_aftertax(3000);
    DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
END;
/

--SAL���� �Լ� ����ϱ�
SELECT func_aftertax(3000)
  FROM DUAL;
  
--�Լ��� ���̺� ������ ����ϱ�
SELECT EMPNO, ENAME, SAL, func_aftertax(SAL) AS AFTERTAX
  FROM EMP;
  
--�Լ� �����ϱ�
DROP FUNCTION func_aftertax;

--��Ű�� �����ϱ�
CREATE OR REPLACE PACKAGE pkg_example
IS
    spec_no NUMBER := 10;
    FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

--��Ű�� �� Ȯ���ϱ�
SELECT TEXT
  FROM USER_SOURCE
 WHERE TYPE = 'PACKAGE'
   AND NAME = 'PKG_EXAMPLE';
   
--��Ű�� �� Ȯ���ϱ� (DESC ��ɾ� ��ȸ)
DESC pkg_example;

--��Ű�� ���� �����ϱ�
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

--���ν��� �����ε��ϱ�
CREATE OR REPLACE PACKAGE pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_emp(in_empno IN EMP.ENAME%TYPE);
END;
/

--��Ű�� �������� �����ε�� ���ν��� �ۼ��ϱ�
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

--��Ű�� ���Ե� ���� ���α׷� �����ϱ�
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

--EMP_TRG ���̺� �����ϱ�
CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;
    
--DML ���� ���� ������ Ʈ���� �����ϱ�
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR(sysdate, 'DY') IN ('��', '��') THEN
        IF INSERTING THEN
            raise_application_error(-20000, '�ָ� ������� �߰� �Ұ�');
        ELSIF UPDATING THEN
            raise_application_error(-20001, '�ָ� ������� ���� �Ұ�');
        ELSIF DELETING THEN
            raise_application_error(-20002, '�ָ� ������� ���� �Ұ�');
        ELSE
            raise_application_error(-20003, '�ָ� ������� ���� �Ұ�');
        END IF;
    END IF;
END;
/

--���� ��¥�� EMP_TRG���̺� UPDATE �ϱ�
UPDATE emp_trg SET sal = 3500 WHERE empno = 7788;  

--�ָ� ��¥�� EMP_TRG ���̺� UPDATE �ϱ�
UPDATE emp_trg SET sal = 3500 WHERE empno = 7788;

--EMP_TRG_LOG ���̺� �����ϱ�
CREATE TABLE EMP_TRG_LOG(
    TABLENAME VARCHAR2(10),
    DML_TYPE VARCHAR2(10),
    EMPNO NUMBER(4),
    USER_NAME VARCHAR2(30),
    CHANGE_DATE DATE
);

--DML ���� �� ������ Ʈ���� �����ϱ�
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

--EMP_TRG ���̺� INSERT �ϱ�
INSERT INTO EMP_TRG
    VALUES (9999, 'TestEmp', 'CLERK', 7788, TO_DATE('2018-03-03', 'YYYY-MM-DD'), 1200, NULL, 20);   

COMMIT;

SELECT * FROM EMP_ERG;

--EMP_TRG_LOG ���̺� INSERT ��� Ȯ���ϱ�
SELECT * FROM EMP_TRG_LOG;

--EMP_TRG ���̺� UPDATE �ϱ�
UPDATE EMP_TRG
   SET SAL = 1300
 WHERE MGR = 7788;
 
COMMIT;

--USER_TRIGGERS�� Ʈ���� ���� Ȯ���ϱ�
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME, STATUS
  FROM USER_TRIGGERS;