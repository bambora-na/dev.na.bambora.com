---
title: Method URL
layout: tutorial

summary: >
    Method URL is a concept in the EMV 3DS protocol that allows an issuing bank to obtain additional browser information at the start of the authentication session to help facilitate risk-based authentication.
    
navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: References
---

# MethodURL Reference

## Method URL library functions

### MethodURL.execute

`methodURL.execute(requestBody, callback, waitTime)`

The execute method will invoke the MethodURL process and expects a requestBody, callback method and waitTime. It returns a result object.

| Argument | Type | Description |
| -------- | ---- | ----------- |
| *requestBody* | Object | Consists of 2 string parameters: <br/> 1. payment_method determines the payment method which can be either 'card' or 'payment_profile' <br/> 2. If the payment_method is 'card', the second param will be card_number. Alternatively, if the payment_method is 'payment_profile', the second param will be limited_use_card_token. |
| *callback* | Object | Callback function to receive a callback once the operation completes. |
| *waitTime* | Integer | Specifies the wait time in seconds to wait for the completion of the Method URL process. This parameter is optional and will default to 10 seconds if not provided. |

#### requestBody: json

requestBody json example (use case - card) :

```json
{
"payment_method": "card", 
"card_number": "456735XXXX427977"
}
```

requestBody json example (use case - payment_profile) :

```json
{
"payment_method": "payment_profile", 
"limited_use_card_token": "6EA66EEF-7A09-4DD0-9DA6-12E5E2A45992"
}
```

#### return type: result

| Parameter | Type | Description |
| --------- | ---- | ----------- |
| result.threeDSServerTransactionId | String | The DS server transaction ID issued by the DS server to identify the Method URL process initiated by the merchant. |
| result.Error | String | The error details will be available in this object. |
| result.Info | String | Additional information will be provided about the Method URL process. |

### MethodURL.CreateElements

`methodURL.CreateElements(parentId,callback)`

This function will create all the necessary HTML elements including Iframe on the checkout page required to process Method URL.

| Parameter | Type | Description |
| --------- | ---- | ----------- |
| parentId | Object | The ID of the div element created to initialize the JS library (Please refer to the Guide section for detailed integration steps). |
| callback | Object | Callback function to receive a callback once the operation completes. |

### methodURL.waitForStatus

`methodURL.waitForStatus(result)`

The Method URL library (please refer to the release notes section on the library version that supports this functionality) provides the waitForStatus method to assign a wait time to the merchant's submit button on the checkout page.

| Parameter | Type | Description |
| --------- | ---- | ----------- |
| result | Object | The result object will get the error and info objects back with details. |

#### return type : state

| Parameter | Type | Description |
| -------- | ---- | ----------- |
| state | Object | The state object will be returned once the MethodURL process completes or aborts due to timeout or any other reason.  |

state.methodurlStatus : The methodurlStatus property will provide the status of the Method URL process. This status is used within the JS library only.

| Value | Type | Description |
| ----- | ---- | ----------- |
| NotSupported | String | Indicates the card does not support 3DS Method URL. |
| Pending | String | Indicates when the Method URL invocation has been initiated and is in progress. |
| Complete | String | Indicates the MethodURL process has completed. |
| Error | String | Indicates that an exception occurred. |

#### sample code for waitTime implementation

```js
//Include below sample code within your submit button click. 
//It calls the waitforstatus method.
methodURL.waitForStatus().then((result) => {
}) 
.catch((err) => {
//Catch the promise reject response when wait exceeds maximum wait time value
})
.finally(() => {
// Submit the transaction to Worldline's payment API. 
});,
```