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

# 3D Secure 2.0

Verified by Visa (VbV), MasterCard SecureCode, and AMEX SafeKey are security features that prompt customers to enter a 
passcode when they pay by Visa, MasterCard, or AMEX. Merchants that want to integrate VbV, SecureCode, or SafeKey must 
have signed up for the service through their bank merchant account issuer. This service must also be enabled by our 
support team.

For assistance, you can send a message to Client Services or call 1-888-472-0811.

With a VbV, SecureCode, or SafeKey transaction, a customer is redirected to a bank portal to enter their secure pin 
number before a transaction is processed. The bank then returns an authentication response which must be forwarded to 
our API for a transaction to complete.

In addition to this guide feel free to check out our [Payment APIs Demo implementation](https://github.com/bambora/na-payment-apis-demo) on GitHub.

# 3D Secure 2.0, Whats new?

In the request to the Payment API the merchant will be required to pass a number of new parameters related to the client browser
along with new optional parameters to indicate the 3DS version and if a transaction should continue to be completed if 3DS authentication fails.

The payment response will now return a status code in addition to the eci code to indicate if 3DS authentication was successful. The naming of the parameters in the redirection will also be changing, but their contents and usage will be the same.

## API Calls

### POST /payments

Payment request: 

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
            "Javascript_enabled": true
         },
         "enabled": true,
         "version": 2,
         "auth_required": false
      }
   }
}'
```

From here the payment will follow one of two flows. Depending on the response from the bank, the redirection to the challenge flow that was mandatory in 3DS 1 may be skipped in 3DS 2. If that is the case, the payment response detailed below for the continue flow will be returned immediately.

However, if the challenge flow is required, the following response will be returned.

Payment response - redirect to challenge flow (HTTP status code 302 redirect):

```shell
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

In the 302 response above, the 'merchant_data' attribute value should be saved in the current user's session.

The merchant's process URL decodes the response redirect and displays the information in the customer's web browser. 
This forwards the client to the VbV or SC, or SafeKey banking portal. On the bank portal, the customer enters their 
secure credit card pin number in the fields provided on the standard banking interface.

The bank forwards a response to the merchant's TERM URL including the following variables:

- cres (Authentication Code)
- threeDSSessionData (Unique Payment ID)

Use the threeDSSessionData and cres values in the continue request detailed below.

### POST /payments/{threeDSSessionData}/continue 

Continue request:

```shell
curl https://api.na.bambora.com/v1/payments/2ccd7715-9e97-4f11-9fff36e6584e3200/continue \
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
      "eci": 5,
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

##Detailed list of changes from 3DS 1

- Payment API request
    - Browser data
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
        - auth_required (If set to true the transaction will not continue processing unless 3DS authentication is successful)

- Payment API response:
    - In addition to the eci code the payment response will also return a status field under the 3d_secure field.
        - status, string. Possible values are:
            - Success
            - Attempted
            - Rejected
            - Failed
            - Unavailable
            - Error
    - Challenge Redirection: In the case of a challenge flow the parameter names returned in the response will be changing:
        - 'md' will instead be named 'threeDSSessionData'
        - 'pa_res' will instead be named 'cres'
- Payment API Auth Request: In the call to the Payment API Auth Request Continue method we will need:
    - Place the value of 'threeDSSessionData' in the URI rather than the value of 'md'
    - Pass a value of 'cres' in the body rather than parameter 'pa_res'.

### Status details 

| Status | Description | Recommended Merchant Action | Liability Shift | Authenticatiom Required: False | Authentication Required: True |
|--------|---------|-----|-----|-----|-----|
| Success | Authentication was successful. | Continue with transaction processing. | Yes | Transaction processes | Transaction processes |
| Attempted | Authentication was attempted but could not be completed. | Continue with transaction processing | Yes | Transaction processes | Transaction processes |
| Rejected | Rejected by issuing bank. | Do not proceed with the transaction. Notify the card holder to contact their card issuer. | No | Transaction declined message 311 | Transaction declined message 311 |
| Failed | Failed to authenticate card holder. | Do not proceed with the transaction. Notify the card holder to contact their card issuer. | No | Transaction declined message 311 | Transaction declined message 311 |
| Unavailable | The 3DS service is unavailable due to technical issues. | If you continue with the transaction there will be no lability shift and there will be risk of chargeback. The transaction and 3DS authentication can be retried at a later time. | No | Transaction processes | Transaction declined message 311 |
| Error | Authentication failed due to an internal error. | If you continue with the transaction there will be no lability shift and there will be risk of chargeback. An unexpected internal error occurred processing the 3DSecure authentication. If the problem persists contact support. | No | Transaction processes | Transaction declined message 311 |