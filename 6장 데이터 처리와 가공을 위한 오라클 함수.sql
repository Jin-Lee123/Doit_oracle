//6장 데이터 처리와 가공을 위한 오라클 함수

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;  //UPPER : 대문자, LOWER : 소문자, INITCAP : 맨앞 글자만 대문자 뒤 소문자

SELECT * FROM EMP WHERE UPPER(ENAME) = UPPER('scott');  //UPPER 함수로 문자열 비교

SELECT * FROM EMP WHERE UPPER(ENAME) LIKE UPPER('%scott');  //UPPER 함수로 문자열 비교

SELECT ENAME, LENGTH(ENAME) FROM EMP;  //LENGTH : 문자열길이

SELECT ENAME, LENGTH(ENAME) FROM EMP WHERE LENGTH(ENAME) >= 5;  //사원이름의 길이가 5이상인 행 출력

SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;

SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5) FROM EMP;  //SUBSTR : 문자열 일부 추출함수

SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)), SUBSTR(JOB, -LENGTH(JOB),2), SUBSTR(JOB, -3) FROM EMP;

SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, 
       INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
       INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
  FROM DUAL;     //문자열 데이터 안에서 특정 문자 위치를 찾는함수 INSTR
  
SELECT * FROM EMP WHERE INSTR(ENAME, 'S') > 0;  //사원 이름에 문자 S가 있는 행 조회

SELECT * FROM EMP WHERE ENAME LIKE '%S%';  //위랑 같은 조회문

SELECT '010-1234-5678' AS REPLACE_BEFORE,
       REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1,
       REPLACE('010-1234-5678', '-') AS REPLACE_2
  FROM DUAL;  // 특정문자를 다른문자로 바꾸는 REPLACE 함수
  
SELECT 'Oracle',
       LPAD('Oracle', 10, '#') AS LPAD_1,
       RPAD('Oracle', 10, '*') AS RPAD_1,
       LPAD('Oracle', 10) AS LPAD_2,
       RPAD('Oracle', 10) AS RPAD_2
  FROM DUAL;  //데이터의 빈 공간을 특정 문자로 채우는 LPAD, RPAD 함수
  
SELECT RPAD('971225-', 14, '*') AS RPAD_JMNO,
       RPAD('010-1234-', 13, '*') AS RPAD_PHONE 
  FROM DUAL;  //RPAD로 개인정보 뒷자리 *로 표시 출력
  
SELECT CONCAT(EMPNO, ENAME),
       CONCAT(EMPNO, CONCAT(' : ', ENAME))
  FROM EMP
 WHERE ENAME = 'SCOTT'; //두 문자열데이트럴 합치는 CONCAT 함수
 
