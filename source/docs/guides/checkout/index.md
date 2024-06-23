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

<div style='border-color:red; border-style:solid;padding: 1% 1%' ><p style='font-weight:bold'>PLEASE NOTE: Checkout will no longer be brandable after February 28, 2025.</p> 
 
To comply with the <a href="https://docs-prv.pcisecuritystandards.org/PCI%20DSS/Standard/PCI-DSS-v4_0.pdf" target="\_blank">PPCI DSS v4.0</a> the brandable functionality of Worldline’s hosted Checkout form will no longer be available after <strong>February 28, 2025</strong>. Please review the upcoming changes:
<ul>
  <li>Custom headers and footers will no longer be supported.</li>
  <li>Custom headers and footers will no longer be supported.</li>
  <li>For a fully brandable checkout solution, please use Worldline’s <a href="https://dev.na.bambora.com/docs/guides/custom_checkout/" target="\_blank">Custom Checkout.</a></li>
</ul>
</div>

<br>Checkout allows you to accept payments online with just one link. It is a hosted payment form that supports payment cards and [Visa Secure Remote Commerce (SRC)](https://dev.na.bambora.com/docs/guides/visa_checkout). You can link to Checkout from your website or from an email, allowing it to slot into either a shopping cart flow or an invoicing flow.
This guide will show you how to create a form and a link before sending it out to clients, customers, and donors

This guide will show you how to create a form and a link before sending it out to clients, customers, and donors.

## Example
A common use of Checkout would involve hosting a link or a button on your own website that would then redirect the user to the Checkout product hosted on Bambora's services.

Try it out! Click the "Pay" button below. You can use using the test card number **4030 0000 1000 1234**, with a security code **123** and any expiry date in the future. Checkout will open in a new tab.

<a href="https://web.na.bambora.com/scripts/payment/payment.asp?merchant_id=300204468&trnAmount=10.00&hashValue=198b1de5fae8e1671bdf720cbbf292e15671dfaa" class="btn btn-small"
target="\_blank" style="word-spacing: .3em; letter-spacing: .05em;
        padding-left:40px; padding-right:40px;">Pay $10</a>

See a [demo](https://demo.na.bambora.com/checkout.html) of a complete payment flow using Checkout, and view the [source](https://github.com/bambora/na-payment-apis-demo).

## Custom Checkout vs Checkout

Checkout is an alternative to building your own payment form with Custom Checkout.

* Both solutions are PCI SAQ A compliant.
* Checkout is a payment form - it takes payments. Custom Checkout is a tokenizaton library - it returns a token that you can pass to the Payment API to take a payment.
* Checkout involves redirecting the user to a payment form on bambora.com. Custom Checkout embeds Worldline hosted input fields in your webpage.
* Checkout is not brandable. [Custom Checkout](https://dev.na.bambora.com/docs/guides/custom_checkout/) allows you to build a fully customized payment form - you retain as much control over UI/UX as you do with native DOM elements.

## Migration

Checkout enhances our legacy Hosted Payment Form. Accounts opened after 1 August 2017 come with Checkout. If your account predates this, you will need to enable Checkout styling on your account.

You can enable Checkout styling on your legacy Hosted Payment Form in the [Member Area](https://web.na.bambora.com). Click on **configuration**, and select **payment form**. Simply copy and paste these two blocks of code into the corresponding text fields.

**Page Header**

```html
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/ui.bambora/ui.bambora.1.1.0.css">
    <link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/style.css">
  </head>
  <body>
    <script src="https://libs.na.bambora.com/checkouttheme/0.1.0/checkouttheme.min.js"></script>
    <script>CheckoutTheme.init();</script>
```
<div style="margin-bottom:24px;"></div>

**Page Footer**

```html
  </body>
</html>
```
<div style="margin-bottom:24px;"></div>

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
