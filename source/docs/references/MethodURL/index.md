---
title: Method URL
layout: tutorial

summary: >
    The Address Verification System (AVS), is a free tool that compares customer-submitted order information against bank databases.
    
navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.method_url
  header_active: References
---


# Merchant Integration with Method URL

## Method URL Integration using Worldline’s Library

Worldline’s North American division has developed a library based on the JavaScript framework hosted on Worldline's web servers. This library can be easily added or included in any client application running on any device, mobile or desktop. The library provides all the necessary methods/functions to help facilitate the processing of Method URL. The library encapsulates all the internal details and only highlights the relevant info needed to process Method URL. The merchant needs to include the library in their application and follow the steps listed below to integrate the Method URL process within their web application. The library will be compatible with most of the latest browsers and devices, the full details regarding the library’s support can be found below.

## Merchant Hosted Checkout Solution

The below technical details will help merchants integrate the JS library needed to invoke Method URL on their hosted checkout solution. The technical details of the JS library and its versions, as well as the functionality covered in each version will also be listed.

## Setup

### Step 1: Add reference to the JS Library 

Include the reference to the Worldline-provided JS library in the webpage or any relevant client application.

```shell
<script src='https://web.na.bambora.com/assets/emv3ds/methodurl_1.0.0.js'></script>
```

**Note:** The below example is for a simple html-based web application. The inclusion step below will differ as per the UI application frameworks. Please refer to application framework documentation for details.

### Step 2: Create div element

Merchants needs to create a Div element on the web page that will host the iframe, form, and required HTML fields to submit the Method URL in subsequent steps. The JS library will provide a method to facilitate the creation of all the HTML elements needed for the execution.

**Note:** The below name is a recommended sample name. Merchants need to assess the name in case there are multiple implementations of Method URL for multiple processors. In case of multiple implementations merchants can prefix the name to worldline. ex worldlineMethodURLBox

```shell
<!-- ... -->
<div id="methodURLBox"></div>
<!-- ... -->
```

### Step 3: Initialize Method URL

Configure/Declare the Method URL object from the library to use the inbuilt internal functions provided by the library. Please find below a sample declaration of the object.

```shell
<script>
    var methodURL = worldlineMethodurl();
</script>
```

Create/setup the required HTML elements (Iframe, form, and hidden input) needed to submit the Method URL within the merchant’s browser. The JS library provides a method to create all the required HTML elements using the below method.

*methodURL.CreateElements(parentId)* - parentid is the id of the div element created in step 1.

### Step 4: Execute Method URL

Once the JavaScript library is referenced or loaded in the web page and the Method URL object is initialized in step 2, the web page is ready to invoke the Method URL process. The Method URL process can be executed once the credit card information is available or made available by the cardholder on the merchant’s hosted checkout. Ideally the event that will invoke the Method URL process would be an onChange event of the Card number text field on the checkout page.

The command to invoke the Method URL process is as below and expects a input parameter of the actual Card Number or PAN Number of the card holder.

Method Name: *methodURL.Execute(cardNumber)*

Input : cardNumber : Card Number of the cardholder.

Response : Result object will be returned back to the merchants

* Result.threeDSServerTransactionId : The DS server transaction Id issued by the DS server to identify the Method URL process initiated by the merchant. The merchant needs to pass this field to Worldline’s payment API. This field will be passed to the 3DS Authentication request to help the issuer identify the Method URL execution. 
* Result.Error : In case of errors in the execution or invocation of Method URL, the error attribute will be returned by the Execute method.
* Result.Info : More details can be found in the Info attribute.

Please note that the Method URL execution process consists of the below steps that have been encapsulated by the JS Library to help merchants integrate Method URL within their hosted checkout.

 1. **Method URL from DS server :** The JS library will request the Method URL from the DS Server through Worldline’s public service. Worldline’s Prepinfo service endpoint will be calling the DS server’s service to get the Method URL for the card holder’s PAN no.
 2. **Initial Method URL :** The JS library will create an Iframe and related HTML elements on the merchant’s browser by accessing its div element. Merchants need to create a Div element named “MethodURLBox” as mentioned in step 2.
 3. **Invoke/Submit Method URL:** If Method URL is received for the card number used by the cardholder then the final step will be to submit the form created in step 3 along with the DS transaction server Id as threeDSServerTransactionId. A notification URL to receive a response from the issuer once Method URL execution is completed will be encapsulated and provided by the JS library.

**Note:** Steps 1 – 4 will be executed seamlessly behind the scenes and users won’t experience any post back or loading of the hosted checkout page. 

### Final Step: REST API Integration

Create a regular Payment request once the Method URL process is submitted behind the scenes while the card holder is busy filling in any other details. The final step will be to submit the payment request on the hosted checkout page. The submission of the payment will trigger the merchant’s integration with Worldline’s Payment APIs.

Below, additional APIs attributed will be introduced in the Payment API under the 3d_secure section to confirm the Method URL processing prior to the Payment request.

Two fields that will be added are:

**disable_method_url:**

* Description: Indicates whether or not BIC Method URL has been disabled for the current transaction.

True: If Method URL is not executed or not eligible for the card.

False: If Method URL is eligible and the Merchant has submitted the Method URL process using the JS library provided by Worldline.

**threeDS_server_transaction_id:**

* Description: The threeDS_server_transaction_id returned by the call to the PrepInfo endpoint. This unique ID identifies the processing of Method url and will be used by the issuer to identify successful execution.

The detailed payment Api specifications can be found at [Payment APIs Spec](/docs/references/payment_APIs/v1-0-5). 

## Demo

The entire implementation of Method URL can be reviewed using our Demo app hosted [here](https://codepen.io/na-bambora/pen/QWeZbgv).

## Test Data

| Card Type | Card Number | Flow Type | 
|--------|---------|-----|
|Amex|373410980824106|Challenge|
|Amex|343565236909840|Challenge|
|MasterCard|5136347700590830|Challenge|
|Visa|4716519788977219|Challenge|
|Visa|4012007153923001|Challenge|
