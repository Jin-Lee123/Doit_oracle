//6�� ������ ó���� ������ ���� ����Ŭ �Լ�

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;  //UPPER : �빮��, LOWER : �ҹ���, INITCAP : �Ǿ� ���ڸ� �빮�� �� �ҹ���

SELECT * FROM EMP WHERE UPPER(ENAME) = UPPER('scott');  //UPPER �Լ��� ���ڿ� ��

SELECT * FROM EMP WHERE UPPER(ENAME) LIKE UPPER('%scott');  //UPPER �Լ��� ���ڿ� ��

SELECT ENAME, LENGTH(ENAME) FROM EMP;  //LENGTH : ���ڿ�����

SELECT ENAME, LENGTH(ENAME) FROM EMP WHERE LENGTH(ENAME) >= 5;  //����̸��� ���̰� 5�̻��� �� ���

SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') FROM DUAL;

SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5) FROM EMP;  //SUBSTR : ���ڿ� �Ϻ� �����Լ�

SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)), SUBSTR(JOB, -LENGTH(JOB),2), SUBSTR(JOB, -3) FROM EMP;

SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, 
       INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
       INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
  FROM DUAL;     //���ڿ� ������ �ȿ��� Ư�� ���� ��ġ�� ã���Լ� INSTR
  
SELECT * FROM EMP WHERE INSTR(ENAME, 'S') > 0;  //��� �̸��� ���� S�� �ִ� �� ��ȸ

SELECT * FROM EMP WHERE ENAME LIKE '%S%';  //���� ���� ��ȸ��

SELECT '010-1234-5678' AS REPLACE_BEFORE,
       REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1,
       REPLACE('010-1234-5678', '-') AS REPLACE_2
  FROM DUAL;  // Ư�����ڸ� �ٸ����ڷ� �ٲٴ� REPLACE �Լ�
  
SELECT 'Oracle',
       LPAD('Oracle', 10, '#') AS LPAD_1,
       RPAD('Oracle', 10, '*') AS RPAD_1,
       LPAD('Oracle', 10) AS LPAD_2,
       RPAD('Oracle', 10) AS RPAD_2
  FROM DUAL;  //�������� �� ������ Ư�� ���ڷ� ä��� LPAD, RPAD �Լ�
  
SELECT RPAD('971225-', 14, '*') AS RPAD_JMNO,
       RPAD('010-1234-', 13, '*') AS RPAD_PHONE 
  FROM DUAL;  //RPAD�� �������� ���ڸ� *�� ǥ�� ���
  
SELECT CONCAT(EMPNO, ENAME),
       CONCAT(EMPNO, CONCAT(' : ', ENAME))
  FROM EMP
 WHERE ENAME = 'SCOTT'; //�� ���ڿ�����Ʈ�� ��ġ�� CONCAT �Լ�
 
