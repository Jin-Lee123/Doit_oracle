SET SERVEROUTPUT ON
--SELECT INTO를 사용한 단일행 데이터 저장하기
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

-- 단일행 데이터 저장하는 커서 사용하기
DECLARE
V_DEPT_ROW DEPT%ROWTYPE; --커서 데이터를 입입할 변수를 선언

CURSOR c1 IS --명시적 커서 선언(Declaration)
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT
    WHERE DEPTNO = 40;
    
BEGIN
OPEN C1; --커서 열기(OPEN)

FETCH c1 INTO V_DEPT_ROW; --커서로 부터 읽어돈 데이터 사용(FETCH)

DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

CLOSE c1; --커서 닫기(CLOSE)

END;
/

-- 여러 행의 데이터를 커서에 저장하여 사용하기 (LOOP문 사용)
DECLARE
V_DEPT_ROW DEPT%ROWTYPE; --커서 데이터를 입입할 변수를 선언

CURSOR c1 IS --명시적 커서 선언(Declaration)
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT;
   
BEGIN
OPEN C1; --커서 열기(OPEN)

LOOP
    FETCH c1 INTO V_DEPT_ROW; --커서로 부터 읽어돈 데이터 사용(FETCH)

    EXIT WHEN c1%NOTFOUND; -- 커서의 모든 행을 읽어오기 위해 %NOTFOUND 속성 지정
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                      || 'DNAME : ' || V_DEPT_ROW.DNAME
                      || 'LOC : ' || V_DEPT_ROW.LOC);

END LOOP;

CLOSE c1; --커서 닫기(CLOSE)

END;
/

-- FOR LOOP문을 활용하여 커서 사용하기
DECLARE
CURSOR c1 IS --명시적 커서 선언(Declaration)
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT;
     
BEGIN
    FOR c1_rec IN c1 LOOP --커서 FOR LOOP 시작 (자동 OPEN,FETCH,CLOSE)
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                          || 'DNAME : ' || c1_rec.DEPTNO
                          || 'LOC : ' || c1_rec.DEPTNO);

END LOOP;

END;
/

--피라미터를 사용하는 커서 알아보기
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE; --커서 데이터를 입입할 변수를 선언
    CURSOR c1(p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = p_deptno;
BEGIN
    OPEN c1 (10);  --10번 부서 처리를 위해 커서 사용
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('10번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                                          || ', LOC : ' || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
    
    OPEN c1 (20); --20번 부서 처리를 위해 커서 사용
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('20번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                                          || ', LOC : ' || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
    
END;
/

--커서에 사용할 피라미터 입력 받기
DECLARE
    v_deptno DEPT.DEPTNO%TYPE; --커서 데이터를 입입할 변수를 선언
    CURSOR c1(p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = p_deptno;
BEGIN
    v_deptno := &INPUT_DEPTNO;
    FOR c1_rec IN c1(v_deptno) LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                         || ', DNAME : ' || c1_rec.DNAME
                           || ', LOC : ' || c1_rec.LOC);
    END LOOP;
END;
/

-- 묵시적 커서의 속성 사용하기
BEGIN 
    UPDATE DEPT SET DNAME = 'DATABASE'
     WHERE DEPTNO = 50;
     
    DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : false');
    END IF;
    
    IF (SQL%ISOPEN) THEN
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : false');
END IF;

END;
/

--예외가 발생하는 PL/SQL
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
END;    
/

--예외를 처리하는 PL/SQL (예외 처러 추가)
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
END;
/

--예외 발생 후의 코드 실행 여부 확인하기
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
END;
/

--사전 정의된 예외 사용하기
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 요구보다 많은 행 추출 오류 발생');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
END;
/

--오류 코드와 오류 메시지 사용하기
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/
