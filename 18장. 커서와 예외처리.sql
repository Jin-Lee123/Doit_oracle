SET SERVEROUTPUT ON
--SELECT INTO�� ����� ������ ������ �����ϱ�
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

-- ������ ������ �����ϴ� Ŀ�� ����ϱ�
DECLARE
V_DEPT_ROW DEPT%ROWTYPE; --Ŀ�� �����͸� ������ ������ ����

CURSOR c1 IS --����� Ŀ�� ����(Declaration)
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT
    WHERE DEPTNO = 40;
    
BEGIN
OPEN C1; --Ŀ�� ����(OPEN)

FETCH c1 INTO V_DEPT_ROW; --Ŀ���� ���� �о ������ ���(FETCH)

DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

CLOSE c1; --Ŀ�� �ݱ�(CLOSE)

END;
/

-- ���� ���� �����͸� Ŀ���� �����Ͽ� ����ϱ� (LOOP�� ���)
DECLARE
V_DEPT_ROW DEPT%ROWTYPE; --Ŀ�� �����͸� ������ ������ ����

CURSOR c1 IS --����� Ŀ�� ����(Declaration)
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT;
   
BEGIN
OPEN C1; --Ŀ�� ����(OPEN)

LOOP
    FETCH c1 INTO V_DEPT_ROW; --Ŀ���� ���� �о ������ ���(FETCH)

    EXIT WHEN c1%NOTFOUND; -- Ŀ���� ��� ���� �о���� ���� %NOTFOUND �Ӽ� ����
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                      || 'DNAME : ' || V_DEPT_ROW.DNAME
                      || 'LOC : ' || V_DEPT_ROW.LOC);

END LOOP;

CLOSE c1; --Ŀ�� �ݱ�(CLOSE)

END;
/

-- FOR LOOP���� Ȱ���Ͽ� Ŀ�� ����ϱ�
DECLARE
CURSOR c1 IS --����� Ŀ�� ����(Declaration)
   SELECT DEPTNO, DNAME, LOC
     FROM DEPT;
     
BEGIN
    FOR c1_rec IN c1 LOOP --Ŀ�� FOR LOOP ���� (�ڵ� OPEN,FETCH,CLOSE)
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                          || 'DNAME : ' || c1_rec.DEPTNO
                          || 'LOC : ' || c1_rec.DEPTNO);

END LOOP;

END;
/

--�Ƕ���͸� ����ϴ� Ŀ�� �˾ƺ���
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE; --Ŀ�� �����͸� ������ ������ ����
    CURSOR c1(p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = p_deptno;
BEGIN
    OPEN c1 (10);  --10�� �μ� ó���� ���� Ŀ�� ���
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('10�� �μ� - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                                          || ', LOC : ' || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
    
    OPEN c1 (20); --20�� �μ� ó���� ���� Ŀ�� ���
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('20�� �μ� - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                                          || ', LOC : ' || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
    
END;
/

--Ŀ���� ����� �Ƕ���� �Է� �ޱ�
DECLARE
    v_deptno DEPT.DEPTNO%TYPE; --Ŀ�� �����͸� ������ ������ ����
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

-- ������ Ŀ���� �Ӽ� ����ϱ�
BEGIN 
    UPDATE DEPT SET DNAME = 'DATABASE'
     WHERE DEPTNO = 50;
     
    DBMS_OUTPUT.PUT_LINE('���ŵ� ���� �� : ' || SQL%ROWCOUNT);
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���� ���� : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���� ���� : false');
    END IF;
    
    IF (SQL%ISOPEN) THEN
        DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ���� : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ���� : false');
END IF;

END;
/

--���ܰ� �߻��ϴ� PL/SQL
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
END;    
/

--���ܸ� ó���ϴ� PL/SQL (���� ó�� �߰�)
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

--���� �߻� ���� �ڵ� ���� ���� Ȯ���ϱ�
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
     DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.');
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

--���� ���ǵ� ���� ����ϱ�
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
     DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.');
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('����ó�� : �䱸���� ���� �� ���� ���� �߻�');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('����ó�� : ���� ���� �� ���� �߻�');
END;
/

--���� �ڵ�� ���� �޽��� ����ϱ�
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
     DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('����ó�� : ���� ���� �� ���� �߻�');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/
