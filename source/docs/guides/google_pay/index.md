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

# Google Pay

## About Google Pay

Our Payments API allows your mobile app and online store to accept payments using Google Pay.

## Getting Started

If this is your first time implementing our APIs we recommend reviewing our [Reference guide](/docs/references/payment_APIs/), to get familiar with Bambora's Payment APIs.

You can find more about Bambora and Google Pay on [Github](https://github.com/bambora/na-payment-apis-demo).

## Requirements

If you are using BIC's Hosted Checkout service, there is no registration required with Google. In this case all integration with the Google Pay API will be managed by Worldline. 

Otherwise, you need to register your mobile or web app with Google in order to use the Google Pay API.

### Google Pay on Android

(todo: write this section)
[Google Pay for Payments > Android](https://developers.google.com/pay/api/android/overview)

### Google Pay on Web Apps

(todo: write this section)
[Google Pay for Payments > Web](https://developers.google.com/pay/api/web/overview)

## API Requests

(todo: review this section to see if any changes are needed)

When you make a `google_pay` request to our Payments API, it'll be formatted in JSON, calling to https://api.na.bambora.com/v1/payments/.

```shell
  curl https://api.na.bambora.com/v1/payments \
    -H "Authorization: Passcode XXX1XXx11Xxx1xX1XxxxXxXXXXx1XXX1XxX1XXXxXXXxXxxxX11XXXxX1" \
    -H "Content-Type: application/json" \
    -d '{
          "amount": 1.00,
          "payment_method": "google_pay",
          "google_pay": {
            "transaction_payload": "<your_google_pay_transaction_payload>",
            "complete": true
          }
        }'
```

| Variable | Description |
| -------- | ----------- |
| amount | The amount of the transaction. |
| payment_method | The method of payment for the transaction. For Google Pay, this will always be `google_pay` |
| google_pay | The object needed to pass a Google Pay transaction payload. |
| transaction_payload | The unencrypted transaction payload, to be encrypted by the BIC system before being sent to Google. |
| complete | The type of transaction being performed. True indicates a Purchase, and false is a Pre-Authorisation. |

## Additional Examples

(todo: look at this section on the Apple Pay guide and add similar examples here if there are any, otherwise delete this section)

## Test Cards

You can add the test cards listed below to your Google Pay App and use them to trigger approved responses from our gateway. You can use these test cards on your Bambora test accounts, but not on your live account. More info on using test cards within the Google Pay test environment is listed [here](https://developers.google.com/pay/api/android/guides/resources/test-card-suite).

(todo: add actual test cards)

| Brand                     | Card number         | CVV   | Expiry  |
|:--------------------------|:--------------------|:------|:--------|
| Placeholder               | XXXX XXXX XXXX XXXX | 111   | 11/2022 |
| Placeholder 2             | XXXX XXXX XXXX XXXX | 111   | 11/2022 |
