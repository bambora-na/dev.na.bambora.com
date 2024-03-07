---
title: Google Pay
layout: tutorial

summary: >
    Our Payments API now exposes a new 'google_pay' payment method and associated parameters to accept a Google Pay transaction payload.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Google Pay&#8482;*

## About Google Pay

Our Payments API allows your mobile app and online store to accept payments using Google Pay.

The card networks currently supported by our Google Pay solution are **VISA, Mastercard, American Express, Discover, and JCB.**

## Getting Started

If this is your first time implementing our APIs we recommend reviewing our [Reference guide](/docs/references/payment_APIs/), to get familiar with Bambora's Payment APIs.

You can find more about Bambora and Google Pay on [Github](https://github.com/bambora/na-payment-apis-demo).

## Requirements

### **Use Case 1:** Merchant uses Worldline's Hosted Checkout platform to facilitate Google Pay payments without integrating with Google's API.

#### Hosted Checkout

If you are using BIC's Hosted Checkout service, there is no registration required with Google. In this case all integration with the Google Pay API will be managed by Worldline.

##### 1. Enable Google Pay

To turn on Google Pay for your account, log into the [Member Area](https://fra01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fweb.na.bambora.com%2F&data=05%7C02%7Csagar.wadikar%40worldline.com%7C71f7bdedeb974d5e36bf08dc0e28df82%7Cfda9decfe89243ac9d9f1a493f9f98d0%7C0%7C0%7C638400815938324807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=CFLNmsTfJoIJZC5UmPnGLKGScjcxdLy3johTtGaLWd4%3D&reserved=0). Under configuration, click on checkout. From the checkout screen you can include the Google Pay Button. By default, this field will be set to "No". If changed to "Yes", a Google Pay button will appear on your Hosted Checkout screen.

<img src="/docs/guides/google_pay/include-googlepay-btn-screenshot.png" alt="The checkout settings page showing the checkbox to include the Google Pay button">
*The setting to include the Google Pay button in the Hosted Checkout is seen at the bottom-right of the image*

##### 2.	Google Pay Button on Hosted Checkout 

A Google Pay button will be added at the top of the Hosted Checkout screen if the option was enabled in step 1. To use Google Pay, click the GPay button.

<img src="/docs/guides/google_pay/checkout-googlepay-btn-screenshot.png" alt="The Hosted Checkout screen with the Google Pay button included">

The Google Pay sheet will open and request the user to log in to Google using their credentials. On the Google Pay sheet, select your pre-stored card saved in the Google account. To complete the purchase, select Continue.

<img src="/docs/guides/google_pay/googlepay-sheet-screenshot.png" alt="The Google Pay sheet that appears on the Hosted Checkout">
*Note: This image was taken while using the Google Pay test environment*

### **Use Case 2:** Merchant selects Worldline as their Payment Processor through Google's API Integration.

These are the steps needed to integrate with Worldline’s APIs:

#### 1. Registration of Merchants with Google

Merchants will need to register with Google prior to integrating with Google Pay APIs using Worldline's Gateway Registration ID. This use case covers Merchants using Worldline as their gateway processor. Worldline will encrypt and decrypt the payloads on behalf of merchants. Details of the parameters required to integrate with Google's API have been specified below in the API Requests section.

##### Requirements

>• Android applications must first be distributed through the Google Play store before they can be integrated with the Google Pay API.

>• Android devices used for testing must have Google Play services version 18.0.0 or higher installed.

>• A Google Account is required to request production access to the Google Pay API. The merchant will be asked some basic information about their business and are required to agree to the Terms of Service and Privacy Policy.

For more info on the registration process for merchants, visit:

[Google Pay for Payments > Android](https://developers.google.com/pay/api/android/overview)

[Google Pay for Payments > Web](https://developers.google.com/pay/api/web/overview)

#### 2.	API Parameters for Worldline processors

Merchants who choose to integrate with Google’s API and use Worldline as their gateway processor will need to pass the parameters mentioned below to Google’s API.

##### Register with Google

Merchants will need to register with Google and integrate with Google Pay APIs using Worldline's Gateway Registration ID. This use case covers Merchants using Worldline as their gateway processor. Worldline will encrypt and decrypt the payloads on behalf of Merchants. Details of parameters required to integrate with Google API have been specified below.

##### Pass the correct parameters to the API

Merchants who choose to integrate with Google’s API and use Worldline as their gateway processor will need to pass the parameters below to Google’s API.

<img src="/docs/guides/google_pay/guide-request-payment-token-screenshot.png" alt="A screenshot from the Google Pay guide showing how to request a payment token">

**When performing the request shown in the above screenshot, use "worldlinena" as the value for "gateway", and use your specific gateway merchant ID (your BIC merchant ID registered with Worldline) as the value for "gatewayMerchantId".**

[Google’s integration tutorial](https://developers.google.com/pay/api/web/guides/tutorial)

## API Requests

After you've received the Payment Data object, you'll need to extract the Google Pay transaction payload from it like so:

```
transactionPayload = paymentData.paymentMethodData.tokenizationData.token;
```

Once the Google Pay payload is received and you make a `google_pay` request to our Payments API, it'll be formatted in JSON, calling to https://api.na.bambora.com/v1/payments/.

```shell
  curl https://api.na.bambora.com/v1/payments \
    -H "Authorization: Passcode XXX1XXx11Xxx1xX1XxxxXxXXXXx1XXX1XxX1XXXxXXXxXxxxX11XXXxX1" \
    -H "Content-Type: application/json" \
    -d '{
          "amount": 1.00,
          "payment_method": "google_pay",
          "customer_ip": "123.123.123.123",
          "term_url": "https://www.beanstream.com/debug.asp",
          "google_pay": {
            "name": "name",
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
            },
            "transaction_payload": "<your_google_pay_transaction_payload>",
            "complete": true
          }
        }'
```

| Variable | Description |
| -------- | ----------- |
| amount | The amount of the transaction. |
| payment_method | The method of payment for the transaction. For Google Pay, this will always be `google_pay` |
| customer_ip | **(Only required for 3DS-enabled merchants)** The IP Address of the cardholder's browser. |
| term_url | **(Only required for 3DS-enabled merchants)** The URL that the customer will be redirected to after completing their 3DS challenge. Maximum length of 255 characters. |
| google_pay | The object needed to pass a Google Pay transaction payload. The remaining items in this list are the parameters of this object. |
| name | The cardholder name. |
| 3d_secure | The object containing info required for PAN_ONLY 3DS transactions. [Detailed info here.](https://dev.na.bambora.com/docs/guides/3D_secure_2_0/#request-parameters) |
| transaction_payload | Payload string that contains the encrypted Google payment token (required to complete a transaction), along with other security information. |
| complete | The type of transaction being performed. True indicates a Purchase, and false is a Pre-Authorization. |

## Additional Info

For more information about testing with Google Pay:

[Test Card Suite](https://developers.google.com/pay/api/web/guides/resources/test-card-suite)

[Sample Tokens](https://developers.google.com/pay/api/web/guides/resources/sample-tokens)

*TD Support Only