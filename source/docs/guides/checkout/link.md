---
title: Linking to Checkout
layout: tutorial

summary: Checkout provides you with an easy-to-use way to process payments on your site.

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.checkout_guide
    header_active: guides
---

## Create links
In order to redirect the user to the Checkout Form, you will need to create a button or link for them to click.

Checkout is configured by the parameters passed in the URL of a GET request. The key/value pairs of the query string are secured by passing a hashed string created from the query string, in addition to the query string itself.

While it is possible to also do this through a Form element using a POST request, we have found that the POST approach does not always work with older browsers and some versions of Internet Explorer. We recommend using a GET request with a link or button.

The most basic URL contains just the `merchant_id` and `hashValue` parameters. If your merchant ID is "123456789" and your hash key is "abc", you would create a SHA-1 hash of the string `merchant_id=123456789abc`. You would then pass the hashed string with the parameters `hashValue`.  It is recommended to include as much data as possible in the hash.

```curl
https://web.na.bambora.com/scripts/payment/payment.asp?merchant_id=123456789&trnAmount=0.19&trnOrderNumber=3213213&trnType=credit&trnCardOwner=bogus+name&hashValue=8fac840f314153daa53f988574f0d903af7a58b3
```

Any parameters passed within the hashed string is secure and cannot be modified. Any parameters passed after the `hashValue` parameter are insecure and can be modified.

You can quickly create links for testing or one-off payments using this [form](https://dev.na.bambora.com/docs/forms/link_builder/).

## Authorization

Checkout links are authorized by passing your Merchant ID and a string hashed with your Hash Key. You can find both in the [Member Area](https://web.na.bambora.com).

Your Merchant ID is permanently displayed at the top right corner of the screen. Your Hash Key is on the Order Settings panel. Click **administration** then **account settings**, and finally **order settings**.

### Sample link
```curl
https://web.na.bambora.com/scripts/payment/payment.asp?
merchant_id=300203940
&trnAmount=10.00
&ordName=Jane+Smith
&ordPostalCode=V8T+4M3
&ordProvince=BC
&ordCountry=CA
&hashValue=ec6dccdc5ec2fc9314fdce5ea079abfa5db0d748
```

### Sample response redirect
```curl
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
```
<div style="margin-bottom:24px;"></div>
