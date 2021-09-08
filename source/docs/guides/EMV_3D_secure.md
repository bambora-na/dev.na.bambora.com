---
title: EMV 3D Secure
layout: tutorial

summary: >
    Visa Secure (formerly Verified by Visa), MasterCard SecureCode, and AMEX SafeKey are security features that prompt customers to enter a 
    passcode when they pay by Visa, MasterCard, or AMEX. Merchants that want to integrate Visa Secure, SecureCode, or SafeKey must 
    have signed up for the service through their bank merchant account issuer. This service must also be enabled by our 
    Customer Care team.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# EMV 3D Secure

If you are currently using our legacy 3D Secure functionality, the documentation is [here](/docs/guides/3D_secure/)

Note: EMV 3DS is currently only available for merchants who process payments through TD. 

EMV 3D Secure (3DS2), also known as Visa Secure (formerly Verified by Visa), MasterCard Identity Check (formerly SecureCode), and AMEX SafeKey, is a security standard used to authenticate card-not-present payments. This upgrade from 3DS 1 reduces friction for the cardholder. Merchants that want to integrate 3DS2 must have signed up for the service through their bank merchant account issuer. This service must also be enabled by our Customer Care team.

For assistance with integrations and any questions you may have about 3DS2, you may <a href="https://help.na.bambora.com/hc/en-us/requests/new" target="_blank">submit a request</a> to Customer Care or call 1-833-226-2672.

When your customer (the cardholder) starts a transaction on your website, either one of these two scenario flows can happen:

- Challenge flow: The cardholder will need to provide additional data to authenticate themselves.
- Frictionless flow: The cardholders will not need to authenticate themselves as the authentication took place in the background without their input. In this case, the issuer is confident with the information you provided with the transaction and the liability shifts to the issuer. 

As the decision is now in the hands of the issuer, they will ask you for more data. The more data you provide, the more accurate the issuer can make their decision about the risk of the transaction - ultimately lead to a frictionless scenario for your customers.