// 특정문자를 지우는 TRIM,LTRIM,RTRIM 함수
SELECT '[' || TRIM(' _ _Oracle_ _ ') || ']' AS TRIM,
       '[' || TRIM(LEADING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_LEADING,
       '[' || TRIM(TRAILING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_TRAILING,
       '[' || TRIM(BOTH FROM ' _ _Oracle_ _ ') || ']' AS TRIM_BOTH
  FROM DUAL;  //TRIM함수로 공백 제거 
  
SELECT '[' || TRIM('_' FROM '_ _Oracle_ _') || ']' AS TRIM,
       '[' || TRIM(LEADING '_' FROM '_ _Oracle_ _') || ']' AS TRIM_LEADING,
       '[' || TRIM(TRAILING '_' FROM '_ _Oracle_ _') || ']' AS TRIM_TRAILING,
       '[' || TRIM(BOTH '_' FROM '_ _Oracle_ _') || ']' AS TRIM_BOTH
  FROM DUAL;  //TRIM함수로 _ 제거 
  
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
  FROM DUAL;  // 특정 위치에서 반올림하는 ROUND 함수
  
SELECT TRUNC(1234.5678) AS TRUNC,
       TRUNC(1234.5678, 0) AS TRUNC_0,
       TRUNC(1234.5678, 1) AS TRUNC_1,
       TRUNC(1234.5678, 2) AS TRUNC_2,
       TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
       TRUNC(1234.5678, -2) AS TRUNC_MINUS2
  FROM DUAL;  // 특정 위치에서 버리는 TRUNC 함수
  
SELECT CEIL(3.14),
       FLOOR(3.14),
       CEIL(-3.14),
       FLOOR(-3.14)
  FROM DUAL;  //지정한 숫자와 가까운 정수를 찾는 함수
  
SELECT MOD(15,6), MOD(10,2), MOD(11,2) FROM DUAL;  //숫자를 나눈 나머지 값을 구하는 MOD함수

SELECT SYSDATE AS NOW,
       SYSDATE-1 AS YESTERDAY,
       SYSDATE+1 AS TOMORROW
  FROM DUAL;  // 날짜 출력함수
  
SELECT SYSDATE,
       ADD_MONTHS(SYSDATE, 3)
  FROM DUAL;  //3개월 후 날짜
  
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 120) AS WORK10YESR
  FROM EMP;  //입사 10주년 사원 데이터
  
SELECT EMPNO,
       ENAME, HIREDATE, SYSDATE
  FROM EMP
 WHERE ADD_MONTHS(HIREDATE, 384) > SYSDATE;
 
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
       MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
       MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
  FROM EMP;  // 두 날짜 간의 개월 수 차이를 구하는 MONTHS_BETWEEN함수
  
SELECT SYSDATE,
       NEXT_DAY(SYSDATE, '월요일'),
       LAST_DAY(SYSDATE)
  FROM DUAL;  // 돌아오는 요일, 달의 마지막 날짜를 구하는 NEXT_DAY, LAST_DAY 함수
  
SELECT SYSDATE,
       ROUND(SYSDATE, 'CC') AS FORMAT_CC,
       ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY,
       ROUND(SYSDATE, 'Q') AS FORMAT_Q,
       ROUND(SYSDATE, 'DDD') AS FORMAT_DDD,
       ROUND(SYSDATE, 'HH') AS FORMAT_HH
  FROM DUAL;  //날짜를 반올림하는 ROUND 함수
  
SELECT SYSDATE,
       TRUNC(SYSDATE, 'CC') AS FORMAT_CC,
       TRUNC(SYSDATE, 'YYYY') AS FORMAT_YYYY,
       TRUNC(SYSDATE, 'Q') AS FORMAT_Q,
       TRUNC(SYSDATE, 'DDD') AS FORMAT_DDD,
       TRUNC(SYSDATE, 'HH') AS FORMAT_HH
  FROM DUAL;  //날짜를 버리는 TRUNC 함수
  
SELECT EMPNO, ENAME, EMPNO + '500'
  FROM EMP
 WHERE ENAME = 'SCOTT';  //숫자와 문자열(숫자)을 더하여 출력하기
 
SELECT 'ABCD' + EMPNO, EMPNO
  FROM EMP
 WHERE ENAME = 'SCOTT';  //오류
 
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI;SS') AS 현재날짜시간
  FROM DUAL;  //날짜, 숫자 데이터를 문자 데이터로 변환하는 TO_CHAR 함수
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON') AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY') AS DY,
       TO_CHAR(SYSDATE, 'DAY') AS DAY
  FROM DUAL; //월과 요일을 다양한 형식으로 출력하기
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG
  FROM DUAL;  //여러 언어로 날짜(월) 출력하기
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE' ) AS MON_JPN,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG
  FROM DUAL;  //여러 언어로 날짜(요일) 출력하기
  
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
       TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
       TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
  FROM DUAL;  // 24시, 오전, 오후
  
SELECT SAL,
       TO_CHAR(SAL, '$999,999') AS SAL_$,
       TO_CHAR(SAL, 'L999,999') AS SAL_L,
       TO_CHAR(SAL, '999,999.00') AS SAL_1,
       TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
       TO_CHAR(SAL, '000999999.99') AS SAL_3,
       TO_CHAR(SAL, '999,999,00') AS SAL_4
  FROM EMP; //여러가지 숫자 형식으로 급여 출력하기
  
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
  FROM DUAL;  //문자 데이터를 숫자 데이터로 변환하는 TO_NUMBER 함수
  
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS TODATE1,
       TO_DATE('20180714', 'YYYY-MM-DD') AS TODATE2
  FROM DUAL;  //TO_DATE함수로 문자 데이터를 날짜 데이터로 변환하기
  
SELECT * FROM EMP
 WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');  //날짜이후 입사한 사원 출력
 
SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
       TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49,
       TO_DATE('50/12/10', 'YY/MM/DD') AS YY_YEAR_50,
       TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50,
       TO_DATE('51/12/10', 'YY/MM/DD') AS YY_YEAR_51,
       TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
  FROM DUAL;  // 여러 가지 형식으로 날짜 데이터 출력하기
  
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
       NVL(COMM, 0),
       SAL+NVL(COMM, 0)
  FROM EMP;  //NULL값이면 0으로 출력하는 NVL 함수
  
SELECT EMPNO, ENAME, COMM,
       NVL2(COMM, '0', 'X'),
       NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
  FROM EMP; //NULL이 아니라면 0을 출력, NULL이라면 X를 출력
  
SELECT EMPNO,ENAME, JOB, SAL,
       DECODE(JOB,
              'MANAGER', SAL*1.1,
              'SALESMAN', SAL*1.05,
              'ANALYST' ,SAL,
              SAL*1.03) AS UPSAL
  FROM EMP;  //DECODE 함수를 사용하여 출력
  
SELECT EMPNO, ENAME, JOB, SAL,
       CASE JOB
            WHEN 'MANAGER' THEN SAL*1.1
            WHEN 'SALESMAN' THEN SAL*1.05
            WHEN 'ANALYST' THEN SAL
            ELSE SAL*1.03
       END AS UPSAL
  FROM EMP  //CASE 문 사용하여 출력
  
SELECT EMPNO, ENAME, COMM,
       CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
       END AS COMM_TEXT
  FROM EMP;  // 열 값에 따라서 출력 값이 달라지는 CASE 문
  

  
 


  