---
title: Credential-on-File Transactions - Overview
layout: tutorial

summary: A Credential-on-File transaction occurs when a cardholder expressly authorizes a merchant to store the cardholder’s payment credentials 
         (i.e. primary account number and expiration date) for subsequent use in connection with one or more later transaction(s) with that merchant, 
         and subsequently authorizes that merchant to use the stored credentials in one or more transaction(s).

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: false
    header_active: guides
---

# Credential-on-File Transactions

A Credential-on-File transaction occurs when a cardholder expressly authorizes a merchant to store the cardholder’s payment credentials 
(i.e. primary account number and expiration date) for subsequent use in connection with one or more later transaction(s) with that merchant, 
and subsequently authorizes that merchant to use the stored credentials in one or more transaction(s).

Effective 12 October 2018 for all acquirers in the Canada region, and 12 June 2018 for all acquirers in all other regions, a Credential-on-File 
indicator must be included along with the transaction data needed for processing a Credential-on-File authorization request.  As a result, merchants 
are required to update their integration with the Bambora payment APIs to pass along the Credential-on-File indicator when processing Credential-on-File 
transactions.  If a Credential-on-File transaction containing no Credential-on-File indicator is detected by the Bambora payment platform, then a default 
indicator will be assigned automatically when processing the transaction.

## Payments REST API

When calling the Bambora Payments REST API, a new JSON object has been added to the PaymentRequest JSON object to support the passing of the 
Credential-on-File indicator for Credential-on-File transactions.  The new JSON object has the following structure:

```
"card_on_file": {
    "type": <string enum - specifies the nature of how the stored credential is being used>,
    "series_id": <number - identifies the set of transactions that this transaction belongs to>
}
```

This new JSON object is also returned back as part of the PaymentResponse JSON object, identifying the Credential-on-File type that the transaction 
was processed as, and the series ID that it belongs to. The series ID is unique for each merchant account, and cannot be used to reference a string of transactions from another account.

For documentation on how to call our Payment APIs click <a href="https://dev.na.bambora.com/docs/guides/merchant_quickstart/calling_APIs/">here</a>.

## Credential-on-File Types

The following is a list of all possible Credential-on-File types that can be used when processing Credential-on-File transactions:

- first_installment
- subsequent_installment
- first_recurring
- subsequent_recurring
- subsequent_customer_initiated
- subsequent_unscheduled

### first_installment:

The `first_installment` Credential-on-File type is used for the first transaction being processed where the cardholder has authorized the merchant 
to store the cardholder's payment credentials for the purpose of charging the cardholder again over regular intervals, up to a specified end date.  
An example of this type is when the cardholder has purchased a fridge and is paying for it in installments.  This type will be the first payment in 
the set of installment payments, and it can be either a purchase or a pre-auth transaction.

Since this is the first transaction in a set of transactions, a series ID should not be specified. The transaction response will include the series ID that should be used for future related payments in the series.

#### Request 1

```curl
curl -X POST https://api.na.bambora.com/v1/payments
-H "Content-Type: application/json"
-H "Authorization: Passcode MTAwMDAwMDAwOmJhbWJvcmE="
-d '{
        "amount": 5.00,
        "payment_method": "card",
        "card": {
            "name": "Mr. Card On file",
            "number": "4520016000023001",
            "expiry_month": "12",
            "expiry_year": "22",
            "cvd": "123"
        },
        "card_on_file": {
            "type": "first_installment"
        }
    }'
```

#### Response 1

```
{
    "id": "10000589",
    "authorizing_merchant_id": 372930000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "832373",
    "created": "2018-09-06T15:57:20",
    "order_number": "10000589",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0,
    "amount": 5,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "3001",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "1",
        "avs": {
            "id": "0",
            "message": "Address Verification not performed for this transaction.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://api.na.bambora.com/v1/payments/10000589/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://api.na.bambora.com/v1/payments/10000589/returns",
            "method": "POST"
        }
    ],
    "card_on_file": {
        "type": "first_installment",
        "series_id": 2411
    }
}
```

### subsequent_installment:

The `subsequent_installment` Credential-on-File type is used for any of the subsequent transactions that are charged to a cardholder's stored payment 
credentials by the merchant that originally started from a `first_installment` transaction.  Similar to the `first_installment` type, the `subsequent_installment` 
type must be charged to the cardholder at regular intervals, up to a specified end date.  An example of this type is when the cardholder has purchased a fridge 
and is paying for it in installments.  This type will be the next payment in the set of installment payments, and it must be a purchase transaction only.

Since this is a subsequent transaction in a set of transactions, the series ID that was returned in the first payment of the series is required to be passed in the request message.

#### Request 2

