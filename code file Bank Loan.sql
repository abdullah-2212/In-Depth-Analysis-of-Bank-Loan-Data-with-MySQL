
-- first we creat our database 
CREATE DATABASE Bank_Loan_Project;

-- then we import our csv files
SELECT * FROM finance_1;

SELECT * FROM finance_2;

-- to see the total number of rows from table one
SELECT COUNT(*) FROM finance_1; 

SELECT COUNT(*) FROM finance_2;
 
-- we can analyze the data on the basis of the following statements

-- 1) Year wise loan amount
SELECT YEAR(issue_d) as Year_of_issue_d, SUM(loan_amnt) as Total_loan_amount
FROM finance_1
GROUP BY Year_of_issue_d
ORDER BY Year_of_issue_d;

-- 2) Grade and sub-grade wise revolution balance
SELECT grade, sub_grade, SUM(revol_bal) As Total_revol_bal
FROM finance_1
INNER JOIN finance_2
      ON finance_1.id = finance_2.id
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade;

-- 3) Total payment for Verfied status VS Non Verified Status
SELECT verification_status, ROUND(SUM(total_pymnt),2) As Total_payment
FROM finance_1
INNER JOIN finance_2
      ON finance_1.id = finance_2.id
GROUP BY verification_status;

-- or we can also do this if we want

SELECT verification_status, 
CONCAT("$",FORMAT(ROUND(SUM(total_pymnt)/1000000,2),2),"M") As Total_payment
FROM finance_1
INNER JOIN finance_2
      ON finance_1.id = finance_2.id
GROUP BY verification_status;

-- 4) State wise last credit pull _d wise loan status
SELECT addr_statE, last_credit_pull_d, loan_status
FROM finance_1
INNER JOIN finance_2
      ON finance_1.id = finance_2.id
GROUP BY addr_statE, last_credit_pull_d, loan_status
ORDER BY last_credit_pull_d;

-- 5) Home ownership Vs last payment date status
SELECT home_ownership, last_pymnt_d,
CONCAT("$",FORMAT(ROUND(SUM(last_pymnt_amnt)/10000,2),2),"k") As Total_amount
FROM finance_1
INNER JOIN finance_2
      ON finance_1.id = finance_2.id
GROUP BY home_ownership, last_pymnt_d
ORDER BY  last_pymnt_d DESC, home_ownership DESC;




