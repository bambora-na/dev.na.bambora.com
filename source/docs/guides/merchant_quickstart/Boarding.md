---
title: Go live
layout: tutorial

summary: >
  Learn how to create, configure, and test your merchant account with our Payment APIs.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.merchant_quickstart
  header_active: Guides

---

# Go live

After you've signed up for a Merchant Account, we require a few pieces of information before your account is able to process payments.

If you haven't signed up yet, phone our Sales Team at 1 (888) 472-2072, or you can [request a call](http://www.bambora.com/en/ca/contact/sales/).

> Our Onboarding Team will guide you through each important step. If you have any questions, feel free to email them at [applications.northamerica@bambora.com](mailto:applications.northamerica@bambora.com).

## Approving  applications

After we receive your application, our Onboarding Team will review it and the accompanying paperwork within one or two business days. If we reach out to you because something is incomplete or missing, you should follow up as quickly as possible to avoid delays.

If you're exclusively using a website for payments, we will also review the website during the approval process to ensure you meet website requirements.

#### PCI questionnaires

Before your application is processed, you'll complete one of two self-assessment questionnaires about your ability to meet PCI standards.

**Self-Assessment 1**

This questionnaire is aimed at any merchant using a solution that has all payment pages hosted on a fully compliant service provider such as Bambora Checkout. If your third-party shopping cart is PCI Certified, you'll focus on this questionnaire.

