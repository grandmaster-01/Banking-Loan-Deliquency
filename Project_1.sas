/* Import and clean datasets using PROC IMPORT, SORT. */

PROC IMPORT DATAFILE="/home/u64190696/Banking_Customer_Profiles.csv" 
    OUT=Customer_Profiles 
    DBMS=CSV 
    REPLACE;
    GETNAMES=YES;
RUN;

PROC IMPORT DATAFILE="/home/u64190696/Banking_Loan_Transactions.csv" 
    OUT=Loan_Transactions 
    DBMS=CSV 
    REPLACE;
    GETNAMES=YES;
RUN;

/*Inspect Data */
PROC PRINT DATA=Customer_Profiles (OBS=10);
RUN;
PROC PRINT DATA=Loan_Transactions (OBS=10);
RUN;

/*Sort and Merge */
PROC SORT DATA=Customer_Profiles; BY Customer_ID;
RUN;
PROC SORT DATA=Loan_Transactions; BY Customer_ID;
RUN;

DATA Clean_Loan_Data;
    MERGE Customer_Profiles(IN=a) Loan_Transactions(IN=b);
    BY Customer_ID;
    IF a AND b;
RUN;


/* Create derived variables: Account_Age, Total_Liability. */
DATA Clean_Loan_Data;
    SET Clean_Loan_Data;

    /* Calculate Account_Age */
    Account_Age = YEAR(TODAY()) - Account_Open_Year;

    /* Convert Account_Age to Months */
    Account_Age_Months = Account_Age * 12;
    
    /* Total_Liability = Loan_Amount + Missed Payments */
    Total_Liability = Loan_Amount + (Monthly_Installment * Repayments_Missed);

    /* Delinquency Flag */
    IF Repayments_Missed >= 2 THEN Delinquency_Flag = 1;
    ELSE Delinquency_Flag = 0;
RUN;

/*Use PROC MEANS to analyze Loan_Amount and Installment trends by Income levels. */
PROC MEANS DATA=Clean_Loan_Data N MEAN MAXDEC=2;
    CLASS Income;
    VAR Loan_Amount Monthly_Installment;
RUN;


/* Use PROC SQL to find average and max EMI per region.*/
PROC SQL;
    SELECT City, 
           AVG(Monthly_Installment) AS Avg_EMI,
           MAX(Monthly_Installment) AS Max_EMI
    FROM Clean_Loan_Data
    GROUP BY City;
QUIT;


/*Use PROC FREQ to classify Account_Type-wise delinquents.*/
PROC FREQ DATA=Clean_Loan_Data;
    TABLES Account_Type*Delinquency_Flag / NOCUM NOPERCENT;
RUN;


/* Apply PROC CORR between Income, Loan_Amount, EMI, and Delinquency. */
PROC CORR DATA=Clean_Loan_Data;
    VAR Income Loan_Amount Monthly_Installment Delinquency_Flag;
RUN;


/* Use PROC LOGISTIC to predict Delinquency_Flag using age, income, and loan info. */
PROC LOGISTIC DATA=Clean_Loan_Data;
    MODEL Delinquency_Flag(event='1') = Age Income Loan_Amount Monthly_Installment;
RUN;


/* Apply PROC TRANSPOSE to restructure EMI amounts by month.*/
PROC TRANSPOSE DATA=Clean_Loan_Data
    OUT=EMI_Reshaped
    PREFIX=EMI_;
    BY Customer_ID;
    ID Account_Age_Months;
    VAR Monthly_Installment;
RUN;