In addition to this guide, feel free to check out our [Payment APIs Demo implementation](https://github.com/bambora/na-payment-apis-demo) on GitHub.

# Benefits 

The expectation in the market is that a substantial percentage of transactions using 3DS2 will follow the frictionless flow. Compared to current non-3DS2 checkout flows, this doesn't require anything additional from the consumer. This means that you benefit from the increased security and liability shift that is provided by the 3DS2 programs, while the conversion in your checkout process shouldn't be negatively impacted.

# 3DS2, What's new?

Depending on your integration method, you may need to pass in new parameters related to the client browser. There are also optional parameters to indicate the 3DS version and if a transaction should continue to be processed if 3DS authentication fails.

- RESTful Payments API integrations require new parameters detailed below, and also accept new optional parameters. 
- Hosted checkout integrations have a new optional parameter but require no changes.

The payment response will now return a status code to indicate if 3DS authentication was successful. The naming of the parameters in the redirection will also be changing, but their contents and usage will be the same.

# Use our 3DS2 MPI

Use our RESTful Payment APIs to initiate the Payment and to complete the transaction request. In this standard 
integration, the 3DS2 process may complete in one request or may require two in some cases. 

## REST API - card number passed in 

Examples for integrations using our RESTful Payments API: these examples are only applicable to merchants who collect sensitive cardholder data and pass it in to our API.

### POST /payments

Payment request: 

Note: Browser data and customer IP should be passed through from the client's browser as is, with no changes.

```shell
{
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{
   "amount": 250.01,
   "payment_method": "card",
   "customer_ip": "123.123.123.123",
   "term_url":"{{term_url}}",
   "card": {
      "name": "Test User",
      "number": "4716519788977219",
      "expiry_month": "09",
      "expiry_year": "20",
      "3d_secure": {
         "browser": {
            "accept_header": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "java_enabled": "false",
            "language": "en-US",
            "color_depth": "24",
            "screen_height": 1080,
            "screen_width": 1920,
            "time_zone": -120,
            "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
            "javascript_enabled": true
         },
         "enabled": true,
         "version": 2,
         "authentication_required": false
      }
   }
}'
```

From here the payment will follow one of two flows. Depending on the response from the bank, the redirection to the challenge flow that was mandatory in 3DS 1 may be skipped in 3DS2. If that is the case, the payment response detailed below for the continue flow will be returned immediately.

However, if the challenge flow is required, the following response will be returned.

Payment response - redirect to challenge flow (HTTP status code 302 redirect):

```shell
{
 "3d_session_data": "YTk5OWM1OTEtZTI0OC00NzY2LTk2NjEtODlmNzNhYWRjYmZi",
 "contents": "%3CHTML%3E%3CHEAD%3E%3C%2FHEAD%3E%3CBODY%3E%3CFORM%20action%3D%22https%3A%2F%2Fapi.na.bambora.com%2FactiveMerchantEmulator%2Fgateway.asp%22%20method%3D%22POST%22%20id%3D%22form1%22%20name%3D%22form1%22%3E%3CINPUT%20type%3D%22hidden%22%20name%3D%22PaReq%22%20value%3D%22TEST_paRaq%22%3E%3Cinput%20type%3D%22hidden%22%20name%3D%22merchant_name%22%20value%3D%22Seven%20Sparrow%20Inc.%22%3E%3Cinput%20type%3D%22hidden%22%20name%3D%22trnDatetime%22%20value%3D%222%2F23%2F2017%205%3A05%3A42%20PM%22%3E%3Cinput%20type%3D%22hidden%22%20name%3D%22trnAmount%22%20value%3D%22100.00%22%3E%3Cinput%20type%3D%22hidden%22%20name%3D%22trnEncCardNumber%22%20value%3D%22XXXX%20XXXX%20XXXX%203312%22%3E%3CINPUT%20type%3D%22hidden%22%20name%3D%22MD%22%20value%3D%22YTk5OWM1OTEtZTI0OC00NzY2LTk2NjEtODlmNzNhYWRjYmZi%22%3E%3CINPUT%20type%3D%22hidden%22%20name%3D%22TermUrl%22%20value%3D%22http%3A%2F%2F10.240.9.64%3A5000%2Fpayment%2Fenhanced%2Fredirect%2F3d-secure%22%3E%3C%2FFORM%3E%3CSCRIPT%20language%3D%22JavaScript%22%3Edocument.form1.submit()%3B%3C%2FSCRIPT%3E%3C%2FBODY%3E%3C%2FHTML%3E",
 "links": [ 
 {
 "rel": "continue",
 "href":"https://api.na.bambora.com/v1/payments/YTk5OWM1OTEtZTI0OC00NzY2LTk2NjEtODlmNzNhYWRjYmZi/continue",
 "method":"POST"
 }
 ]
}
```

In the 302 response above, the 'merchant_data' attribute value should be saved in the current user's session.

The merchant's process URL decodes the response redirect and displays the information in the customer's web browser. 
This forwards the client to the issuer authentication portal. On the bank portal, the customer follows the authentication prompts such as entering a one time passcode received via an email or text message. 

The issuer forwards a response to the merchant's TERM URL including the following variables:

- cres (Authentication Code)
- 3d_session_data (Unique Payment ID)

Use the 3d_session_data and cres values in the continue request detailed below.

### POST /payments/{3d_session_data}/continue 

Continue request:

```shell
curl https://api.na.bambora.com/v1/payments/YTk5OWM1OTEtZTI0OC00NzY2LTk2NjEtODlmNzNhYWRjYmZi/continue \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{

   "payment_method": "credit_card", 
   "card_response": {
      "cres": "eyJhY3NUcmFuc0lEIjoiNUUwRDhFQ0UtNDU0RC00QzkwLTk2QzMtMTRERTZFNTYxNjBFIiwiY2hhbGxlbmdlV2luZG93U2l6ZSI6IjA1IiwibWVzc2FnZVR5cGUiOiJDUmVxIiwibWVzc2FnZVZlcnNpb24iOiIyLjIuMCIsInRocmVlRFNTZXJ2ZXJUcmFuc0lEIjoiNmQ0NTM0MDUtYWYzZC00ZTVlLWE4Y2UtM2I4NTYwMDJhNWI3In0"
   }
}'

```

Continue response:

```shell
{
   "id": "10000026",
   "approved": "1",
   "message_id": "1",
   "message": "Approved",
   "auth_code": "TEST",
   "created": "2017-02-23T17:26:26",
   "order_number": "MyOrderId000011223344",
   "type": "PA",
   "payment_method": "CC",
   "amount": 15.99,
   "custom": {
      "ref1": "",
      "ref2": "",
      "ref3": "",
      "ref4": "",
      "ref5": ""
   },
   "card": {
      "card_type": "VI",
      "last_four": "3312",
      "address_match": 0,
      "postal_result": 0,
      "cvd_result": 1,
      "cavv_result": 2
   },
   "3d_secure": {
      "status": "Success"
   }
   "links": [
   {
      "rel": "complete",
      "href": "https://api.na.bambora.com/v1/payments/10000026/completions",
      "method": "POST"
   }
 ]
}
```

## Other responses 

311 - 3DSecure Failed response

Payments request:

```curl --location --request POST 'https://uattest-api.na.bambora.com/v1/payments' \
--header 'Authorization: Passcode MzY5MTcwMDAwOmJhbWJvcmE=' \
--header 'Content-Type: application/json' \
--data-raw '{
   "amount": 250.01,
   "payment_method": "card",
   "customer_ip": "123.123.123.123",
   "term_url":"https://www.beanstream.com/debug.asp",
   "card": {
      "name": "Test User",
      "number": "4635691262664247",
      "expiry_month": "09",
      "expiry_year": "20",
      "3d_secure": {
         "browser": {
            "accept_header": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "java_enabled": "false",
            "language": "en-US",
            "color_depth": "24",
            "screen_height": 1080,
            "screen_width": 1920,
            "time_zone": -120,
            "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
            "javascript_enabled": true
         },
         "enabled": true,
         "version": 2,
         "authentication_required": false
      }
   }
}'
```

Payments response:

```shell

    "code": 311,
    "category": 1,
    "message": "3D Secure Failed",
    "reference": "",
    "3d_secure": {
        "status": "Rejected"
    }
}
```

## REST API - Single Use Token 

These examples are applicable to merchants who use Custom Checkout or who tokenize sensitive cardholder information before sending the request to our RESTful Payments API.

### POST /scripts/tokenization/tokens

Tokens request:

```shell
curl --location --request POST 'https://uattest-web.na.bambora.com/scripts/tokenization/tokens' \
--header 'Content-Type: application/json' \
--data-raw '{
  "number":"4716519788977219",
  "expiry_month":"06",
  "expiry_year":"19",
  "cvd":"123"
}'
```

Tokens Response:

```shell
{
    "token": "uattest01-4128746e-e957-4585-a7ad-ef5b09c8fefe",
    "code": 1,
    "version": 1,
    "message": ""
}
```

### POST /payments

Payments request:

```shell
curl --location --request POST 'https://uattest-api.na.bambora.com/v1/payments' \
--header 'Authorization: Passcode MzUwMTgwMDAwOmJhbWJvcmE=' \
--header 'Content-Type: application/json' \
--data-raw '{
   "amount": 250.01,
   "payment_method": "token",
   "customer_ip": "123.123.123.123",
   "term_url":"https://uattest-web.na.bambora.com/debug.asp",
   "token": {
      "code": "uattest01-732fc9fd-d58b-4ea6-8e47-e1a02339ea06",
      "name": "Test User",
      "complete": true,
      "3d_secure": {
         "browser": {
            "accept_header": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "java_enabled": "false",
            "language": "en-US",
            "color_depth": "24",
            "screen_height": 1080,
            "screen_width": 1920,
            "time_zone": -120,
            "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
            "javascript_enabled": true
         },
         "enabled": true,
         "version": 2,
         "authentication_required": false
      }
   }
}'
```

From here the request and response flow for a single use token transaction is exactly the same as the card number provided flow above. Either the transaction is authenticated immediately and the merchant receives the Continue response with the results of the transaction including the auth code and 3DS status, or a 302 response is provided to the merchant to redirect the user to the challenge flow.

## REST API - Secure Payment Profile

These examples are applicable to merchants who use Secure Payment Profiles.

### Payments 

Payments request:

```shell
curl --location --request POST 'https://uattest-api.na.bambora.com/v1/payments' \
--header 'Authorization: Passcode MzUwMTgwMDAwOmJhbWJvcmE=' \
--header 'Content-Type: application/json' \
--data-raw '{
   "amount": 250.01,
   "payment_method": "payment_profile",
   "customer_ip": "123.123.123.123",
   "term_url":"https://www.beanstream.com/debug.asp",
   "payment_profile": {
       "customer_code":"F02",
       "3d_secure": {
         "browser": {
            "accept_header": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "java_enabled": "false",
            "language": "en-US",
            "color_depth": "24",
            "screen_height": 1080,
            "screen_width": 1920,
            "time_zone": -120,
            "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
            "javascript_enabled": true
         },
         "enabled": true,
         "version": 2,
         "authentication_required": false
      }
   }
}'
```

From here the request and response flow for a secure payment profile transaction is exactly the same as the card number provided flow above. Either the transaction is authenticated immediately and the merchant receives the Continue response with the results of the transaction including the auth code and 3DS status, or a 302 response is provided to the merchant to redirect the user to the challenge flow.

Payments response:

```shell
{
    "id": "10000122",
    "authorizing_merchant_id": 369170000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "TEST",
    "created": "2021-08-20T16:34:41",
    "order_number": "10000122",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0.0,
    "amount": 250.01,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "7977",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "2",
        "avs": {
            "id": "U",
            "message": "Address information is unavailable.",
            "processed": false
        }
    },
    "3d_secure": {
        "status": "Succeeded"
    },
    "links": [
        {
            "rel": "void",
            "href": "https://uattest-api.na.bambora.com/v1/payments/10000122/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://uattest-api.na.bambora.com/v1/payments/10000122/returns",
            "method": "POST"
        }
    ]
}
```

## Use your own process

Some large merchants complete the Visa Secure, MasterCard SecureCode, or AMEX SafeKey certification to handle 
authentication on their own side. These merchants can use their existing Visa Secure, SecureCode, or SafeKey authentication 
process, and send the results of the bank authentication to us with their standard transaction request. To do 
this, the merchant must integrate using a server-to-server type connection.

Note: This option must be enabled by us. Contact Customer Care if you want to use this method.

The Visa Secure, SecureCode, or SafeKey bank authentication results must be sent with the transaction request using these five 
system variables:

| Attribute | Description |
| --- | --- |
| xid | Include the 3D Secure transaction identifier (up to 20-digits). |
| eci | SecureECI is a 1-digit status code. For Visa/Amex: 5 - authenticated; 6 - attempted, not completed; 7 - authentication unsuccessful or not completed. For Mastercard: 1 - unsuccessful; 2 - authenticated; 0 - authentication unsuccessful or not completed |
| cavv | Include the 40-character Cardholder Authentication Verification Value. |
| ds_transaction_id| Directory Server transaction ID (36 characters) |
| version | Which version of 3DS to process with. 1 or 2 |

### POST /payments

Payments request

```shell
curl --location --request POST 'https://uattest-api.na.bambora.com/v1/payments' \
--header 'Authorization: Passcode Mzg5MzUwMDAwOmJhbWJvcmE=' \
--header 'Content-Type: application/json' \
--data-raw '{
   "amount": 22.13,
   "payment_method": "card",
   "customer_ip": "123.123.123.123",
   "card": {
      "name": "Test User",
      "number": "4567350000427977",
      "expiry_month": "09",
      "expiry_year": "20",
      "complete": true,
      "3d_secure_passthrough": {
         "version": 2,
         "xid":"10000045",
         "eci": 5,
         "cavv": "AAABBEg0VhI0VniQEjRWAAAAAAA=",
         "ds_transaction_id": "63AEEFE8-BE1F-41FA-AD52-4B5E2E16671D"
      }
   }
}
'
```

Payments response:

```shell
{
    "id": "10000088",
    "authorizing_merchant_id": 389350000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "TEST",
    "created": "2021-08-20T17:24:47",
    "order_number": "10000088",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0.0,
    "amount": 22.13,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "7977",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "2",
        "eci": 7,
        "avs": {
            "id": "U",
            "message": "Address information is unavailable.",
            "processed": false
        }
    },
    "links": [
        {
            "rel": "void",
            "href": "https://uattest-api.na.bambora.com/v1/payments/10000088/void",
            "method": "POST"
        },
        {
            "rel": "return",
            "href": "https://uattest-api.na.bambora.com/v1/payments/10000088/returns",
            "method": "POST"
        }
    ]
}
```

## Checkout

3DS2 can also be used with our Checkout form. The 3DS Version used will be controlled by the Member Area 'Default 3DS Version' setting, and there is a new optional parameter '3DsecureAuthRequired' which defaults to false. If 3DsecureAuthRequired is set to true the transaction will not continue processing unless 3DS authentication is successful.

Checkout will also return the '3DSecureStatus' in the approve/decline redirect.

Sample Link:

```shell
https://web.na.bambora.com/scripts/payment/payment.asp?
merchant_id=300203940
&trnAmount=10.00
&ordName=Jane+Smith
&ordPostalCode=V8T+4M3
&ordProvince=BC
&ordCountry=CA
&hashValue=ec6dccdc5ec2fc9314fdce5ea079abfa5db0d748
&3DsecureAuthRequired=true
```

Sample response redirect:

```shell
https://example.com/checkout/response?
trnApproved=1
&trnId=10000285
&messageId=1
&messageText=Approved
&authCode=TEST
&responseType=T
&trnAmount=10.00
&trnDate=8%2F13%2F2017+12%3A26%3A24+AM
&trnOrderNumber=10000285
&trnLanguage=eng
&trnCustomerName=
&trnEmailAddress=
&trnPhoneNumber=
&avsProcessed=0
&avsId=U
&avsResult=0
&avsAddrMatch=0
&avsPostalMatch=0
&avsMessage=Address+information+is+unavailable%2E
&cvdId=5
&cardType=VI
&trnType=P
&paymentMethod=CC
&ref1=
&ref2=
&ref3=
&ref4=
&ref5=
&eci=7
&3DSecureStatus=Success
```

## Detailed list of changes from 3DS 1

- Payment API request
    - Browser data - from client's browser, passed through unchanged
        - accept_header, string (1-2048), required
        - java_enabled, Boolean true/false, required
        - language, string (1-8), required
        - color_depth, numeric, required, must be one of the following values { 4, 8, 15, 16, 24, 32, 48 }
        - screen_height, numeric (0 to 9999999), required
        - screen_width, numeric (0 to 9999999), required
        - time_zone, numeric (-840 to 720), required
        - user_agent, string (1-2048), required
        - javascript_enabled, optional Boolean true/false, default true.
    - Additional 3DSecure parameters
        - version, Optional and will default to what is configured in the merchant's account
        - authentication_required (If set to true the transaction will not continue processing unless 3DS authentication is successful)

- Payment API response:
    - The payment response will return a status field under the 3d_secure field. Possible values are:
        - Success
        - Attempted
        - Rejected
        - Failed
        - Unavailable
        - Error
    - Challenge Redirection: In the case of a challenge flow the parameter names returned in the response will be changing:
        - 'md' will instead be named '3d_session_data'
        - 'pa_res' will instead be named 'cres'
- Payment API Auth Request: In the call to the Payment API Auth Request Continue method we will need:
    - Place the value of '3d_session_data' in the URI rather than the value of 'md'
    - Pass a value of 'cres' in the body rather than parameter 'pa_res'.

## Status details 

| Status | Description | Recommended Merchant Action | Liability Shift | Authentication Required: False | Authentication Required: True | Visa/Amex ECI Code | MasterCard ECI Code |
|--------|---------|-----|-----|-----|-----|-----|-----|
| Success | Authentication was successful. | Continue with transaction processing. | Yes | Transaction processes | Transaction processes | 5 | 2 |
| Attempted | Authentication was attempted but could not be completed. | Continue with transaction processing | Yes | Transaction processes | Transaction processes | 6 | 1 |
| Rejected | Rejected by issuing bank. | Do not proceed with the transaction. Notify the card holder to contact their card issuer. | No | Transaction declined message 311 | Transaction declined message 311 | 7 | 7 |
| Failed | Failed to authenticate card holder. | Do not proceed with the transaction. Notify the card holder to contact their card issuer. | No | Transaction declined message 311 | Transaction declined message 311 | 7 | 7 |
| Unavailable | The 3DS service is unavailable due to technical issues. | If you continue with the transaction there will be no lability shift and there will be risk of chargeback. The transaction and 3DS authentication can be retried at a later time. | No | Transaction processes | Transaction declined message 311 | 7 | 7 |
| Error | Authentication failed due to an internal error. | If you continue with the transaction there will be no lability shift and there will be risk of chargeback. An unexpected internal error occurred processing the 3DSecure authentication. If the problem persists contact Customer Care. | No | Transaction processes | Transaction declined message 311 | 7 | 7 |

_Please note that the liability shift only applies for chargebacks based on a fraud reason code. Any reason codes related to other types disputes are not covered by the liability shift._

_In rare cases the issuer can downgrade an authenticated transaction after processing the payment so that the liability shifts back to the merchant. For that scenario, the Payment API returns 0 for the cavv\_result field._

## Test Cards

| Card Type | Card Number | 3DS Status | Flow Type | 
|--------|---------|-----|-----|
|Visa|4330264936344675|Success|Frictionless|
|Visa|4012000033330026|Success|Frictionless|
|Visa|4532153596910568|Success|Frictionless|
|Visa|4921810000005462|Success|Frictionless|
|MasterCard|5137009801943438|Success|Frictionless|
|MasterCard|5140512592070076|Success|Frictionless|
|MasterCard|5200000091444270|Success|Frictionless|
|MasterCard|5576938868353339|Success|Frictionless|
|Amex|375418081197346|Success|Frictionless|
|Amex|371449635398431|Success|Frictionless|
|Visa|4450213273993630|Attempted|Frictionless|
|Visa|4012004040524514|Attempted|Frictionless|
|Visa|4532155854421931|Attempted|Frictionless|
|Visa|4921814859264089|Attempted|Frictionless|
|MasterCard|5156400512420624|Attempted|Frictionless|
|MasterCard|5156400512420624|Attempted|Frictionless|
|MasterCard|5200008932030109|Attempted|Frictionless|
|MasterCard|5576939757108172|Attempted|Frictionless|
|Amex|376691390182618|Attempted|Frictionless|
|Amex|344822942822422|Attempted|Frictionless|
|Visa|4469362473905800|Failed|Frictionless|
|Visa|4012000305337014|Failed|Frictionless|
|Visa|4532151725292767|Failed|Frictionless|
|Visa|4921813693255758|Failed|Frictionless|
|MasterCard|5114974939548499|Failed|Frictionless|
|MasterCard|5102178582044293|Failed|Frictionless|
|MasterCard|5200001683397918|Failed|Frictionless|
|MasterCard|5576931977544583|Failed|Frictionless|
|Amex|375439384971666|Failed|Frictionless|
|Amex|343477454564812|Failed|Frictionless|
|Visa|4337328333414325|Rejected|Frictionless|
|Visa|4012003360932265|Rejected|Frictionless|
|Visa|4532157741142902|Rejected|Frictionless|
|Visa|4921818019072597|Rejected|Frictionless|
|MasterCard|5168645305790452|Rejected|Frictionless|
|MasterCard|5169312548681472|Rejected|Frictionless|
|MasterCard|5200008849448782|Rejected|Frictionless|
|MasterCard|5576935774384762|Rejected|Frictionless|
|Amex|375392300827514|Rejected|Frictionless|
|Amex|371402182236181|Rejected|Frictionless|
|Visa|4259701590936889|Unavailable|Frictionless|
|Visa|4475853611842840|Unavailable|Frictionless|
|MasterCard|5123301306181325|Unavailable|Frictionless|
|MasterCard|5141720392778702|Unavailable|Frictionless|
|Amex|371608168632280|Unavailable|Frictionless|
|Visa|4874970686672022|Success|Challenge|
|Visa|4796585406258483|Success|Challenge|
|Visa|4012007153923001|Success|Challenge|
|Visa|4532153065352672|Success|Challenge|
|MasterCard|5130257474533310|Success|Challenge|
|MasterCard|5140266613691523|Success|Challenge|
|MasterCard|5200003143732874|Success|Challenge|
|MasterCard|5576935936143114|Success|Challenge|
|Amex|379764422997381|Success|Challenge|
|Amex|378069803818698|Success|Challenge|
|Visa|4839645466321180|Attempted|Challenge|
|MasterCard|5168693992589936|Attempted|Challenge|
|MasterCard|5132782452891321|Attempted|Challenge|
|MasterCard|5396478404248162|Attempted|Challenge|
|Amex|379943305931143|Attempted|Challenge|
|Visa|4450022237973103|Rejected|Challenge|
|MasterCard|5165683216616048|Rejected|Challenge|
|Amex|376632086941180|Rejected|Challenge|
|MasterCard|5148904639667695|Unavailable|Challenge|
|MasterCard|5137739025252071|Unavailable|Challenge|
