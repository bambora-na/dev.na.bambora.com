---
title: 3D Secure
layout: tutorial

summary: >
    Verified by Visa (VbV), MasterCard SecureCode, and AMEX SafeKey are security features that prompt customers to enter a 
    passcode when they pay by Visa, MasterCard, or AMEX. Merchants that want to integrate VbV, SecureCode, or SafeKey must 
    have signed up for the service through their bank merchant account issuer. This service must also be enabled by our 
    support team.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# 3D Secure

Verified by Visa (VbV), MasterCard SecureCode, and AMEX SafeKey are security features that prompt customers to enter a 
passcode when they pay by Visa, MasterCard, or AMEX. Merchants that want to integrate VbV, SecureCode, or SafeKey must 
have signed up for the service through their bank merchant account issuer. This service must also be enabled by our 
support team.

For assistance, you can send a message to Client Services or call 1-888-472-0811.

With a VbV, SecureCode, or SafeKey transaction, a customer is redirected to a bank portal to enter their secure pin 
number before a transaction is processed. The bank then returns an authentication response which must be forwarded to 
our API for a transaction to complete.

In addition to this guide feel free to check out our [Payment APIs Demo implementation](https://github.com/bambora/na-payment-apis-demo) on GitHub.

<!-- Use one of these two options to implement 3D Secure: -->

## 1. Use our 2-Step process

Use our RESTful Payment APIs to initiate the Payment and to complete the transaction request. In this standard 
integration, the VbV, SecureCode, and SafeKey process requires two transaction requests.

**Step 1:** Submit a payment request and process the first result.

The merchant's processing script forwards the transaction details to our REST API. The request includes a special 
'term_url' variable. This term_url variable allows the merchant to specify the URL where the bank VbV or SC, or SafeKey 
response is returned, after the customer enters their PIN and it is verified on the bank portal.

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{

   "amount": 250.01,
   "payment_method":"token",
   "customer_ip": "123.123.123.123"
   "token": {
      "name": "Test User",
      "code":"gt7-0f2f20dd-777e-487e-b688-940b526172cd",
      "3d_secure": {
         "browser": {
            "acceptHeader": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "javaEnabled": "false",
            "language": "en-US",
            "colorDepth": "24",
            "screenHeight": 1080,
            "screenWidth": 1920,
            "timeZone": -120,
            "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
            "javascriptEnabled": true,
         },
         "enabled": true,
         "version": 2,
         "authRequired": false
      }
   }
}'

Response (HTTP status code 302 redirect)

{
 "merchant_data": "2ccd7715-9e97-4f11-9fff36e6584e3200",
 "contents": "%3cHTML%3e%3cHEAD%3e%3c%2fHEAD%3e%3cBODY%3e%3cFORM+action%3d%22https%3a%2f%2fapi.na.bambora.com%2factiveMerchantEmulator%2fgateway.asp%22+method%3d%22POST%22+id%3d%22form1%22+name%3d%22form1%22%3e%3cINPUT+type%3d%22hidden%22+name%3d%22PaReq%22+value%3d%22TEST_paRaq%22%3e%3cinput+type%3d%22hidden%22+name%3d%22merchant_name%22+value%3d%22Seven+Sparrow+Inc.%22%3e%3cinput+type%3d%22hidden%22+name%3d%22trnDatetime%22+value%3d%222%2f23%2f2017+5%3a05%3a42+PM%22%3e%3cinput+type%3d%22hidden%22+name%3d%22trnAmount%22+value%3d%22100.00%22%3e%3cinput+type%3d%22hidden%22+name%3d%22trnEncCardNumber%22+value%3d%22XXXX+XXXX+XXXX+3312%22%3e%3cINPUT+type%3d%22hidden%22+name%3d%22MD%22+value%3d%222CCD7715-9E97-4F11-9FFF36E6584E3200%22%3e%3cINPUT+type%3d%22hidden%22+name%3d%22TermUrl%22+value%3d%22http%3a%2f%2f10.240.9.64%3a5000%2fpayment%2fenhanced%2fredirect%2f3d-secure%22%3e%3c%2fFORM%3e%3cSCRIPT+language%3d%22JavaScript%22%3edocument.form1.submit()%3b%3c%2fSCRIPT%3e%3c%2fBODY%3e%3c%2fHTML%3e",
 "links": [ 
 {
 "rel": "continue",
 "href":"https://api.na.bambora.com/v1/payments/2ccd7715-9e97-4f11-9fff36e6584e3200/continue","method":"POST"
 }
 ]
}
```

In the 302 response above, the 'merchant_data' attribute value should be saved in the current users session.

The merchantâ€™s process URL decodes the response redirect and displays the information in the customerâ€™s web browser. 
This forwards the client to the VbV or SC, or SafeKey banking portal. On the bank portal, the customer enters their 
secure credit card pin number in the fields provided on the standard banking interface.

The bank forwards a response to the merchantâ€™s TERM URL including the following variables:
- PaRes (Authentication Code)
- MD (Unique Payment ID)

**Step 2:**  Process Transaction Auth Request

The merchant takes the data posted to the TERM URL and posts the PaRes and MD (merchant_data) values to our RESTful Payments API on its 'continue' endpoint.

If the transaction fails VbV or SC, or SafeKey it is declined immediately with messageId=311 (3D Secure Failed). If the 
transaction passes, it is forwarded to the banks for processing. On completion, an approved or declined message is sent 
to the merchant processing script.

Upon success the term_url callback is called with following form encoded name/value params:

- ('trnAmount', '15.99')
- ('merchant_name', 'Your Merchant Inc.') 
- ('password', '')
- ('opResponse', '') 
- ('MD', 'C82A76AB-238D-48D8-BEEDCAAB19566C00') 
- ('trnDatetime', '2/23/2017 5:52:23 PM')
- ('PaRes', 'TEST_PaRes')
- ('termUrl', 'http://10.240.9.64:5000/payment/enhanced/redirect/3d-secure') 
- ('trnEncCardNumber', 'XXXX XXXX XXXX 3312')
- ('PAC', 'TEST_PAC')
- ('retryAttempt', '0')

```shell
Request

curl https://api.na.bambora.com/v1/payments/2ccd7715-9e97-4f11-9fff36e6584e3200/continue \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{

   "payment_method": "credit_card", 
   "card_response": {
      "cres": "eyJhY3NUcmFuc0lEIjoiNUUwRDhFQ0UtNDU0RC00QzkwLTk2QzMtMTRERTZFNTYxNjBFIiwiY2hhbGxlbmdlV2luZG93U2l6ZSI6IjA1IiwibWVzc2FnZVR5cGUiOiJDUmVxIiwibWVzc2FnZVZlcnNpb24iOiIyLjIuMCIsInRocmVlRFNTZXJ2ZXJUcmFuc0lEIjoiNmQ0NTM0MDUtYWYzZC00ZTVlLWE4Y2UtM2I4NTYwMDJhNWI3In0"
   }
}'

