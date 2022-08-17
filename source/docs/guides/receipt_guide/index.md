---
title: Receipt Integration Guide 
layout: tutorial

summary: The following document is designed to provide an overview of the best practices for receipt generation for eCommerce and Mail Order/Telephone Order (MOTO) transactions. 

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: false
    header_active: guides
---

# Receipt Integration Guide 

# Introduction
The following document is designed to provide an overview of the best practices for receipt generation for eCommerce and Mail Order/Telephone Order (MOTO) transactions. The intention is to ensure that there is clarity on the brand requirements, federal law requirements, and recommended best practices.

## Intended audience
This guide is intended for internal staff and eCommerce or web application developers to provide the elements that need to be present on receipts for all markets.
This guide does not provide all technical or business requirements for development and payment acceptance. Instead, this guide is a tool for developers that provides receipt requirements for eCommerce applications in North America Marketplace.

## Common Receipt Requirements
eCommerce application development vendors must incorporate certain receipt data elements but may modify the layout to be consistent with their current receipt layout (unless otherwise noted in these requirements). See the table below for the required fields across the different receipt types.

| Requirement                                                                                                                 	| eCommerce Cardholder copy 	| eCommerce Merchant copy 	| MO/TO Cardholder copy 	| MO/TO Merchant copy 	|
|-----------------------------------------------------------------------------------------------------------------------------	|:-------------------------:	|:-----------------------:	|:---------------------:	|:-------------------:	|
| Merchant DBA (card acceptor) name, most recognizable to consumers may be:<ul><li>DBA name as used on your website</li><li>Merchant URL or name used in clearing file</li></ul>                                                                                                                        	|              X            	|             X           	|            X          	|           X         	|
|     Merchant DBA (card acceptor) location. Must match   location (city, state, province, country) sent in clearing file.    	|              X            	|             X           	|            X          	|           X         	|
|     Merchant location code                                                                                                  	|              X            	|             X           	|            X          	|           X         	|
|     Transaction amount                                                                                                      	|              X            	|             X           	|            X          	|           X         	|
|     Transaction   currency                                                                                                  	|              X            	|             X           	|            X          	|           X         	|
|     Transaction   date                                                                                                      	|              X            	|             X           	|            X          	|           X         	|
|     Account number                                                                                                          	|              X            	|             X           	|                       	|                     	|
|     Truncated   account number                                                                                              	|              X            	|             X           	|            X          	|           X         	|
|     Truncated   expiration date                                                                                             	|                           	|             X           	|            X          	|           X         	|
|     Card brand                                                                                                              	|              X            	|                         	|                       	|                     	|
|     Unique   transaction identification number                                                                              	|              X            	|             X           	|            X          	|           X         	|
|     Cardholder   (purchaser) name                                                                                           	|              X            	|             X           	|            X          	|           X         	|
|     Authorization   code                                                                                                    	|              X            	|             X           	|            X          	|           X         	|
|     Transaction   type                                                                                                      	|              X            	|             X           	|            X          	|           X         	|
|     Description   of the merchandise or service                                                                             	|              X            	|             X           	|            X          	|           X         	|
|     AVS result   code                                                                                                       	|              X            	|             X           	|            X          	|           X         	|
|     Ship to   address                                                                                                       	|              X            	|             X           	|            X          	|           X         	|
|     Cancellation   policy                                                                                                   	|              X            	|                         	|            X          	|                     	|
|     Price of the   goods or services                                                                                        	|              X            	|             X           	|            X          	|           X         	|
|     Customer   service contact information                                                                                  	|              X            	|                         	|            X          	|                     	|
|     Merchant online address                                                                                                 	|              X            	|             X           	|            X          	|           X         	|
| Merchant must write the following letters or words on the signature line of the transaction receipt:<ul><li>TO (Telephone order)</li><li>MO (Mail order)</li><li>Recurring transaction</li></ul>                                                                                                                        	|                           	|                         	|            X          	|           X         	|


