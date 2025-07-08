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

## Method URL Integration using Worldline's Library

Worldline's North American division has developed a library based on the JavaScript framework hosted on Worldline's web servers. This library can be easily added or included in any client application running on any device, mobile or desktop. The library provides all the necessary methods/functions to help facilitate the processing of Method URL. The library encapsulates all the internal details and only highlights the relevant info needed to process Method URL. The merchant needs to include the library in their application and follow the steps listed below to integrate the Method URL process within their web application. The library will be compatible with most of the latest browsers and devices, the full details regarding the library's support can be found below.

## Merchant Hosted Checkout Solution

The below technical details will help merchants integrate the JS library needed to invoke Method URL on their hosted checkout solution. The technical details of the JS library and its versions, as well as the functionality covered in each version will also be listed.

## Setup

### Step 1: Add reference to the JS Library 

Include the reference to the Worldline-provided JS library in the webpage or any relevant client application.

```shell
<script src='https://web.na.bambora.com/assets/emv3ds/2/methodurl.js'></script>
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

### Step 3: Initialize Method URL and create HTML Elements

Configure/Declare the Method URL object from the library to use the inbuilt internal functions provided by the library. Please find below a sample declaration of the object.

```shell
<script>
    var methodURL = worldlineMethodurl();
</script>
```

Create/setup the required HTML elements (Iframe, form, and hidden input) needed to submit the Method URL within the merchant's browser. The JS library provides a method to create all the required HTML elements using the below method.

*methodURL.CreateElements(parentId,callback)* - parentId is the id of the div element created in step 2 (i.e. methodURLBox). The callback function receives a callback once the operation completes.

### Step 4: Execute Method URL

Once the JavaScript library is referenced or loaded in the web page in step 1 and the Method URL object is initialized with HTML elements in step 2 and 3, the web page is ready to invoke the Method URL process. The Method URL process can be executed once the credit card information is available or made available by the cardholder on the merchant's hosted checkout. Ideally the event that will invoke the Method URL process would be an onChange event of the Card number text field on the checkout page.

The command to invoke the Method URL process is as below and expects the input parameters requestBody, callback function and waitTime.

*Method Name: methodURL.Execute(requestBody, callback, waitTime)*

**requestBody :** requestBody is a block that takes two additional parameters.

1. payment_method : This parameter is similar to the one used in Worldline's Payment APIs and can take either "card" or "payment_profile" as parameters.

>>Acceptable values: "card", "payment_profile"

2. The second parameter depends the first parameter's value.

>>If the payment_method is "card" then the second parameter will be "card_number". If the payment_method is "payment_profile", it will be "limited_use_card_token".

>Sample input parameters for requestBody:

>*Using a Card number*

```json
{
    "payment_method": "card",
    "card_number": "4567350000427977"
}
```

>*Using a payment profile*

```json
{
    "payment_method": "payment_profile",   
    "limited_use_card_token": "6EA66EEF-7A09-4DD0-9DA6-12E5E2A45992"
}
```

**Callback :** callback function to receive a callback once the operation completes.

**Waittime :** specifies the wait time in seconds to wait for the completion of the Method URL process. This parameter is optional and provides merchants flexibility to choose a wait time for the entire Method URL process. If the Method URL process does not complete within the time specified then the process will abort and the status within the library will be updated as failed. The default value as per recommendation by the issuer is 10 seconds in case it is not provided in the execute function.

#### waitforstatus implementation

The latest Method URL library provides an optional functionality to assign a wait time to the merchant's submit button on the checkout page. The method provides wait time functionality without the merchant having to implement the solution themselves, thus saving additional development effort. The wait time value can be provided with the execute method.

Sample code to integrate waitforstatus with the submit button of a checkout page:

```js
// Include below sample code. It calls the waitforstatus method that implements wait time until Method URL completes.
// methodURL is the object created on step 3 of the set up.
methodURL.waitForStatus().then((result) => {
})
.catch((err) => {
// Catch the promise reject response when wait exceeds maximum wait time value
})
.finally(() => {
// Submit the transaction to Worldline's payment API.
});
```

#### Status

There will be 4 different statuses the JS library will provide:

* **NotSupported:** which means the card does not support 3ds Method URL.

* **Pending:** which indicates when the Method URL invocation is started and is in progress.

* **Complete:** which indicates when the invocation is completed.

* **Error:** which means an unhandled exception occurred.

**Response :** A Result object will be returned back to the merchants in the callback function. The below three fields will be returned by the Result object.

* **Result.threeDSServerTransactionId :** The DS server transaction ID issued by the DS server to identify the Method URL process initiated by the merchant. The merchant needs to pass this field to Worldline's payment API. This field will be passed to the 3DS Authentication request to help the issuer identify the Method URL execution.
* **Result.Error :** In case of errors in the execution or invocation of Method URL, the error attribute will be returned by the Execute method.
* **Result.Info :** More details can be found in the Info attribute.

Please note that the Method URL execution process consists of the below steps in sequence that have been encapsulated by the JS Library to help merchants integrate Method URL within their hosted checkout.

1. **Method URL from DS server :** The JS library will request the Method URL from the DS Server through Worldline's public service. Worldline's Prepinfo service endpoint will be calling the DS server's service to get the Method URL for the card holder's PAN no.
2. **Initiate Method URL :** The JS library will create an Iframe and related HTML elements on the merchant's browser by accessing its div element. Merchants need to create a Div element named 'MethodURLBox' as mentioned above in the setup step 2 & 3.
3. **Invoke/Submit Method URL :** If Method URL is received for the card number used by the cardholder in step 1 then the final step will be to submit the form created in step 3 along with the DS transaction server Id as threeDSServerTransactionId. A notification URL to receive a response from the issuer once Method URL execution is completed will be encapsulated and provided by the JS library.

**Note:** Setup steps 1 - 4 will be executed seamlessly behind the scenes and users won't experience any post back or loading of the hosted checkout page.

### Final Step: REST API Integration

Create a regular Payment request once the Method URL process is submitted behind the scenes while the card holder is busy filling in any other details. The final step will be to submit the payment request on the hosted checkout page. The submission of the payment will trigger the merchant's integration with Worldline's Payment APIs.

Below, additional API attributes will be introduced in the Payment API under the 3d_secure section to confirm the Method URL processing prior to the Payment request.

The two fields that will be added are:

**disable_method_url**

* *Description:* Indicates whether or not BIC Method URL has been disabled for the current transaction.

* *Value:* The value will be True or False depending on the Method URL process. True if Method URL was not executed/completed successfully or not eligible for the card. False if Method URL is eligible and executed/completed using the JS library provided by Worldline.

**threeDS_server_transaction_id**

* *Description:* The threeDS_server_transaction_id returned by the call to the PrepInfo endpoint. This unique ID identifies the processing of Method url and will be used by the issuer to identify successful execution.

* *Value:* A unique GUID received from the DS server.

The detailed Payment API specifications can be found at [Payment APIs Spec](/docs/references/payment_APIs/v1-0-5).

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
