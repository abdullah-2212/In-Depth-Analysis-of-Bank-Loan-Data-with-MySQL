# In-Depth Analysis of Bank Loan Data with MySQL

This project analyzes bank loan data using MySQL, focusing on financial trends such as total loan amounts, loan statuses, borrower characteristics, and payment histories. Through SQL queries applied across two joined datasets (**finance_1** and **finance_2**), the project explores metrics like loan distribution over time, borrower credit quality, and payment completion patterns.

**Data Sources**

* **finance_1:** Holds primary loan data, including details on loan issuance, loan amounts, statuses, and more.

* **finance_2:** Contains supplementary information, including revolving balances, payment records, and last credit pull dates. Both datasets share the id field as the linking key.
  
**Project Layout**
The project is organized into SQL-based analytical sections, with each query tailored to uncover specific insights, such as borrower payment behavior, credit distribution, and loan volume trends over different years.

**Key Analytical Queries**

**1) Annual Loan Amount Summary**

* **Purpose:** Calculates the total loan volume for each year of issuance.
  
* **SQL Query:**

      SELECT YEAR(issue_d) AS Year, SUM(loan_amnt) AS Total_Loan_Amount
      FROM finance_1
      GROUP BY Year
      ORDER BY Year;

* **Insight:** Identifies trends in total loan amounts over time.
 
* **Result:** Annual total loan amounts.
 
**2) Revolving Balances by Loan Grade and Sub-Grade**

* **Purpose:** Summarizes revolving balances by loan grade and sub-grade to assess borrower credit quality.

* **SQL Query:**

      SELECT grade, sub_grade, SUM(revol_bal) AS Total_Revolving_Balance
      FROM finance_1
      INNER JOIN finance_2 ON finance_1.id = finance_2.id
      GROUP BY grade, sub_grade
      ORDER BY grade, sub_grade;

* **Insight:** Examines revolving balances for different credit grades.
  
* **Result:** Total revolving balances by grade and sub-grade.
  
**3) Payment Totals by Verification Status**

* **Purpose:** Compares total payments made by borrowers with verified versus non-verified statuses.

* **SQL Query:**

      SELECT verification_status, 
      CONCAT("$",FORMAT(ROUND(SUM(total_pymnt)/1000000,2),2),"M") AS Total_Payment
      FROM finance_1
      INNER JOIN finance_2 ON finance_1.id = finance_2.id
      GROUP BY verification_status;

* **Insight:** Provides insights into financial performance based on verification status.

* **Result:** Total payment amounts segmented by verification status.

**4) Loan Status Analysis by State and Credit Pull Date**

* **Purpose:** Displays loan statuses by state, segmented by the last credit pull date.

* **SQL Query:**

      SELECT addr_state, last_credit_pull_d, loan_status
      FROM finance_1
      INNER JOIN finance_2 ON finance_1.id = finance_2.id
      GROUP BY addr_state, last_credit_pull_d, loan_status
      ORDER BY last_credit_pull_d;

* **Insight:** Highlights loan statuses across states and the timeline of credit pulls.

* **Result:** Loan statuses categorized by state and credit pull date.

**5) Home Ownership Influence on Payment Amounts**

* **Purpose:** Investigates the impact of home ownership on borrower payment patterns.

* **SQL Query:**

      SELECT home_ownership, last_pymnt_d, 
      CONCAT("$",FORMAT(ROUND(SUM(last_pymnt_amnt)/10000,2),2),"k") AS Total_Last_Payment
      FROM finance_1
      INNER JOIN finance_2 ON finance_1.id = finance_2.id
      GROUP BY home_ownership, last_pymnt_d
      ORDER BY last_pymnt_d DESC, home_ownership DESC;

* **Insight:** Analyzes how home ownership correlates with payment behavior.

* **Result:** Total payment amounts by home ownership and payment date.

**Conclusion**

This project demonstrates the analytical strength of SQL for banking and financial datasets, uncovering essential patterns in loan distribution, borrower credit profiles, and payment behaviors. Each query offers a piece of the bigger picture in understanding bank lending practices.