[PCI Questionnaire A](https://cdn.na.bambora.com/downloads/SAQs/SAQ_A_v3_prefill.pdf)

**Self-Assessment 2**

Any merchant using a fully integrated API will complete this comprehensive questionnaire. If you create your own shopping cart using our API or Simple Object Access Protocol (SOAP), you, your developer, as well as your host will need to complete this questionnaire.

[PCI Questionnaire D](https://cdn.na.bambora.com/downloads/SAQs/SAQ_D_v3_Merchant.pdf)

#### Website requirements

If you're selling online, your goods or services require a clear description, along with information about their price. If your customer clearly understands what they're purchasing, there's less chance for a customer dispute or chargeback.

Because of requirements from Bambora and its banking partners, you're required to clearly display the following pieces of information on your site:

 - Legal business name, or Doing Business As name (DBA) clearly and frequently.
 - Contact information for customer service, including business address and/or mailing address, telephone number, and email address.
 - An accurate and complete description of services or goods, including technical and system specifications, or individual cost.
 - A clear outline of your delivery policy, including method and delivery date for goods or services. This also includes costs, fees, and taxes related to shipping, delivering, handling, customs, duties, brokerage, and insurance. It's a good idea to also include any export restrictions that may apply.
 - Your full return, exchange, and refund policies.
 - Transaction currency for all purchases, in either Canadian or American prices.
 - The terms and conditions of the use for your website.
 - The Card Brand Mark in full colour, informing the customer of card acceptance including terms and conditions, as well as the method of payment.
 > **Card Brand Marks**<br>[Visa Merchant Services](https://www.visa.ca/en_CA/run-your-business/commercial-solutions/merchant-processing.html)<br>[MasterCard Brand Center](https://brand.mastercard.com/brandcenter/mastercard-brand-mark.html)<br>[Discover Signage and Logos](https://www.discovernetwork.com/en-us/business-resources/free-signage-logos)<br>[American Express Signs & Supplies](https://merchant-supplies.americanexpress.com/?locale=en_US#/)</br>

After we've confirmed this information is readily available on your website, we can start work on issuing your Merchant Account. If you have questions about any of these requirements, or need more detail on making them available, contact our [Customer Experience Team](https://www.bambora.com/en/ca/contact/support/).

## Terminal accounts

If you've already got a Merchant Account through a bank or credit union, you'll be able to connect your previous account as a Terminal Account. We'll need a few specific details about those accounts so we can connect you to the Bambora gateway, this list of account providers below outlines the necessary details.

[Chase Paymentech](#chase-paymentech)
<br>[First Data](#first-data)
<br>[Global Payments](#global-payments)
<br>[Royal Bank of Canada (RBC), Scotiabank, Desjardins, Moneris, and Canadian Credit Unions](#royscomondesoth)
<br>[TSYS](#tsys)
<br>[Toronto Dominion (TD)](#td)

<a name="chase-paymentech"></a>

#### Chase Paymentech
If you're using Chase Paymentech, ensure that your accounts are set up on the **NetConnect** platform. If you don't already have one, request a VARS setup sheet from your Chase account representative with:

 - 4-digit client number.
 - 12-digit PNS merchant number.
 - 3-digit terminal number.
 - NetConnect user ID.
 - NetConnect password.
 - Merchant numbers for each accepted card type.


<a name="first-data"></a>

#### First Data
To use your **Canadian** First Data accounts, they'll need to be located on the **Nashville South** platform. **American** accounts need to be on **Nashville North**. If you don't already have one, request a setup sheet with:

 - 6 to 8-digit terminal number.
 - 7-digit Merchant ID.
 - Merchant Category Code (MCC).
 - Merchant ZIP or postal code.
 - Dedicated customer service phone number.
 - Website URL.
 - Merchant numbers for each accepted card type.

<a name="global-payments"></a>

#### Global Payments
If you're using Global Payments, ensure that your accounts are set up on the **Global: Atlanta East** platform. You'll also need to make sure that Bambora is the software provider for your account. If you don't already have one, request a terminal setup sheet with:

 - 11-digit terminal ID.
 - 6-digit BIN number.
 - Software provider is set to Bambora.
 - Merchant numbers for each accepted card type.

<a name="royscomondesoth"></a>

#### Royal Bank, Scotiabank, Desjardins, Moneris, and other Canadian credit unions
If you're currently using any of these banks or credit unions, you need to provide your 5 to 12-digit Merchant ID, and confirm with your bank or union that these ID's are set up for use through a third-party provider.

<a name="tsys"></a>

#### TSYS
If you don't already have one, request a terminal setup sheet from your TYSYS account representative with your:

 - 12-digit merchant number.
 - 6-digit BIN number.
 - 6-digit agent bank number.
 - 6-digit agent chain number.
 - 4-digit store number.
 - 4-digit terminal number.
 - Merchant Category Code (MCC).
 - Terminal ID.
 - Registered country.
 - Merchant name.
 - Province or State.
 - ZIP or postal code.
 - Customer service phone number.
 - Time zone.
 - Merchant numbers for each accepted card type.

<a name="td"></a>

#### TD (Toronto Dominion)
You need to ensure that your TD merchant accounts are tied to a Bambora terminal. You'll also need a terminal setup sheet from your account representative if you don't already have one with:

 - Merchant numbers for each accepted card type.

## Integrating
You can begin to test your system's integration using [these test cards](http://support.na.bambora.com/olm/w/docs/using-test-card-numbers.htm) in your sandbox environment. Each currency requires its own Merchant ID, so if you intend on accepting multiple currencies, you will need to create a new integration for each one.

After integration tests are complete, as well as your terminal and merchant accounts are confirmed, we'll send you an email to the address you provided, authorizing you to go live.

> We recommend that you review our guide to [Security and Risk Management](https://support.na.bambora.com/bic/w/index.html#docs/security-risk-management.htm) for enhanced security featuresand best practices.

## Going live

Once you or your developer finish testing, send us an email requesting to go live, and we will make it so. You'll move from the test environment to live on production.

We'll perform a review of your website to ensure everything is running smoothly. If we detect any issues or problems, we'll send you an email concerning your site review.

> Test transactions will remain free of charge, but monthly processing fees will start after your account is approved and authorized.

### More information
If you're looking for more information about using Bambora, you can look through our [Quickstart Guide](http://support.na.bambora.com/bic/w/index.html#docs/online-help-area-quickstart-information.htm) for helpful hints, how-to's, and all things Bambora.