```curl
curl -X POST https://api.na.bambora.com/v1/payments
-H "Content-Type: application/json"
-H "Authorization: Passcode MTAwMDAwMDAwOmJhbWJvcmE="
-d '{
        "amount": 5.00,
        "payment_method": "card",
        "card": {
            "name": "Mr. Card On file",
            "number": "4520016000023001",
            "expiry_month": "12",
            "expiry_year": "22"
        },
        "card_on_file": {
            "type": "subsequent_installment",
            "series_id": 2411
        }
    }'
```

#### Response 2

```
{
    "id": "10000590",
    "authorizing_merchant_id": 372930000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "832374",
    "created": "2018-09-06T15:57:20",
    "order_number": "10000590",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0,
    "amount": 5,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "3001",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "2",
        "avs": {
            "id": "0",
            "message": "Address Verification not performed for this transaction.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://api.na.bambora.com/v1/payments/10000589/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://api.na.bambora.com/v1/payments/10000589/returns",
            "method": "POST"
        }
    ],
    "card_on_file": {
        "type": "subsequent_installment",
        "series_id": 2411
    }
}
```

### first_recurring:

The `first_recurring` Credential-on-File type is used for the first transaction being processed where the cardholder has authorized the merchant to store 
the cardholder's payment credentials for the purpose of charging the cardholder again over regular intervals, with no specified end date.  An example of 
this type is when the cardholder is paying for a subscription service.  This type will be the first payment for the subscription service, and it can be 
either a purchase or a pre-auth transaction.  Additionally, any transaction that is processed for the purpose of verifying the cardholder's payment credentials 
before storing it for later use will have the `first_recurring` Credential-on-File type.

Since this is the first transaction in a set of transactions, a series ID should not be specified. The transaction response will include the series ID that should be used for future related payments in the series.

#### Request 3

```curl
curl -X POST https://api.na.bambora.com/v1/payments
-H "Content-Type: application/json"
-H "Authorization: Passcode MTAwMDAwMDAwOmJhbWJvcmE="
-d '{
        "amount": 5.00,
        "payment_method": "payment_profile",
        "payment_profile": {
            "customer_code": "SPPCustomerCode",
            "card_id": 1
            "complete": true
        },
        "card_on_file": {
            "type": "first_recurring"
        }
    }'
```

#### Response 3

```
{
    "id": "10000589",
    "authorizing_merchant_id": 372930000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "832373",
    "created": "2018-09-06T15:57:20",
    "order_number": "10000589",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0,
    "amount": 5,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "3001",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "2",
        "avs": {
            "id": "0",
            "message": "Address Verification not performed for this transaction.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://api.na.bambora.com/v1/payments/10000589/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://api.na.bambora.com/v1/payments/10000589/returns",
            "method": "POST"
        }
    ],
    "card_on_file": {
        "type": "first_recurring",
        "series_id": 2411
    }
}
```

### subsequent_recurring:

The `subsequent_recurring` Credential-on-File type is used for any of the subsequent transactions that are charged to a cardholder's stored 
payment credentials by the merchant that originally started from a `first_recurring` transaction.  Similar to the `first_recurring` type, 
the `subsequent_recurring` type must be charged to the cardholder at regular intervals with no specified end date.  An example of this type 
is when the cardholder is paying for a subscription service, and this is one of the subsequent payments for the subscription service.  
Any transaction that has the `subsequent_recurring` type must be a purchase only.

Since this is a subsequent transaction in a set of transactions, the series ID that was returned in the first payment of the series is required to be passed in the request message.

#### Request 4

```curl
curl -X POST https://api.na.bambora.com/v1/payments
-H "Content-Type: application/json"
-H "Authorization: Passcode MTAwMDAwMDAwOmJhbWJvcmE="
-d '{
        "amount": 5.00,
        "payment_method": "payment_profile",
        "payment_profile": {
            "customer_code": "SPPCustomerCode",
            "card_id": 1
            "complete": true
        },
        "card_on_file": {
            "type": "subsequent_recurring",
            "series_id": 2411
        }
    }'
```

#### Response 4

```
{
    "id": "10000590",
    "authorizing_merchant_id": 372930000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "832374",
    "created": "2018-09-06T15:57:20",
    "order_number": "10000590",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0,
    "amount": 5,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "3001",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "2",
        "avs": {
            "id": "0",
            "message": "Address Verification not performed for this transaction.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://api.na.bambora.com/v1/payments/10000589/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://api.na.bambora.com/v1/payments/10000589/returns",
            "method": "POST"
        }
    ],
    "card_on_file": {
        "type": "subsequent_recurring",
        "series_id": 2411
    }
}
```

### subsequent_customer_initiated:

The `subsequent_customer_initiated` Credential-on-File type is used for any transaction that is processed at the request of the cardholder, 
and uses that cardholder's stored payment credentials as the form of payment.  These transactions are not charged on any regular interval, 
and they can be either a purchase or a pre-auth transaction.  An example of this type is when the cardholder is reloading a prepaid cash card.

