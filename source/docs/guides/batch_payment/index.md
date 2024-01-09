---
title: Introduction to batched payments
layout: tutorial

summary: >
  Introduction to batched credit card, EFT and ACH payments.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.batch_payment
  header_active: Guides

---

# Batch payment

The Batch Payment API allows you to combine multiple transactions into a single API request.

The Batch Payment API supports credit card and bank-to-bank (ACH/EFT) transactions. Each payment type must be processed with a separate batch request. Within a single bank-to-bank request, you can pay (credit) and collect (debit) funds. 

## Use case

1. A gym management software can collect membership fees from customers of multiple gyms and submit as one API call. Customers can make payments from their credit card or directly from their bank account.
1. An accounting department can submit payroll and expense reimbursement to its employees.

Credit card and bank-to-bank transactions have different processing flows, settlement times, and fees.

## Credit cards

### Processing

Credit card transactions can be processed in real-time, or you can schedule them to process on a specific date. If you select a future date, those transactions will be processed at 3:00 AM (PST), on the date you’ve selected.

### Settlement

Settlement for batch credit card transactions is handled in the same way as the regular credit card settlement process. Typically a three day settlement lag can be expected. Higher risk accounts may have a longer settlement time.


### Fees

Credit card fees will depend on your account but a percentage and a flat fee will apply. It's handled through the regular credit card settlement process.

## Bank-to-Bank

### Processing

Bank-to-bank transactions are dependent on bank cut-off times. Therefore, if you want to process a bank-to-bank transaction the same day, you need to submit the request before 11:00 AM (PST).  Any request submitted after this time will be processed the following  day. 

Example processing flow with a 4-business day credit lag.

Day 0: A fitness software uploads a batch file through our Batch Payment API before the 11:00 am PST cut-off time. The fitness software uses the Batch Payment Report API to query the status of the transaction. The transaction status is ‘Scheduled’. 

Day 1: The members of the fitness club are debited; the money is taken out of their bank accounts. The transaction status is ‘In process’. 

Day 2-3: Bambora monitors for transactions being returned, where the money couldn’t be taken out of the members’ bank accounts. If a transaction is returned, the transaction status is ‘Rejected’. 

Day 4: The money is deposited in the bank account of the fitness club. The transaction status is ‘Complete’. 

### Settlement

Settlement for bank-to-bank transactions is typically 4 to 5 business days, to account for the risk associated with return payments. A payment can return if the bank account was closed, invalid, had insufficient funds, or was disputed. The return message typically takes a few days to be passed to Bambora. Therefore we need to ensure the transactions are valid before settling the funds. 

### Fees

Bank-to-bank transactions incur a flat fee. Payments are settled in full, and the fees are aggregated and charged to your account monthly. 

Eg. For a batch with 5 debit transactions and 1 credit transaction, you will be charged for a total of 6 transactions.

### FINTRAC Requirements
Some batch bank transfer transactions require the address of the beneficiary of the funds transfer be submitted along with their name and bank account information. Refer to the following documentation to decide if this applies to your use case: [What is FINTRAC](https://help.na.bambora.com/hc/en-us/articles/22940725297555-What-is-FINTRAC-)

In the case where you are required to provide the address of the beneficiary, you may do so using one of two methods:
1. Store the beneficiary bank account information, name, and address in a Payment Profile, and use this Payment Profile Customer Code in the batch instruction. The beneficiary bank account information, name, and address fields from the Payment Profile will be used automatically, and are not required to be included in the batch file instruction.
2. Include the beneficiary bank account account information, name, and address directly in the batch instruction.

## Supporting Services

For repeat customers or payments, you can use our Payment Profiles solution to store their payment information on our servers securely. 

To query the status of your bank-to-bank batch and individual transactions, you can use our Batch Report API. 
