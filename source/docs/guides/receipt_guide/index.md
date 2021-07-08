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
The following document is designed to provide an overview of the best practices for receipt generation for eCommerce and Mail Order/Telephone Order (MOTO) transactions. The intention is to ensure that there is clarity on the brand requirements, federal law requirements, and Global Payments’ recommended best practices.

## Intended audience
This guide is intended for internal staff and eCommerce or web application developers to provide the elements that need to be present on receipts for all markets.
This guide does not provide all technical or business requirements for development and payment acceptance. Instead, this guide is a tool for developers that provides receipt requirements for eCommerce applications in the U.S. Marketplace.

## Common Receipt Requirements
eCommerce application development vendors must incorporate certain receipt data elements but may modify the layout to be consistent with their current receipt layout (unless otherwise noted in these requirements). See the table below for the required fields across the different receipt types.


<TODO> add table
|Requirement | eCommerce-Cardholder copy | eCommerce-Merchant copy| MO/TO-Cardholder copy | MO/TO-Merchant copy |
|------------|---------------------------|------------------------|-----------------------|---------------------|


### Retrieving required fields
For a transaction request example and how to retrieve these fields, please see <TODO> Section_2 Receipt Field Breakdowns & Retrieval.  
Ensure you are properly authenticated with the Bambora service and create a payment transaction request using the REST API service. For more information on using the Bambora Payment API, see <TODO> the developer documentation.

## Conditionally required fields 
The table below defines the fields that can be provided on a receipt under certain conditions
<TODO> add table
|Requirement | eCommerce-Cardholder copy | eCommerce-Merchant copy| MO/TO-Cardholder copy | MO/TO-Merchant copy |
|------------|---------------------------|------------------------|-----------------------|---------------------|

## Optional fields
The table below defines the fields the optional receipt fields. Although not required, including the information below may reduce chargebacks in certain instances. 

<TODO> Add table
|Requirement | eCommerce-Cardholder copy | eCommerce-Merchant copy| MO/TO-Cardholder copy | MO/TO-Merchant copy |
|------------|---------------------------|------------------------|-----------------------|---------------------|

## Standard Receipt Template 
The template below represents the standard receipt for all transactions, with all possible fields allocated to their desired position on the receipt. 

<TODO> Add screenshots

# Receipt Field Breakdowns & Retrieval

## Credit Sale (Purchase)
The Sale transaction, also sometimes referred to as Purchase transaction, is the most basic and most common transaction used for the purchase of goods or services. In a sale, the authorizing agent's system compares the cardholder's credit limit to the amount specified in the sale transaction. If the amount is available, the card issuer transmits an approval code. If the amount is not available, then a decline is received from the card issuer.  
To receive the fields listed in the Section 1 tables above, see the transaction example below.

## Example 1: Successful Payment

### Request	
Make a payment using credit card, cash, check, profile, token, Apple Pay or Android Pay. Each payment type has its own json definition passed in the body. For all payments you have the standard Billing, Shipping, Comments, etc. fields that are optional. 

<TODO> Add table

|Field       | Type    | Description                                | 
|------------|---------|--------------------------------------------|

<TODO> add Request screenshot

### Response
If successful, you should receive a payment response with the HTTP code 200: success. The response definition is returned as outlined below:

<TODO> Add table

|Field       | Type    | Description                                | 
|------------|---------|--------------------------------------------|

<TODO> add Response screenshot

## Glossary
<TODO> Add table

| Field Name	| Required	| Min/Max length | Description |
|---------------|-----------|----------------|-------------|
