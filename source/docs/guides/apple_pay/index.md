---
title: Apple Pay
layout: tutorial

summary: >
    Our Payments API now exposes a new 'apple_pay' payment method and associated parameters to accept a base 64 encoded Apple Pay Payment Token.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Apple Pay

## About Apple Pay

Our Payments API allows your mobile app and online store to accept payments using Apple Watch, iPhone, iPad, or Safari.

## Getting Started

If this is your first time implementing our APIs we recommend reviewing our [Reference guide](/docs/references/payment_APIs/), to get familiar with Bambora's Payment APIs.

You can find more about Bambora and Apple Pay on [Github](https://github.com/bambora/na-payment-apis-demo).

## Requirements

### Registering Your Apple Pay Merchant ID

Before you accept Apple Pay with Bambora, you need to [register a Merchant ID and download a Merchant Certificate (P12)](https://developer.apple.com/library/content/ApplePay_Guide/Configuration.html) with Apple.

### Configure Your P12

To enable Apple Pay on your Merchant Account, you'll set a password for your P12 using Keychain Access.

1. Under the Category menu, select **Certificates**.
2. Find and right-click your *Merchant ID* certificate. Select **Export**.
3. Ensure your File Format is set to **.Personal Information Exchange (.p12)** before clicking **Save**.
4. Enter the password you'll use when uploading your .p12 to the Member Area and click **OK**.

>VERY IMPORTANT NOTE: You must upload the ***"ApplePay Payment Processing Certificate".***
For further information visit: [Configure Merchant ID and Certificates](https://developer.apple.com/documentation/apple_pay_on_the_web/configuring_your_environment)

>If you use a different certificate instead of ***"ApplePay Payment Processing Certificate"***, you may get the error: 
```"Wrong certificate type. Apple Pay Merchant Identity certificates are for Web site usage only. Use an Apple Pay Payment Processing certificate type."```** 

### Enable Apple Pay

To turn on Apple Pay for your account, log into the [Member Area](https://web.na.bambora.com). Under **configuration**, click on **mobile payments**. From the Mobile Payments screen, you can enable Apple Pay by adding your Apple Pay signing certificate.

<img src="/docs/guides/apple_pay/mobile-payments-screenshot.png" alt="mobile-payments-screenshot">

Click **ADD NEW MERCHANT ID**, and you'll be able to add your *Apple Merchant ID*, your *P12 File Password*, and upload your P12 certificate file. 

<img src="/docs/guides/apple_pay/apple-credentials.png" alt="apple-credentials">

After you've added your Apple Pay certificate to your account, you can start integrating to your app.

## Accepting Apple Pay on iOS

All of the directions and code samples to enable Apple Pay in your iOS app are available through Apple's documentation. 

[Getting Started with Apple Pay](https://developer.apple.com/apple-pay/get-started/) will cover how to use Apple Pay and best practices, [Apple Pay Guide](https://developer.apple.com/library/content/ApplePay_Guide/) has explanations of the user flow and working with Apple Pay, and [Apple Pay Sandbox Testing](https://developer.apple.com/support/apple-pay-sandbox/) will show you how to test Apple Pay transactions.

## API Requests

When you make an `apple_pay` request to our Payments API, it'll be formatted in JSON, calling to https://api.na.bambora.com/v1/payments/.

```shell
  curl https://api.na.bambora.com/v1/payments \
    -H "Authorization: Passcode XXX1XXx11Xxx1xX1XxxxXxXXXXx1XXX1XxX1XXXxXXXxXxxxX11XXXxX1" \
    -H "Content-Type: application/json" \
    -d '{
          "amount": 1.00,
          "payment_method": "apple_pay",
          "apple_pay": {
            "passthrough": false,
            "apple_pay_merchant_id": "<your_apple_pay_merchant_id>",
            "payment_token": "<apple_pay_base64_encoded_token>",
            "complete": true
          }
        }'
```

| Variable | Description |
| -------- | ----------- |
| amount | The amount of the transaction. |
| payment_method | The method of payment for the transaction. For Apple Pay, this will always be `apple_pay` |
| apple_pay | The object needed to pass an Apple Pay token including the Apple Pay Merchant ID, and the base64 payment token. |
| passthrough | Indicates whether the transaction uses Apple Pay passthrough. True indicates a passthrough (externally decrypted) transaction, false or null indicates a regular (Worldline decrypted) Apple Pay transaction. |
| apple_pay_merchant_id | Your Apple Merchant ID provided in your Apple Developer Account. Not required if passthrough is set to true. |
| payment_token | The Apple Pay token containing card holder details, generated from within the iOS app. For regular (Worldline decrypted) transaction requests - Apple Pay base64-encoded, encrypted payment token. For passthrough (externally decrypted) transaction requests - Apple Pay base64-encoded, decrypted payment token. |
| complete | The type of transaction being performed. True indicates a Purchase, and false is a Pre-Authorisation. |

## Apple Pay External Decryption*

With Apple Pay External Decryption (passthrough), the decryption is performed by the merchant prior to making the request.

### Making a request

The major differences between a passthrough transaction request and a regular Apple Pay transaction request are that the "passthrough" field must be included and set to true, the "apple_pay_merchant_id" field can be omitted, and the payment token must be decrypted before being base64-encoded and passed. Other than that, a passthrough request will function the same as a regular Apple Pay request, formatting the data in JSON and calling https://api.na.bambora.com/v1/payments/.

```shell
  curl https://api.na.bambora.com/v1/payments \
    -H "Authorization: Passcode XXX1XXx11Xxx1xX1XxxxXxXXXXx1XXX1XxX1XXXxXXXxXxxxX11XXXxX1" \
    -H "Content-Type: application/json" \
    -d '{
          "amount": 1.00,
          "payment_method": "apple_pay",
          "apple_pay": {
            "passthrough": true,
            "payment_token": "<base64_encoded_decrypted_apple_pay_token>",
            "complete": true
          }
        }'
```

For merchants not using external decryption, the passthrough parameter is optional, and omitting it will have the same effect as passing it as false. No changes are required for existing integrations using Worldline decryption for Apple Pay.

*TD Support Only

## Additional Examples

### Payment Button

The sample below shows the action taken by a payment button using Swift, generating a payment request.

```swift
func paymentButtonAction() {
    // Create a payment request
    let request = PKPaymentRequest()
    
    request.merchantIdentifier = "merchant.com.mycompany.myapp"
    request.supportedNetworks = [.visa, .masterCard, .amex]
    request.merchantCapabilities = .capability3DS
    
    // Use a currency set to match your Merchant Account
    request.countryCode = "CA" // "US"
    request.currencyCode = "CAD" // "USD"
    
    request.paymentSummaryItems = [
        PKPaymentSummaryItem(label: "1 Golden Egg", amount: NSDecimalNumber(string: "1.00"), type: .final),
        PKPaymentSummaryItem(label: "Shipping", amount: NSDecimalNumber(string: "0.05"), type: .final),
        PKPaymentSummaryItem(label: "GST Tax", amount: NSDecimalNumber(string: "0.07"), type: .final),
        PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "1.12"), type: .final)
    ]
    
    self.paymentAmount = NSDecimalNumber(string: "1.12")
    
    let authVC = PKPaymentAuthorizationViewController(paymentRequest: request)
    authVC.delegate = self
    present(authVC, animated: true, completion: nil)
}
```

> Note: We not only support, but recommend the use of 3D Secure with Visa, MasterCard, and America Express using `.capability3DS`.

### Issue Payment Token

This sample outlines how to handle the payment token once the payment request has been successfully authorized. 
To send the generated token to the server, execute the following request.

```swift
// Executes a process payment request on the Mobile Payments Demo Server
func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                        didAuthorizePayment payment: PKPayment,
                                        completion: @escaping (PKPaymentAuthorizationStatus) -&gt; Void) {
    // Get payment data from the token and base64 encode it
    let token = payment.token
    let paymentData = token.paymentData
    let b64TokenStr = paymentData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let transactionType = self.purchaseTypeSegmentedControl.selectedSegmentIndex == 0 ? "purchase" : "pre-auth"
    let parameters = [
        "amount": self.paymentAmount,
        "transaction-type": transactionType,
        "apple-wallet": [
            "payment-token": b64TokenStr,
            "apple-pay-merchant-id": "merchant.com.mycompany.myapp"
        ]
    ] as [String : Any]

    Alamofire.request(DemoServerURLBase + "/process-payment/apple-pay",
                      method: .post,
                      parameters: parameters,
                      encoding: URLEncoding.httpBody).responseJSON { response in

        let statusCode = response.response?.statusCode
                    
        if statusCode == 200 {
            completion(.success)
        }
        else {
            completion(.failure)
        }
    }
}
```

>It's important that the ***payment_token is Base64 encoded*** and included in the paymentData object.

>Below is an example of the paymentData object that should be submitted.

```
{
   "data": "...xxxxxxxxx...",
   "signature": "...xxxxxxx...",
   "header": {
       "ephemeralPublicKey" : "...xxxxx...",
       "publicKeyHash": "XwslXXdP388+XdHp4XpX1bc2Xp48XXXynlaqc4XXiIg=",
       "transactionId": "8158127844d5aa8ede2c2401e2370f24ab2d6b15a1943a1fc3ff15f6d777abxx"
   },
   "version": "EC_v1"
}
```

>If the paymentData has a different format you will get an error like this: "Payment Token Version Not Supported: EC_vX", or this "Expected token version not found."

> Note: This iOS client is sending the payment token to our Payment APIs Demo Server, as outlined on [Github](https://github.com/bambora/na-payment-apis-demo).


## Test Cards

You can add the test cards listed below to your Apple Wallet and use them to trigger approved responses from our gateway. You can use these test cards on your Bambora test accounts, but not on your live account. More info on using test cards within the Apple Pay sandbox environment is listed [here](https://developer.apple.com/support/apple-pay-sandbox/).


| Brand                     | Card number         | CVV   | Expiry  |
|:--------------------------|:--------------------|:------|:--------|
| Visa Card                 | 4030 0000 1000 1234 | 111   | 11/2027 |
| Mastercard                | 5204 2477 5000 1471 | 111   | 11/2027 |
| American Express          | 3499 569590 41362   | 1111  | 12/2027 |
| Discover                  | 6011 0009 9091 1111 | 111   | 11/2027 |
| JCB                       | 3569 9998 5006 0781 | 111   | 11/2027 |
Notes: The Expiry can be any date in the future
