---
title: Partner Quickstart
layout: tutorial

summary: >
    Learn how to request your partner account, how to test the Onboarding API, and authenticate on behalf of sub-merchants.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.partner_quickstart
  header_active: Guides
---
<style>
.mainDiv a:link
 {    
  color:  #45beaa!important;
  text-decoration-color: #7847b5;
  text-underline-offset: 6px;
}
.mainDiv a:hover{
  color: #2d8c8c!important;
}
.mainDiv a:visited {    
  color:  #45beaa!important;
  text-decoration-color: #7847b5;
  text-underline-offset: 6px;
}
.mainDiv a:active {    
  color: #2d8c8c!important;
  text-decoration-color: gray;
}

</style>

# Partner Quickstart

Welcome to our partner setup guide. Learn how to request your partner account, and how to test the Onboarding API.

This guide will show you how to create and configure a test account.
<div class="mainDiv">
This guide builds on the [Merchant Quickstart Guide](/docs/guides/merchant_quickstart/).

## 1. Request a partner account
You can request a test partner and merchant account [here](/docs/forms/create_test_merchant_account/).

## 2. Authentication for Sub-Merchant
Partners can make calls to our Payment APIs on behalf of their sub-merchants if they are configured to do so. You can request this to be enabled.

You will need an Authorization header as described in the [Merchant Quickstart Guide](/docs/guides/merchant_quickstart/):
</div>

```
Authorization: Passcode Base64Encoded(your_partner_merchant_id:passcode)
```
 
To process on behalf of a sub-merchant you will need a header with the merchant Id of your sub-merchant:

```
Sub-Merchant-Id: your_sub_merchant_id
```
