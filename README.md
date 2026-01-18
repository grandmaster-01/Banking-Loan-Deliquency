# Banking Loan Delinquency Detection and Customer Segmentation

A comprehensive SAS-based analytics project focused on detecting banking loan delinquency patterns and segmenting customers based on their payment behaviors and financial profiles.

## Overview

This project analyzes banking customer profiles and loan transaction data to identify delinquency patterns, understand customer behavior, and provide actionable insights for risk management. The analysis uses SAS programming to merge datasets, create derived variables, and apply statistical and predictive modeling techniques.

## Project Objectives

- **Delinquency Detection**: Identify customers who are at risk of loan default based on missed repayments
- **Customer Segmentation**: Classify customers by account type, income level, and geographic location
- **Risk Analysis**: Analyze correlations between customer attributes (age, income) and loan delinquency
- **Predictive Modeling**: Build a logistic regression model to predict delinquency probability

## Datasets

The project uses two primary CSV datasets:

### 1. Banking_Customer_Profiles.csv
Contains demographic and account information for 1,000 customers.

**Fields:**
- `Customer_ID`: Unique identifier for each customer
- `Age`: Customer age in years
- `Income`: Annual income
- `City`: Customer location (Delhi, Chennai, etc.)
- `Account_Type`: Type of bank account (Savings, Current)
- `Account_Open_Year`: Year the account was opened

### 2. Banking_Loan_Transactions.csv
Contains loan and repayment details for each customer.

**Fields:**
- `Customer_ID`: Unique identifier (links to Customer Profiles)
- `Loan_Amount`: Total loan amount disbursed
- `Monthly_Installment`: Monthly EMI payment amount
- `Repayments_Missed`: Number of missed monthly payments
- `Tenure`: Loan duration in months (36, 48, 60)

## Analysis Workflow

The SAS program (`Project_1.sas`) performs the following analyses:

### 1. Data Import and Preparation
- Import both CSV files using `PROC IMPORT`
- Sort datasets by Customer_ID for merging
- Perform inner merge to create unified dataset

### 2. Feature Engineering
- **Account_Age**: Calculated as current year minus account opening year
- **Account_Age_Months**: Account age converted to months
- **Total_Liability**: Sum of loan amount and penalties from missed payments
- **Delinquency_Flag**: Binary indicator (1 if ≥2 missed payments, 0 otherwise)

### 3. Descriptive Statistics
- **PROC MEANS**: Analyze loan amounts and monthly installments by income level
- **PROC SQL**: Calculate average and maximum EMI by city/region
- **PROC FREQ**: Cross-tabulation of account types and delinquency status

### 4. Correlation Analysis
- **PROC CORR**: Examine relationships between income, loan amount, EMI, and delinquency

### 5. Predictive Modeling
- **PROC LOGISTIC**: Build logistic regression model to predict delinquency using:
  - Age
  - Income
  - Loan Amount
  - Monthly Installment

### 6. Data Transformation
- **PROC TRANSPOSE**: Restructure EMI data by account age for time-series analysis

## Key Features

- ✅ Comprehensive data cleaning and integration
- ✅ Automated delinquency flag creation (≥2 missed payments)
- ✅ Multi-dimensional analysis (demographic, geographic, behavioral)
- ✅ Statistical correlation analysis
- ✅ Logistic regression for delinquency prediction
- ✅ Region-wise EMI performance metrics

## Prerequisites

- **SAS Software** (SAS 9.4 or later recommended)
- Access to SAS procedures: IMPORT, SORT, MEANS, SQL, FREQ, CORR, LOGISTIC, TRANSPOSE
- Basic understanding of SAS programming and statistical concepts

## Usage Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/grandmaster-01/Banking-Loan-Deliquency.git
   cd Banking-Loan-Deliquency
   ```

2. **Update file paths in SAS script**
   - Open `Project_1.sas` in SAS Editor
   - Update the file paths in PROC IMPORT statements to match your local directory:
     ```sas
     PROC IMPORT DATAFILE="your/path/Banking_Customer_Profiles.csv"
     PROC IMPORT DATAFILE="your/path/Banking_Loan_Transactions.csv"
     ```

3. **Run the SAS program**
   - Execute the entire `Project_1.sas` script in SAS
   - Review outputs in the Results Viewer

4. **Review insights**
   - Check the generated PDF: `Project 1 insights-Banking loan delinquency detection and customer segmention.pdf`
   - Analyze statistical outputs and model results

## Project Structure

```
Banking-Loan-Deliquency/
│
├── README.md                              # Project documentation (this file)
├── Project_1.sas                          # Main SAS analysis script
├── Banking_Customer_Profiles.csv          # Customer demographic data (1,000 records)
├── Banking_Loan_Transactions.csv          # Loan transaction data (1,000 records)
└── Project 1 insights-Banking loan...pdf  # Analysis insights and findings
```

## Expected Outputs

Running the SAS script generates:

1. **Merged Dataset**: `Clean_Loan_Data` with all customer and loan attributes
2. **Descriptive Statistics**: Loan amount and EMI trends by income level
3. **Regional Analysis**: Average and maximum EMI by city
4. **Delinquency Classification**: Frequency table of delinquents by account type
5. **Correlation Matrix**: Relationships between numerical variables
6. **Logistic Regression Model**: Coefficients and odds ratios for delinquency prediction
7. **Transposed Data**: `EMI_Reshaped` dataset for temporal analysis

## Key Insights

Based on the analysis, the project provides insights on:

- Which customer segments are most likely to default on loans
- Relationship between income levels and loan repayment behavior
- Geographic patterns in loan delinquency
- Impact of loan amount and EMI on default probability
- Predictive factors for identifying high-risk customers

## Use Cases

This analysis is valuable for:

- **Risk Management Teams**: Identify high-risk customers for early intervention
- **Loan Underwriting**: Set appropriate loan limits based on customer profiles
- **Collections Strategy**: Prioritize collection efforts based on delinquency probability
- **Product Development**: Design loan products suited to different customer segments
- **Portfolio Management**: Monitor loan portfolio health and regional performance

## Author

This project demonstrates SAS programming skills for banking analytics, including data manipulation, statistical analysis, and predictive modeling.

## License

This project is available for educational and reference purposes.