Even though these transactions are initiated by the cardholder, they are still subsequent transactions in a set of transactions.  Therefore, 
the series ID is required to be passed in the request message.

#### Request 5

```curl
curl -X POST https://api.na.bambora.com/v1/payments
-H "Content-Type: application/json"
-H "Authorization: Passcode MTAwMDAwMDAwOmJhbWJvcmE="
-d '{
        "amount": 5.00,
        "payment_method": "card",
        "card": {
            "name": "Mr. Card On file",
            "number": "4520016000023001",
            "expiry_month": "12",
            "expiry_year": "22",
            "cvd": "123"
        },
        "card_on_file": {
            "type": "subsequent_customer_initiated"
            "series_id": 2411
        }
    }'
```

#### Response 5

```
{
    "id": "10000589",
    "authorizing_merchant_id": 372930000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "832373",
    "created": "2018-09-06T15:57:20",
    "order_number": "10000589",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0,
    "amount": 5,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "3001",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "1",
        "avs": {
            "id": "0",
            "message": "Address Verification not performed for this transaction.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://api.na.bambora.com/v1/payments/10000589/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://api.na.bambora.com/v1/payments/10000589/returns",
            "method": "POST"
        }
    ],
    "card_on_file": {
        "type": "subsequent_customer_initiated",
        "series_id": 2411
    }
}
```

### subsequent_unscheduled:

The `subsequent_unscheduled` Credential-on-File type is used for any transaction that is triggered by the merchant, and charges a cardholder 
by using that cardholder's stored payment credentials.  These transactions are not charged on any regular interval, and they can only be a 
purchase transaction.  An example of this type is when the merchant auto-reloads a prepaid cash card for the cardholder when the balance on 
that card reaches a predetermined threshold.

Even though the transactions are not charged on a regular interval, the merchant is still charging the cardholder for the same product or service 
over time.  Therefore, these transactions are considered to belong to the same set of transactions, and so the series ID for the set is required to 
be passed in the request message.

#### Request 6

```curl
curl -X POST https://api.na.bambora.com/v1/payments
-H "Content-Type: application/json"
-H "Authorization: Passcode MTAwMDAwMDAwOmJhbWJvcmE="
-d '{
        "amount": 5.00,
        "payment_method": "card",
        "card": {
            "name": "Mr. Card On file",
            "number": "4520016000023001",
            "expiry_month": "12",
            "expiry_year": "22"
        },
        "card_on_file": {
            "type": "subsequent_unscheduled",
            "series_id": 2414
        }
    }'
```

#### Response 6

```
{
    "id": "10000590",
    "authorizing_merchant_id": 372930000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "832374",
    "created": "2018-09-06T15:57:20",
    "order_number": "10000590",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0,
    "amount": 5,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "3001",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "2",
        "avs": {
            "id": "0",
            "message": "Address Verification not performed for this transaction.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://api.na.bambora.com/v1/payments/10000589/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://api.na.bambora.com/v1/payments/10000589/returns",
            "method": "POST"
        }
    ],
    "card_on_file": {
        "type": "subsequent_unscheduled",
        "series_id": 2414
    }
}
```

## Processing Credential-on-File Transactions for Recurring/Installment Customers

For recurring/installment customers that already have transactions processed *without* Credential-on-File values, the first Credential-on-File transaction request should include the Credential-on-File `type` value *without* including a `series_id`. This transaction's response will include the Credential-on-File `series_id` value to be stored for later use, and would then need to be included with all future transactions within that set.

This is applicable to the following Credential-on-File `type`s:

- `subsequent_recurring`
- `subsequent_installment`
- `subsequent_unscheduled`


## Credential-on-File Defaults

In addition to the Bambora Payment APIs, any transactions resulting from either the Secure Payment Profile service, Recurring Billing service, 
or Batch Processing service are considered Credential-on-File transactions.  This is due to the fact that all of these services are processing 
transactions using stored cardholder payment credentials.  However, these services do not all offer an option for the merchant to pass in the 
Credential-on-File indicator.  In order to remain compliant with the Credential-on-File requirement, the Bambora platform will automatically 
assign a default Credential-on-File indicator based on the following rules:

- If the transaction is processed for the purpose of verifying a cardholder's payment credentials before storing it for later use, then the transaction 
  is assigned the `first_recurring` Credential-on-File type.
- If the transaction is flagged as recurring and there is no specified end date, then the transaction is assigned the `subsequent_recurring` Credential-on-File 
  type. If there is a specified end date (which is only possible from the Recurring Billing service), then the transaction is assigned the `subsequent_installment` Credential-on-File type.
- If the above rules do not apply, and the transaction is using a payment profile, or the transaction is from a batch, then the transaction is assigned the 
  `subsequent_customer_initiated` Credential-on-File type.
