---
title: Batch Payment API Spec
layout: tutorial

summary: >
  API spec for our Batch Payment API.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.batch_payment
  header_active: References

---

# Batch Payment API

This document lists and describes the properties expected in the request and response objects.

- **URL** - https://api.na.bambora.com/v1/batchpayments
- **Method** - POST

## Request parameters

The following parameters are passed as a JSON object on a Content-Disposition header (`Content-Disposition: form-data; name="criteria"`).

- **process_now** - Overrides process_date parameter and processes transactions on receipt. Credit card transactions only.
  - **1** – Process immediately. Any value passed in the process_date field is ignored.
  - **0** – Transactions are processed on the date passed in the process_date field.
- **process_date** - The date the transactions starts processing. Format **YYYYMMDD**.
- **sub_merchant_id** - The merchant account on which to process the transactions. Required only if request is authorized by a partner account.

### Format of data in file

The API expects a single CSV file with one transaction per row. It does not expect a header row. None of the fields in the file may contain a comma including the address fields. If the transaction is referencing a Payment Profile through populating the Customer Code field in the uploading file, commas in the profile name and address are supported.

The expected format for the data varies according to the transaction type.

#### Canadian funds transfer (EFT)

For batches of EFT transactions, the API expects the following columns:

- **Transaction type** - The type of transaction.
  - E - EFT
- **Transaction type**
  - C – Credit recipient bank accounts
  - D – Debit an outside bank account and depositing funds into your own
- **Financial institution number** - The 3 digit financial institution number
- **Bank transit number** - The 5 digit bank transit number
- **Account number** - The 5-12 digit account number
- **Amount** - Transaction amount in pennies
- **Reference number** - An optional reference number of up to 19 digits. If you don't want a reference number, enter "0" (zero).
- **Recipient name** - Full name of the bank account holder
- **Customer code** - The 32-character customer code located in the Payment Profile. When populating this field, the bank account and address information fields with be referenced from the Payment Profile with any values passed in the file for these fields being ignored.
- **Dynamic descriptor** - By default the Bambora merchant company name will show on your customer's bank statement. You can override this default by populating the Dynamic Descriptor field.
- **Address1** - Address line 1 for the recipient. This field is optional, with a maximum length of 64 characters.
- **Address2** - Address line 2 for the recipient. This field is optional, with a maximum length of 64 characters.
- **City** - City for the recipient. This field is optional, with a maximum length of 32 characters.
- **Province** - Province ID for the recipient. This field is optional, with a maximum length of 2 letters.
    - If the country ID is CA or US, the province ID must be populated with a valid province ID for the respective country.
    - If the country ID is provided and not set to a value of 'CA' or 'US' then Province Id must be empty.
- **Country** - Country ID for the recipient. This field is optional and accepts two-letter ISO country codes. For guidance, please refer to https://en.wikipedia.org/wiki/ISO_3166-2.
- **Postal Code** - Postal Code for the recipient. This field is optional, with a maximum length of 16 characters.
  
  
#### American funds transfer (ACH)

For batches of ACH transactions, the API expects the following columns:

- **Transaction type** - The type of transaction.
  - A - ACH
- **Transaction type**
  - C – Credit recipient bank accounts
  - D – Debit an outside bank account and depositing funds into your own
- **Transit Routing Number** - The 9-digit transit number
- **Account Number** - The 5-15 digit account number
- **Account Code** - Designates the type of bank account
  - PC – Personal Checking
  - PS – Personal Savings
  - CC – Corporate Checking
  - CS – Corporate Savings
- **Amount** - Transaction amount in pennies
- **Reference number** - An optional reference number of up to 19 digits. If you don't want a reference number, enter "0" (zero).
- **Recipient Name** - Full name of the bank account holder
- **Customer Code** - The 32-character customer code located in the Payment Profile. Do not populate bank account fields in the file when processing against a Payment Profile.
- **Dynamic Descriptor** - By default the Bambora merchant company name will show on your customer's bank statement. You can override this default by populating the Dynamic Descriptor field.
- **Standard Entry Code** - Leave blank unless your account has SEC code permissions enabled.
- **Entry Detail Addenda Record** - Leave blank unless your account has SEC code permissions enabled.


#### Credit card

For batches of credit card transactions, the API expects the following columns:

- **Transaction type** - The type of transaction.
  - C - Credit card
- **Transaction type**
  - P – Purchase
  - R – Return
  - PA – Pre-authorization
  - PAC – Pre auth completion
  - VP – Void Purchase
  - VR – Void Return
- **Transaction ID** - The ID of the transaction to be adjusted. Leave this field blank if the transaction type is "P" or "PA".
- **Card Number** - The Card number. Leave this field blank if the Transaction ID is populated.
- **Expiry** - The card expiry date formatted as **MMYY**. If an Adjustment Id is included, this field is optional.
- **Amount** - Transaction amount in pennies. Max length: 9 digits.
- **Reference** - An optional reference number of up to 32 alphanumeric chars.
- **Card Owner** - Name of card owner. Max length: 32 characters.
- **Email** - Max length: 64 characters.
- **Recurring** - Flag to indicate the the bank that you do regular business with the customer. This will not create a  transaction that recurs.
  - 1 – Recurring transaction
  - 0 – Not a recurring transaction
- **Dynamic descriptor** - By default the Bambora merchant company name will show on your customer's bank statement. You can override this default by populating the Dynamic Descriptor field.
- **Customer code** - The 32-character customer code located in the Payment Profile. Do not populate bank account fields in the file when processing against a Payment Profile.
- **Processor Payment Token** - The 19-character TD Payment token.  Leave this field blank if the Adjustment ID is populated, or if either Card Number or Customer Code is populated.


## Response object

### Success

HTTP Status: 200 OK

- **code** - See table below.
- **message** - See table below.
- **batch_id** - A unique identifier for the batch file.
- **process_date** - The date the transactions will begin processing.
- **process_time_zone** - Usually "GMT-08:00".
- **batch_mode** - Indicates whether the batch will be processed.
  - live - If there are no errors, then the batch will be sent to the bank for processing.
  - test - The batch will not be processed.  The merchant account is not in a live state.

### Error

HTTP Status: 400 Bad Request

- **code** - See table below.
- **category** - See table below.
- **message** - See table below.
- **reference** - Always NULL.

## Response Codes

Code | Message
-----|-----
1    | File successfully received
2    | Secure connection required
4    | Authentication failure
5    | Insufficient user permissions
7    | Invalid processing date
8    | Service is busy importing another file. Try again later
9    | File greater than maximum allowable size
10   | Unexpected error - Contact support
11   | Multipart message file content is missing or invalid
14   | Invalid file type
15   | Content type must be set to multipart/form-data
16   | Missing or invalid parameter content
17   | Invalid multipart message structure
18   | Invalid merchant\_id for sub-merchant
19   | Addendum contains invalid characters or too long
20   | Action requires administrator access
21   | Transmitting merchant account is inactive
22   | Submitted sub-merchant account is inactive
23   | Transmitting merchant account is invalid  
26   | Invalid country and/or province/state
27   | Address1 has been truncated to 64 characters
28   | Address2 has been truncated to 64 characters
29   | City has been truncated to 32 characters
30   | Postal code has been truncated to 16 characters

## Response Categories
Category | Description
---------|-----
1        | Technical Problem
2        | Input Data Problem
3        | Business Rule Violation
