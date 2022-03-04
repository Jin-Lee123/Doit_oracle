-- 16-1 PL/SQL 구조
--Hello PL/SQL 출력하기
SET SERVEROUTPUT ON;  --실행 결과를 화면에 출력
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL!');
END;
/

--한줄 주석 사용하기
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
    BEGIN
    V_ENAME := 'SCOTT';
    -- DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);_
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    END;
/

--여러 줄 주석 사용하기
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

-- 16-2 변수와 상수
--변수 선언 및 변수 값 출력하기
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/

--상수에 값을 대입한 후 출력하기
DECLARE
    V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TEX : ' || V_TAX);
END;
/

--변수에 기본값을 설정한 후 출력하기
DECLARE
    V_DEPTNO NUMBER(2) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--변수에 NOT NULL을 설정하고 값을 대입한 후 출력하기
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 8;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--변수에 NOT NULL 및 기본값을 설정한 후 출력하기
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--참조형(열)의 변수에 값을 대입한 후 출력하기
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

--참조형(행)의 변수에 값을 대입한 후 쳘락하기
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

-- 16-3 제어문
--변수에 입력한 값이 홀수인지 알아보기(입력 값이 홀수일 때)
DECLARE
    V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    END IF;
END;
/

--변수에 입력된 값이 홀수인지 알아보기(입력 값이 짝수 일때)
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    END IF;
END;
/

--변수에 입력된 값이 홀수인지 짝수인지 알오보기 (입력 값이 짝수일때)
DECLARE
    V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수입니다!');
    END IF;
END;

--입력한 점수가 어느 학점인지 출력하기(IF-THEN-ELSIF 사용)
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');
    END IF;
END;
/

--입력 점수에 따른 학점 출력하기 (단순 CASE 사용)
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B학점');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C학점');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
/

--입력 점수에 따른 학점 출력하기(검색 CASE사용)  
DECLARE
    V_SCORE NUMBER := 77;
BEGIN
    CASE 
        WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B학점');
        WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C학점');
        WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
/

-- 16-4 반복 제어문
--기본 LOOP 사용하기
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM +1;
        EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/

--WHILE LOOP 사용하기
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    WHILE V_NUM < 6 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM +1;
    END LOOP;
END;
/

--WHILE LOOP 사용하기
BEGIN
    FOR I IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i : ' || I);
    END LOOP;
END;
/

--FOR LOOP사용하기
BEGIN
    FOR I IN REVERSE 0..9 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i : ' || I);
    END LOOP;
END;
/

--FOR LOOP 안에 CONTINUE문 사용하기
BEGIN
    FOR I IN 0..6 LOOP
        CONTINUE WHEN MOD(I,2) =1;
        DBMS_OUTPUT.PUT_LINE('현재 i : ' || I);
    END LOOP;
END;
/