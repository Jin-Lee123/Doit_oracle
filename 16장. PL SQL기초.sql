-- 16-1 PL/SQL ����
--Hello PL/SQL ����ϱ�
SET SERVEROUTPUT ON;  --���� ����� ȭ�鿡 ���
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL!');
END;
/

--���� �ּ� ����ϱ�
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
    BEGIN
    V_ENAME := 'SCOTT';
    -- DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);_
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    END;
/

--���� �� �ּ� ����ϱ�
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
    BEGIN
    V_ENAME := 'SCOTT';
    /*
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);_
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    */
    END;
/

-- 16-2 ������ ���
--���� ���� �� ���� �� ����ϱ�
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/

--����� ���� ������ �� ����ϱ�
DECLARE
    V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TEX : ' || V_TAX);
END;
/

--������ �⺻���� ������ �� ����ϱ�
DECLARE
    V_DEPTNO NUMBER(2) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--������ NOT NULL�� �����ϰ� ���� ������ �� ����ϱ�
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 8;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--������ NOT NULL �� �⺻���� ������ �� ����ϱ�
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--������(��)�� ������ ���� ������ �� ����ϱ�
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--������(��)�� ������ ���� ������ �� �x���ϱ�
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
      FROM DEPT
     WHERE DEPTNO = 40;
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;
/

-- 16-3 ���
--������ �Է��� ���� Ȧ������ �˾ƺ���(�Է� ���� Ȧ���� ��)
DECLARE
    V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    END IF;
END;
/

--������ �Էµ� ���� Ȧ������ �˾ƺ���(�Է� ���� ¦�� �϶�)
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    END IF;
END;
/

--������ �Էµ� ���� Ȧ������ ¦������ �˿����� (�Է� ���� ¦���϶�)
DECLARE
    V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� ¦���Դϴ�!');
    END IF;
END;

--�Է��� ������ ��� �������� ����ϱ�(IF-THEN-ELSIF ���)
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F����');
    END IF;
END;
/

--�Է� ������ ���� ���� ����ϱ� (�ܼ� CASE ���)
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A����');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A����');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B����');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C����');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D����');
        ELSE DBMS_OUTPUT.PUT_LINE('F����');
    END CASE;
END;
/

--�Է� ������ ���� ���� ����ϱ�(�˻� CASE���)  
DECLARE
    V_SCORE NUMBER := 77;
BEGIN
    CASE 
        WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A����');
        WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B����');
        WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C����');
        WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D����');
        ELSE DBMS_OUTPUT.PUT_LINE('F����');
    END CASE;
END;
/

-- 16-4 �ݺ� ���
--�⺻ LOOP ����ϱ�
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM +1;
        EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/

--WHILE LOOP ����ϱ�
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    WHILE V_NUM < 6 LOOP
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM +1;
    END LOOP;
END;
/

--WHILE LOOP ����ϱ�
BEGIN
    FOR I IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('���� i : ' || I);
    END LOOP;
END;
/

--FOR LOOP����ϱ�
BEGIN
    FOR I IN REVERSE 0..9 LOOP
        DBMS_OUTPUT.PUT_LINE('���� i : ' || I);
    END LOOP;
END;
/

--FOR LOOP �ȿ� CONTINUE�� ����ϱ�
BEGIN
    FOR I IN 0..6 LOOP
        CONTINUE WHEN MOD(I,2) =1;
        DBMS_OUTPUT.PUT_LINE('���� i : ' || I);
    END LOOP;
END;
/