Response

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
      "eci": 5,
      "cavv_result": 2
   },
   "3d_secure": {
      "status_id": 1
      "status": "Authenticated",
      "error_code": "",
      "error": ""
   }
   "links": [
   {
      "rel": "complete",
      "href": "https://api.na.bambora.com/v1/payments/10000026/completions",
      "method": "POST"
   }
 ]
}```

## 2. Use your own process

Some large merchants complete the Verified by Visa (VbV), MasterCard SecureCode, or AMEX SafeKey certification to handle 
authentication on their own side. These merchants can use their existing VbV, SecureCode, or SafeKey authentication 
process, and send the results of the bank authentication to us with their standard transaction request. To do 
this, the merchant must integrate using a server-to-server type connection.

Note: This option must be enabled by us. Contact support if you want to use this method.

The VbV, SecureCode, or SafeKey bank authentication results must be sent with the transaction request using these three 
system variables:

| Attribute | Description |
| --- | --- |
| xid | Include the 3D Secure transaction identifier (up to 20-digits). |
| eci | SecureECI is a 1-digit status code: 5 â€“ authenticated; 6 â€“ attempted, not completed. |
| cavv | Include the 40-character Cardholder Authentication Verification Value. |

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{
    "payment_method":"token",
    "order_number":"MyOrderId000011223344",
    "amount":15.99,
    "token":{
        "code":"gt7-0f2f20dd-777e-487e-b688-940b526172cd",
        "name":"John Doe",
		"3d_secure":{
			"enabled":true,
			"xid":"1368023",
			"cavv":"AAABAXlHEQAAAAGXAEcRAAAAAAA=",
			"eci":5
		}
    },
    "term_url": "https://my.merchantserver.com/redirect/3d-secure"
}'

Response

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
    "eci": 5,
    "cavv_result": 2
  },
  "links": [
    {
      "rel": "complete",
      "href": "https://api.na.bambora.com/v1/payments/10000026/completions",
      "method": "POST"
    }
  ]
}
```

# 3D Secure 2.0, Whats new?

In the request to the Payment API the merchant will be required to pass a number of new parameters related to the client browser
along with new optional parameters to indicate the 3DS version and if a transaction should continue to be completed if 3DS authentication fails.

The payment response will no longer be retuning an eci code to indicate if 3DS authentication was successful where will instead return a status code
and in the case of an failure, an error code.  The naming of the parameters in the redirection will also be changing, but their contents and usage will be the same.

##Detailed list of changes

    - Payment API request
       - Browser data
           - acceptHeader, string (1-2048), required
           - javaEnabled, Boolean true/false, required
           - language, string (1-8), required
           - colorDepth, 
           - screenHeight, numeric (0 to 9999999), required
           - screenWidth, numeric (0 to 9999999), required
           - timeZone, numeric (-840 to 720), required
           - userAgent, string (1-2048), required
           - javascriptEnabled, optional Boolean true/false, default true.
      - Additional 3DSecure parameters
           - version, Optional and will default to what is configured in the merchants account
           - authRequired (If set to true the transaction will not continue processing unless 3DS authentication is successful)

   - Payment API response:
      - The response will no longer return an ‘eci code’ to indicate if 3DS was successful or failed.  Instead the following parameters will be returned
           - status_id, set to one of the following values, set to a value of 1-4.
           - status, set to the text description associated to the status_id
                1 = Authenticated
                2 = Attempted
                3 = Non participating
                4 = Failed
           - error_id, this will be returned if the 3DS status is 'Failed', set to a value of 1-3
           - error
                1 = 3dSecure service not enabled
                2 = Service temporarily unavailable
                3 = Internal error
      - Challenge Redirection:
        In the case of a challenge flow the parameter names returned in the response will be changing:
           - ‘md’ will instead be named ‘threeDSSessionData’
           - ‘pa_res’ will instead be named ‘cres’
    - Payment API Auth Request
      In the call to the Payment API Auth Request Continue method we will need:
           - Place the value of ‘threeDSSessionData’ in the URI rather than the value of ‘md’
           - Pass a value of ‘cres’ in the body rather than parameter ‘pa_res’.