// Ư�����ڸ� ����� TRIM,LTRIM,RTRIM �Լ�
SELECT '[' || TRIM(' _ _Oracle_ _ ') || ']' AS TRIM,
       '[' || TRIM(LEADING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_LEADING,
       '[' || TRIM(TRAILING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_TRAILING,
       '[' || TRIM(BOTH FROM ' _ _Oracle_ _ ') || ']' AS TRIM_BOTH
  FROM DUAL;  //TRIM�Լ��� ���� ���� 
  
SELECT '[' || TRIM('_' FROM '_ _Oracle_ _') || ']' AS TRIM,
       '[' || TRIM(LEADING '_' FROM '_ _Oracle_ _') || ']' AS TRIM_LEADING,
       '[' || TRIM(TRAILING '_' FROM '_ _Oracle_ _') || ']' AS TRIM_TRAILING,
       '[' || TRIM(BOTH '_' FROM '_ _Oracle_ _') || ']' AS TRIM_BOTH
  FROM DUAL;  //TRIM�Լ��� _ ���� 
  
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
       '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
       '[' || LTRIM('<_Oracle_>', '_<') || ']' AS LTRIM_2,
       '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
       '[' || RTRIM('<_Oracle_>', '>_') || ']' AS RTRIM_2
  FROM DUAL;

SELECT ROUND(1234.5678) AS ROUND,
       ROUND(1234.5678, 0) AS ROUND_0,
       ROUND(1234.5678, 1) AS ROUND_1,
       ROUND(1234.5678, 2) AS ROUND_2,
       ROUND(1234.5678, -1) AS ROUND_MINUS1,
       ROUND(1234.5678, -2) AS ROUND_MINUS2
  FROM DUAL;  // Ư�� ��ġ���� �ݿø��ϴ� ROUND �Լ�
  
SELECT TRUNC(1234.5678) AS TRUNC,
       TRUNC(1234.5678, 0) AS TRUNC_0,
       TRUNC(1234.5678, 1) AS TRUNC_1,
       TRUNC(1234.5678, 2) AS TRUNC_2,
       TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
       TRUNC(1234.5678, -2) AS TRUNC_MINUS2
  FROM DUAL;  // Ư�� ��ġ���� ������ TRUNC �Լ�
  
SELECT CEIL(3.14),
       FLOOR(3.14),
       CEIL(-3.14),
       FLOOR(-3.14)
  FROM DUAL;  //������ ���ڿ� ����� ������ ã�� �Լ�
  
SELECT MOD(15,6), MOD(10,2), MOD(11,2) FROM DUAL;  //���ڸ� ���� ������ ���� ���ϴ� MOD�Լ�

SELECT SYSDATE AS NOW,
       SYSDATE-1 AS YESTERDAY,
       SYSDATE+1 AS TOMORROW
  FROM DUAL;  // ��¥ ����Լ�
  
SELECT SYSDATE,
       ADD_MONTHS(SYSDATE, 3)
  FROM DUAL;  //3���� �� ��¥
  
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 120) AS WORK10YESR
  FROM EMP;  //�Ի� 10�ֳ� ��� ������
  
SELECT EMPNO,
       ENAME, HIREDATE, SYSDATE
  FROM EMP
 WHERE ADD_MONTHS(HIREDATE, 384) > SYSDATE;
 
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
       MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
       MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
  FROM EMP;  // �� ��¥ ���� ���� �� ���̸� ���ϴ� MONTHS_BETWEEN�Լ�
  
SELECT SYSDATE,
       NEXT_DAY(SYSDATE, '������'),
       LAST_DAY(SYSDATE)
  FROM DUAL;  // ���ƿ��� ����, ���� ������ ��¥�� ���ϴ� NEXT_DAY, LAST_DAY �Լ�
  
SELECT SYSDATE,
       ROUND(SYSDATE, 'CC') AS FORMAT_CC,
       ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY,
       ROUND(SYSDATE, 'Q') AS FORMAT_Q,
       ROUND(SYSDATE, 'DDD') AS FORMAT_DDD,
       ROUND(SYSDATE, 'HH') AS FORMAT_HH
  FROM DUAL;  //��¥�� �ݿø��ϴ� ROUND �Լ�
  
SELECT SYSDATE,
       TRUNC(SYSDATE, 'CC') AS FORMAT_CC,
       TRUNC(SYSDATE, 'YYYY') AS FORMAT_YYYY,
       TRUNC(SYSDATE, 'Q') AS FORMAT_Q,
       TRUNC(SYSDATE, 'DDD') AS FORMAT_DDD,
       TRUNC(SYSDATE, 'HH') AS FORMAT_HH
  FROM DUAL;  //��¥�� ������ TRUNC �Լ�
  
SELECT EMPNO, ENAME, EMPNO + '500'
  FROM EMP
 WHERE ENAME = 'SCOTT';  //���ڿ� ���ڿ�(����)�� ���Ͽ� ����ϱ�
 
SELECT 'ABCD' + EMPNO, EMPNO
  FROM EMP
 WHERE ENAME = 'SCOTT';  //����
 
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI;SS') AS ���糯¥�ð�
  FROM DUAL;  //��¥, ���� �����͸� ���� �����ͷ� ��ȯ�ϴ� TO_CHAR �Լ�
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON') AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY') AS DY,
       TO_CHAR(SYSDATE, 'DAY') AS DAY
  FROM DUAL; //���� ������ �پ��� �������� ����ϱ�
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG
  FROM DUAL;  //���� ���� ��¥(��) ����ϱ�
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG
  FROM DUAL;  //���� ���� ��¥(����) ����ϱ�
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
       TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
       TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
  FROM DUAL;  // 24��, ����, ����
  
SELECT SAL,
       TO_CHAR(SAL, '$999,999') AS SAL_$,
       TO_CHAR(SAL, 'L999,999') AS SAL_L,
       TO_CHAR(SAL, '999,999.00') AS SAL_1,
       TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
       TO_CHAR(SAL, '000999999.99') AS SAL_3,
       TO_CHAR(SAL, '999,999,00') AS SAL_4
  FROM EMP; //�������� ���� �������� �޿� ����ϱ�
  
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
  FROM DUAL;  //���� �����͸� ���� �����ͷ� ��ȯ�ϴ� TO_NUMBER �Լ�
  
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS TODATE1,
       TO_DATE('20180714', 'YYYY-MM-DD') AS TODATE2
  FROM DUAL;  //TO_DATE�Լ��� ���� �����͸� ��¥ �����ͷ� ��ȯ�ϱ�
  
SELECT * FROM EMP
 WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');  //��¥���� �Ի��� ��� ���
 
SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
       TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49,
       TO_DATE('50/12/10', 'YY/MM/DD') AS YY_YEAR_50,
       TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50,
       TO_DATE('51/12/10', 'YY/MM/DD') AS YY_YEAR_51,
       TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
  FROM DUAL;  // ���� ���� �������� ��¥ ������ ����ϱ�
  
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
       NVL(COMM, 0),
       SAL+NVL(COMM, 0)
  FROM EMP;  //NULL���̸� 0���� ����ϴ� NVL �Լ�
  
SELECT EMPNO, ENAME, COMM,
       NVL2(COMM, '0', 'X'),
       NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
  FROM EMP; //NULL�� �ƴ϶�� 0�� ���, NULL�̶�� X�� ���
  
SELECT EMPNO,ENAME, JOB, SAL,
       DECODE(JOB,
              'MANAGER', SAL*1.1,
              'SALESMAN', SAL*1.05,
              'ANALYST' ,SAL,
              SAL*1.03) AS UPSAL
  FROM EMP;  //DECODE �Լ��� ����Ͽ� ���
  
SELECT EMPNO, ENAME, JOB, SAL,
       CASE JOB
            WHEN 'MANAGER' THEN SAL*1.1
            WHEN 'SALESMAN' THEN SAL*1.05
            WHEN 'ANALYST' THEN SAL
            ELSE SAL*1.03
       END AS UPSAL
  FROM EMP  //CASE �� ����Ͽ� ���
  
SELECT EMPNO, ENAME, COMM,
       CASE
        WHEN COMM IS NULL THEN '�ش���� ����'
        WHEN COMM = 0 THEN '�������'
        WHEN COMM > 0 THEN '���� : ' || COMM
       END AS COMM_TEXT
  FROM EMP;  // �� ���� ���� ��� ���� �޶����� CASE ��
  

  
 


  