---
title: Statement Report
layout: tutorial

summary: >
    A guide for Partners to integrate directly to the Statement Report API.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Statement Report

## Report Overview

The Statement Report provides an overview of fees charged on your monthly statements.  For partners 
we also provide detail on the fees charged to your sub merchants along with the commission collected.

## Report Columns

For non partner accounts the response will be a JSON-formatted response which will consist of a 
collection of `StatementFeeRecord` records. The fields of each `StatementFeeRecord` are summarized in 
the table below.

| Field | Description |
| ------ | ----------------- |
| `billing_period` | The month and year of the statement |
| `statement_id` | The id of the statement |
| `merchant_id` | The id of the merchant |
| `merchant_name` | The name of the merchant |
| `fee_type` | The enum value of fee type |
| `fee_volume` | The total count for this fee |
| `fee_rate` | The rate charged for this fee |
| `fee_amount` | Amount charged for this fee |

More detailed information about these fields can be found in our API
specification which can be found at:
<https://dev.na.bambora.com/docs/references/payment_APIs/v1-0-5/>

## Report Columns for Partners

For partner accounts the response will be a JSON-formatted response which will consist of a collection 
of `PartnerStatementFeeRecord` records. The fields of each `PartnerStatementFeeRecord` are summarized in 
the table below.

| Field | Description |
| ------ | ----------------- |
| `billing_period` | The month and year of the statement |
| `parent_id` | The id parent account |
| `parent_name` | The name of the parent account |
| `statement_id` | The id of the statement |
| `merchant_id` | The id of the merchant |
| `merchant_name` | The name of the merchant |
| `fee_type` | The enum value of fee type |
| `fee_volume` | The total count for this fee |
| `fee_rate` | The rate charged for this fee |
| `fee_amount` | Amount charged for this fee |
| `commission_rate` | The commission rate for this fee |
| `commission_method` | Set to '$' for fixed rate commission, '%' for percentage based commission, or 'B' for basis points commission. |
| `commission_amount` | Commission amount paid for this fee |

More detailed information about these fields can be found in our API
specification which can be found at:
<https://dev.na.bambora.com/docs/references/payment_APIs/v1-0-5/>

## Getting Started

The Statement Report API is accessed via the URL
<https://api.na.bambora.com/v1/reports/statements>

In addition, you will need use your Merchant ID and Reporting API Access Passcode from your Bambora account. 
See the "Authentication" section below for more details on how to generate your access passcode to use in the 
request to the Statement Report API.

## API Requests

### Request Headers

Requests to the statement endpoint should include two request headers:
a `Content-type` header with the value `application/json` and a `Authorization`
header which is outlined in the next section.

### Authentication

All requests to the Statement Report require authentication in the form of an
`Authorization` header.  This header contains the value `Passcode <YOUR API
ACCESS PASSCODE>` which is an encoded version of your Merchant ID and your
Reporting API Access Passcode.  Note that your Reporting API Access Passcode can
be found in the [Portal](https://web.na.bambora.com) under
**administration** > **account settings** > **order settings**.

`<YOUR API ACCESS PASSCODE>` is created by concatenating your Merchant ID to
your Reporting API Access Passcode (separated by a colon), and then base 64
encoding the result.

As an example, if your Merchant ID is 123456789, and your Reporting API Passcode
is `fd36d245a3584434b904096525547f17`, then using JavaScript your API Access
Passcode could be generated by doing:

```javascript
merchantID = "123456789";
reportingAPIPasscode = "fd36d245a3584434b904096525547f17";

// base 64 encode the two values concatenated with a colon
yourAPIAccessPassCode = btoa(merchantID + ":" + reportingAPIPasscode);
```

In this example `yourAPIAccessPassCode` would be
`MTIzNDU2Nzg5OmZkMzZkMjQ1YTM1ODQ0MzRiOTA0MDk2NTI1NTQ3ZjE3` which is the value
used when making a call to the Statement Report API.

Alternatively, for convenience, you can also use the
[form](https://dev.na.bambora.com/docs/forms/encode_api_passcode/) which does
same calculation.

It is worth noting that while this process obfuscates/obscures your Reporting
API Passcode it is not an *encrypted* value, so this value should be treated with
equal sensitivity/security as your Reporting API Passcode itself.

### Parameters

The Statement Report accepts parameters to control the data returned by the 
endpoint: `start_year`, `start_month`, `end_year`, `end_month`, and `end_date`, all of 
which are supplied as query string parameters on the HTTP GET request. For 
partners we also support passing a sub_merchant_id parameter to filter results 
to a specific sub merchant account.

```no-highlight
Note: Start and end date values are required on all requests to the Statement Report API
```

Statement records will be restricted to the date range specified (inclusive). More 
details are in the formal specification at https://dev.na.bambora.com/docs/references/payment_APIs/v1-0-5/

### Example

An example request is illustrated below.

#### Request

```shell
curl --location --request GET 'https://api.na.bambora.com/v1/reports/statements?start_year=2021&start_month=4&end_year=2021&end_month=7' \
--header 'Authorization: Passcode <YOUR API ACCESS PASSCODE>' \
--header 'Content-Type: application/json'
```

Replace `<YOUR API ACCESS PASSCODE>` with your API passcode.

#### Response

```javascript
{
    "data": [
        [
            {
                "billing_period": "2021-11-01",
                "statement_id": 1003844007,
                "merchant_id": 391020000,
                "fee_type": "AccountMonthly",
                "fee_volume": 1,
                "fee_rate": 10.00,
                "fee_amount": 10.00
            },
            {
                "billing_period": "2021-11-01",
                "statement_id": 1003844007,
                "merchant_id": 391020000,
                "fee_type": "ApprovedCreditCardTransactions",
                "fee_volume": 10,
                "fee_rate": 0.25,
                "fee_amount": 2.50
            },
            {
                "billing_period": "2021-11-01",
                "statement_id": 1003844007,
                "merchant_id": 391020000,
                "fee_type": "DeclinedCardTransactions",
                "fee_volume": 0,
                "fee_rate": 0.10,
                "fee_amount": 0.00
            },
            {
                "billing_period": "2021-04-01",
                "statement_id": 1003844007,
                "merchant_id": 391020000,
                "fee_type": "AdjAccountMonthly",
                "fee_volume": 1,
                "fee_rate": -5.00,
                "fee_amount": -5.00
            }
        ]
    ]
}
```


