---
title: Checkout
layout: tutorial

summary: Checkout provides you with an easy-to-use way to process payments on your site.

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.checkout_guide
    header_active: guides
---

# Checkout

<br>Checkout allows you to accept payments online with just one link. It is a hosted payment form that supports payment cards and [Visa Secure Remote Commerce (SRC)](https://dev.na.bambora.com/docs/guides/visa_checkout). You can link to Checkout from your website or from an email, allowing it to slot into either a shopping cart flow or an invoicing flow.
This guide will show you how to create a form and a link before sending it out to clients, customers, and donors

This guide will show you how to create a form and a link before sending it out to clients, customers, and donors.

## Example
A common use of Checkout would involve hosting a link or a button on your own website that would then redirect the user to the Checkout product hosted on Worldline’s services.

Try it out! Click the "Pay" button below. You can use using the test card number **4030 0000 1000 1234**, with a security code **123** and any expiry date in the future. Checkout will open in a new tab.

<a href="https://web.na.bambora.com/scripts/payment/payment.asp?merchant_id=300204468&trnAmount=10.00&hashValue=198b1de5fae8e1671bdf720cbbf292e15671dfaa" class="btn btn-small"
target="\_blank" style="word-spacing: .3em; letter-spacing: .05em;
        padding-left:40px; padding-right:40px;">Pay $10</a>

See a [demo](https://demo.na.bambora.com/checkout.html) of a complete payment flow using Checkout, and view the [source](https://github.com/bambora/na-payment-apis-demo).

Please note when using 3DS, Cardholder Name and either Billing Email or Billing Phone Number are **mandatory** for Visa.

## Custom Checkout vs Checkout

Checkout is an alternative to building your own payment form with Custom Checkout.

* Both solutions are PCI SAQ A compliant.
* Checkout is a payment form - it takes payments. Custom Checkout is a tokenizaton library - it returns a token that you can pass to the Payment API to take a payment.
* Checkout involves redirecting the user to a payment form on bambora.com. Custom Checkout embeds Worldline hosted input fields in your webpage.
* Checkout is not brandable. [Custom Checkout](https://dev.na.bambora.com/docs/guides/custom_checkout/) allows you to build a fully customized payment form - you retain as much control over UI/UX as you do with native DOM elements.

## Browser support

These are the browsers we actively test.

### Desktop
* Chrome latest
* Firefox latest
* Internet Explorer 10+
* Microsoft Edge
* Safari 8+

### iOS
* Safari 8+
* Chrome 48+ (iOS 9+)

### Android
* Native browser 4.4+
* Chrome
* Firefox


## Test account

Try it out on a [test account](https://dev.na.bambora.com/docs/forms/create_test_merchant_account).