### Retrieving required fields
For a transaction request example and how to retrieve these fields, please see [Receipt Field Breakdowns and Retrieval](#receipt-field-breakdowns-and-retrieval).  
Ensure you are properly authenticated with the Bambora service and create a payment transaction request using the REST API service. For more information on using the Bambora Payment API, see [the developer documentation](/docs/references/payment_APIs/v1-0-5).

## Conditionally required fields 
The table below defines the fields that can be provided on a receipt under certain conditions

| Requirement                                                                                                                                                                                              	| eCommerce Cardholder copy 	| eCommerce Merchant copy 	| MO/TO Cardholder copy 	| MO/TO Merchant copy 	|
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|:-------------------------:	|:-----------------------:	|:---------------------:	|:-------------------:	|
|     If the merchant return policy is restricted, the   return policy MUST be   printed and located in close proximity to the cardholder signature on mail   order form.                                  	|     X                     	|                         	|     X                 	|                     	|
|     If the terms   and conditions of the sale are restricted, the terms MUST be printed and   located in close proximity to the cardholder signature on mail order form.                                 	|     X                     	|                         	|     X                 	|                     	|
|     If a free   trial period is offered, the exact date it ends MUST be printed and located   in close proximity to the cardholder signature on mail order form.                                         	|     X                     	|                         	|                       	|     X               	|
|     If the transaction undergoes Dynamic Currency   Conversion (DCC), then additional   information MUST be printed on cardholder and merchant copies. Global   Payments does not offer DCC services.    	|     X                     	|     X                   	|     X                 	|     X               	|
|     The   transaction receipt for recurring electronic commerce transactions must   include the frequency and duration of the recurring transactions as agreed to   by the cardholder.                   	|     X                     	|     X                   	|                       	|                     	|

## Optional fields
The table below defines the fields the optional receipt fields. Although not required, including the information below may reduce chargebacks in certain instances. 

| Requirement                                                                                            	| eCommerce Cardholder copy 	| eCommerce Merchant copy 	| MO/TO Cardholder copy 	| MO/TO Merchant copy 	|
|--------------------------------------------------------------------------------------------------------	|:-------------------------:	|:-----------------------:	|:---------------------:	|:-------------------:	|
|     Merchant phone number                                                                              	|              X            	|                         	|            X          	|                     	|
|     Transaction   time                                                                                 	|                           	|             X           	|                       	|           X         	|
|     Customer   email address                                                                           	|                           	|             X           	|                       	|           X         	|
|     Customer   telephone number                                                                        	|                           	|             X           	|                       	|           X         	|
|     Customer   billing address                                                                         	|                           	|             X           	|                       	|           X         	|
|     Detailed   description of goods or service                                                         	|                           	|             X           	|                       	|           X         	|
|     Receipt   signature obtained upon delivery of goods or services                                    	|                           	|             X           	|                       	|           X         	|
|     Cardholder authentication result code may be   printed. Displaying CID/CVV2/CVC2 is prohibited.    	|                           	|             X           	|                       	|           X         	|
|     Cardholder   billing address and postal code (if different from the SHIP TO address).              	|              X            	|             X           	|            X          	|           X         	|

## Standard Receipt Template 
The template below represents the standard receipt for all transactions, with all possible fields allocated to their desired position on the receipt. 
<img src="/docs/guides/receipt_guide/StandardReceiptTemplate.png" alt="StandardReceiptTemplate.png">

# Receipt Field Breakdowns and Retrieval

## Credit Sale (Purchase)
The Sale transaction, also sometimes referred to as Purchase transaction, is the most basic and most common transaction used for the purchase of goods or services. In a sale, the authorizing agent's system compares the cardholder's credit limit to the amount specified in the sale transaction. If the amount is available, the card issuer transmits an approval code. If the amount is not available, then a decline is received from the card issuer.  
To receive the fields listed in the Section 1 tables above, see the transaction example below.

## Example 1: Successful Payment

### Request	
Make a payment using credit card, cash, check, profile, token, Apple Pay or Android Pay. Each payment type has its own json definition passed in the body. For all payments you have the standard Billing, Shipping, Comments, etc. fields that are optional. 

|     Field                 	|     Type       	|     Description                                                                                                                                                                                                                                                                                             	|
|---------------------------	|----------------	|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
|     order_number          	|     string     	|     A unique order number                                                                                                                                                                                                                                                                                   	|
|     amount                	|     number     	|     A decimal value in dollars. Uses up to two decimal places. Max value   is account specific. Default max value is 1000.                                                                                                                                                                                  	|
|     payment_method        	|     string     	|     The desired method of payment. Available inputs include: Credit Card   - "card", Payment Profile - "payment_profile", Single Use Token - "token", Cash - "cash", Cheque -   "cheque", Interac - "interac", Apple Pay -   "apple_pay", Android Pay - "android_pay".                                        	|
|     language              	|     string     	|     Three-character input for default language                                                                                                                                                                                                                                                              	|
|     customer_ip           	|     string     	|     IP Address of the api consumer. Required if calculating risk score.                                                                                                                                                                                                                                     	|
|     term_url              	|     string     	|     Callback URL used with 3D Secure payment processing.                                                                                                                                                                                                                                                    	|
|     comments              	|     string     	|     Alphanumeric comment to accompany transaction.                                                                                                                                                                                                                                                          	|
|     billing               	|     object     	|     Billing address of the customer.                                                                                                                                                                                                                                                                        	|
|     shipping              	|     object     	|     Shipping address of the customer.                                                                                                                                                                                                                                                                       	|
|     custom                	|     object     	|     Custom reference fields for any additional information to include,   such as transaction_id, notes, etc.                                                                                                                                                                                                	|
|     card                  	|     object     	|     Credit card information. The payment_method must be 'card' if using   this field.                                                                                                                                                                                                                       	|
|     recurring_payment     	|     boolean    	|     A recurring transaction is a transaction where a cardholder had   provided permission to a merchant to periodically charge his/her account   number for recurring goods or services. The recurring payment indicator may   be set for credit card based pre-auth, capture and purchase transactions.    	|
|     level2                	|     object     	|     Level 2 processing is for B2B customers. Additional information can   be provided, to the benefit of corporate/government/industrial customers,   that includes a customer code & tax amounts.                                                                                                          	|
|     card_on_file          	|     object     	|     When processing a transaction where the credit card information is   stored on file, you must pass along an indicator showing the type of   credential-on-file transaction that is being processed.                                                                                                     	|

Request


```javascript
{
    "order_number": "000011",
    "amount": 5.01,
    "payment_method": "card",
    "card": {
        "name": "Test User",
        "number": "4030000010001234",
        "expiry_month": "12",
        "expiry_year": "25",
        "cvd": 123
    },
    "shipping": {
    	"name" : "Test User",
		"address_line1" : "123 Victoria St",
		"city" : "Victoria",
		"province" : "BC",
		"country" : "CA",
		"postal_code" : "30329",
		"phone_number" : "1-250-222-3333"
    },
     "billing": {
    	"name" : "Test User",
		"address_line1" : "123 Victoria St",
		"city" : "Victoria",
		"province" : "BC",
		"country" : "CA",
		"postal_code" : "30329",
		"phone_number" : "1-250-222-3333"
    },
    "custom": {
    	"ref1":"Test"
    }
}
```

### Response
If successful, you should receive a payment response with the HTTP code 200: success. The response definition is returned as outlined below:

|     Field                                  	|     Type       	|     Description                                                                                                                                                                                            	|
|--------------------------------------------	|----------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
|     id                                     	|     string     	|     Transaction ID                                                                                                                                                                                         	|
|     authorizing_merchant_id                	|     integer    	|     The id of the merchant that authorized the transaction.                                                                                                                                                	|
|     approved                               	|     integer    	|     Approval status of payment transaction. 0 if the transaction is not   approved. 1 if the transaction is approved.                                                                                      	|
|     message_id                             	|     integer    	|     Payment response code.                                                                                                                                                                                 	|
|     message                                	|     string     	|     Message containing information about the transactions status.                                                                                                                                          	|
|     auth_code                              	|     string     	|     Authorization code.                                                                                                                                                                                    	|
|     created                                	|     string     	|     Time stamp of when the transaction occurred                                                                                                                                                            	|
|     order_number                           	|     string     	|     Order number.                                                                                                                                                                                          	|
|     type                                   	|     string     	|     Payment transaction type                                                                                                                                                                               	|
|     amount                                 	|     number     	|     A decimal value in dollars. Uses up to two decimal places.                                                                                                                                             	|
|     payment_method                         	|     string     	|     Payment method                                                                                                                                                                                         	|
|     custom                                 	|     object     	|     Custom reference fields for any additional information to include,   such as transaction_id, notes, etc.                                                                                               	|
|     card                                   	|     object     	|     Credit card information. The payment_method must be 'card' if using   this field.                                                                                                                      	|
|     links                                  	|     array      	|     Related links provided for the transaction.                                                                                                                                                            	|
|     card_on_file                           	|     object     	|     When processing a transaction where the credit card information is   stored on file, you must pass along an indicator showing the type of   credential-on-file transaction that is being processed.    	|

Response

```javascript
{
    "id": "10001756",
    "authorizing_merchant_id": 353880000,
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "TEST",
    "created": "2021-07-07T10:18:34",
    "order_number": "OrderNumberExample1234",
    "type": "P",
    "payment_method": "CC",
    "risk_score": 0.1,
    "amount": 99.99,
    "custom": {
        "ref1": "",
        "ref2": "",
        "ref3": "",
        "ref4": "",
        "ref5": ""
    },
    "card": {
        "card_type": "VI",
        "last_four": "1234",
        "address_match": 0,
        "postal_result": 0,
        "avs_result": "0",
        "cvd_result": "5",
        "eci": 7,
        "avs": {
            "id": "U",
            "message": "Address information is unavailable.",
            "processed": false
        }
    }
}
```

## Glossary

|      Field Name                              	|      Required       	|      Min/Max length     	|      Description                                                                                                                                                                                               	|
|----------------------------------------------	|---------------------	|-------------------------	|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
|     Account number                           	|     If   present    	|     1-4                 	|     The PAN (Primary Account Number)   Sequence number identifies and differentiates cards with the same PAN.                                                                                                  	|
|     Authorization Code                       	|     Always          	|     6-6                 	|     Authorization code                                                                                                                                                                                         	|
|     AVS Result code                          	|     If   present    	|     1-1                 	|     Returns if the AVS input was an exact   match                                                                                                                                                              	|
|     Card Brand                               	|     Always          	|     N/A                 	|     Logo of the card issuer                                                                                                                                                                                    	|
|     Cardholder Name                          	|     If   present    	|     N/A                 	|     The cardholder name will be shown if   available. For some readers this information will not be available and will   not be displayed on the receipt.                                                      	|
|     Entry Mode                               	|     Always          	|     4-16                	|     Valid values: "Chip Read",   "Mag Stripe", "Manual"                                                                                                                                                        	|
|     Merchant DBA location (DBA   Address)    	|     Always          	|     0-64                	|     Shows the merchant’s address based on the   DBA address on file.                                                                                                                                           	|
|     Merchant Email Address                   	|     If   present    	|     0-32                	|     Show’s the merchant’s email address if   they have one on file.                                                                                                                                            	|
|     Merchant Name (DBA Name)                 	|     Always          	|     0-32                	|     These field is entered by the client   during boarding. Depending on the configuration set up by the client, the   merchant may or may not be able to modify these from ROAMmerchant.                      	|
|     Merchant Phone Number                    	|     Always          	|     0-15                	|     Contact number for the merchant. This   can be set up in ROAMmerchant’s Edit   Email Receipt page.                                                                                                         	|
|     Merchant/Customer Copy                   	|     Always          	|     N/A                 	|     The text "Merchant Copy" and   "Customer Copy" shall appear at the bottom of the receipt. If   customer copy is displayed, the text "IMPORTANT - retain this copy for   your records" must also appear.    	|
|     Ship to address                          	|     Always          	|     0-64                	|     Shows the customer’s address used for   shipping at time of checkout.                                                                                                                                      	|
|     Social Media Icons for Merchant          	|     If   present    	|     N/A                 	|     Available spot to show Facebook,   Twitter, Web icons/logos.                                                                                                                                               	|
|     Subtotal                                 	|     Always          	|     N/A                 	|     Subtotal of the transaction.                                                                                                                                                                               	|
|     Tax                                      	|     Always          	|     N/A                 	|     Total tax added to the transaction.   Tax and tax percentage can be edited/toggled in the RoamPayX settings.                                                                                               	|
|     TCC                                      	|     If   present    	|     4-4                 	|     Indicates the country of the terminal,   represented according to ISO 3166.                                                                                                                                	|
|     TID                                      	|     If   present    	|     1-15                	|     A unique identifier that designates the unique location of a Terminal at a merchant.                                                                                                                       	|
|     Tip                                      	|     If   present    	|     N/A                 	|     Optional tip added to the transaction   by the customer. This can be toggled on in the RoamPayX settings.                                                                                                  	|
|     Total                                    	|     Always          	|     N/A                 	|     Total amount of the transaction,   including any tax, tips or discounts.                                                                                                                                   	|
|     Transaction amount                       	|     Always          	|     N/A                 	|     The finalized amount of the sale                                                                                                                                                                           	|
|     Transaction currency                     	|     Always          	|     3-3                 	|     Code of the currency that was used at   the time of the transaction. Default is USD.                                                                                                                       	|
|     Transaction date                         	|     Always          	|     14-14               	|     Local device time zone, used to   display the time that the transaction took place.                                                                                                                        	|
|     Transaction ID                           	|     Always          	|     6-6                 	|     Generated transaction ID.                                                                                                                                                                                  	|
|     Transaction Message                      	|     Always          	|     N/A                 	|     Approval/Decline on the transaction.                                                                                                                                                                       	|
|     Transaction Note                         	|     If   present    	|     N/A                 	|     Optional note to provide more   information about a given transaction.                                                                                                                                     	|
|     Transaction type                         	|     Always          	|     N/A                 	|     Type of payment used at the point of   sale (e.g. "Credit", "Debit", "Cash").                                                                                                                              	|