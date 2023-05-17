---
title: Quickstart Onboarding
layout: tutorial

summary: >
    A guide for Partners to integrate directly to the Onboarding API so they can build their own user interface as
    an alternative to using the Bambora hosted screens, a user interface for onboarding merchants.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Onboarding

This guide is for Partners building an onboarding integration with custom user
interface (UI) to upload merchant applications and manage documentation.

If you're interested in a hosted solution for onboarding, contact your Account Manager.

## Getting started

To get a custom UI using our Onboarding API, you'll need to construct an
environment that integrates our sandbox, and have it approved by our Onboarding
Team.

To begin, make sure you're [signed up for a partner
account](/docs/forms/create_test_merchant_account/). After you're accepted, we'll
email you an API access token for our sandbox environment along with a Pricing
Package ID.

> Your test Pricing Package ID will set the rates for customers that begin processing.

Once you have your account and pricing ID, you'll be ready to start building
your environments. To help with your integration you can review our [Onboarding
API References](/docs/references/onboarding_API).

### Testing environments

Using the API access token provided by your Account Manager, you can start building your integration.

#### Sandbox

The sandbox you have access to will be a direct clone of the Production
environment, and allows you to test the workflow of Onboarding.

> This sandbox is currently limited to Onboarding and does not include test payments.

All API calls to the sandbox are made through the following URL:

<https://sandbox-api.na.bambora.com/>

If an application is created using the [PSP-CAD flow](#flow), a request to **GET** it would look like:

<https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId}>

As an application moves through the Onboarding process, it will be in multiple states:

| State | Description |
| ------ | ----------- |
| `in_progress` | Any application created, but missing information in required fields. |
| `in_review` | Any application that is complete, but has not been approved or rejected. Applications in review cannot be updated or changed. |
| `on_hold` | Any application that is held from approval or rejection by a member of the Bambora Onboarding Team. |
| `approved` | Any complete application that is approved to begin processing.
| `rejected` | Any complete application that fails to meet approval criteria. |

 > An application that is `rejected` cannot be reviewed further, and must be re-submitted as a new application.

To test the transition between states in the sandbox environment, you can enter
a magic string in the `company_name` field on a POST or PUT request.

- TEST_APPROVED - Move the application from `in_progress` to `approved`.
- TEST_REJECTED -  Move the application from `in_progress` to `rejected`.

#### Integration review

Once you've completed all of your integration testing, contact your Account Manager to begin the review.

Most reviews take no longer than a single business day, and ensure that your integration is:

- Submitting complete and correct forms.
- Correctly displaying or linking to Terms and Conditions.
- Correctly displaying or linking to card processing prices.

#### Production

After your integration is approved, you'll be provided with a Production API key
for your Production environment. Other than your magic string no longer working,
the two environments will be identical.

All API calls to production are made through the following URL:

<https://api.na.bambora.com/>

If an application is created using the [PSP-CAD flow](#flow), a request to **GET** it would look like:

<https://api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId}>

## API requests

### Request headers

When you make an HTTP request to the API, headers are required for both authentication, and the API version.

#### Authentication

Every request that is made to the Onboarding and Payments API requires an API access token, and can be included in the header:

`Authorization: Bearer YOUR_TOKEN_HERE`

#### API version

You can find a list of our Onboarding API versions
[here](/docs/references/onboarding_API/). Any new integrations require the most
recent version.

Add the version number to the Header of your API request:

`X-API-Version: 2016-08-18`

If the API is updated, or a new one is introduced, it will appear in the
[Changelog](/docs/references/onboarding_API/). If an API is ever deprecated,
you'll be notified via email well in advance with assistance in updating.

<a name="flow"></a>

### Select a flow

All endpoints in the Onboarding API are organized based on the functionality being requested. We call these, 'flows'.

All flows support the creation, reading, and updating of applications, as well
as requesting Terms and Conditions. Some flows also support creating and reading
of documents attached to applications.

Each application can only be associated with a single flow. If a Merchant wants
to work through multiple flows to accept multiple currencies, for example,
they'll need to submit an application for each flow.

#### Fund transfer

Fund transfer flow is used for financial transactions between institutions such
as banks completing direct deposit, payroll, and batched transactions. Accounts
using a fund transfer flow are locked to the specified region.

| Flow | Description |
| ---- | ----------- |
| SEPA-EUR | Single Euro Payments in Europe. |
| BACS-GBP | Bankers Automated Clearing Service and Payment Schemes Limited in the United Kingdom. |
| ACH-USD | Automated Clearing House in the United States of America. |
| EFT-CAD | Electronic Funds Transfer in Canada. |

#### Card payments

Used for processing payment transactions including credit cards. Accounts using
a card payments flow are locked to the specified region.

| Flow | Description |
| ---- | ----------- |
| PSP-CAD | Payment Service Providers in Canada. |
| PSP-USD | Payment Service Providers in the United States of America. |

#### Gateway

A flow for any Merchant Account held with another acquirer, the gateway flow allows transactions like the card payments flow.

| Flow | Description |
| ---- | ----------- |
| GW-CDN | Gateway Services in Canada. |
| GW-USA | Gateway Services in the United States of America. |

You can find a complete list of flows in our [Onboarding API
References](/docs/references/onboarding_API), with the most recent version of
the API specs [here](/docs/references/onboarding_API/v2016-08-18), and Terms and
Conditions [here](/docs/references/onboarding_API/tac_v2016-08-18).

## Sample integration calls

As we run through all of the parts of an integration call, we'll be referring to the [PSP-CAD Card payments flow](#flow).

### Terms and Conditions

In your UI, Bambora's Terms and Conditions must be linked to or displayed. Our
API requires that you clearly specify the version of the terms, the pricing or
rate, as well as the date and time when they are agreed to. This ensures that
the merchant is aware of processing fees and their cost. If you require custom
Terms and Conditions, you can reach out to your Account Manager to learn more.

Standard Terms and Conditions are acquired through a **GET**, and can be requested as either a PDF or HTML.

`/v1/boarding/workflows/psp-cad/terms/{partner}/{file_type}/version`

In the example below, the call is being made for the Terms as HTML. For default Terms, set the `partner` value to `default`.

> With Terms and Conditions calls, the version and authorization header are optional

To begin the two-step call, execute the following cURL command.

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/terms/default/html/version \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE"
```

A JSON object will be returned.

```json
{
  "version": "o5xq2r8JtnqYUWr1mURrOEZVXyx_fihe",
  "name": "psp-cad/default/html/2017-04-03_21:25:10"
}
```

Next, extract the `version` for your second call.

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/terms/default/html/version/o5xq2r8JtnqYUWr1mURrOEZVXyx_fihe \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE"
```

This second API call will return a raw HTML or PDF of the Terms and Conditions.

> During the review process of your interface and integration, the Onboarding
> Team will ensure you're displaying the Terms and Pricing correctly.

### Creating an application

When you create an application, you'll need to include the first JSON `version`,
and `name` call references from the Terms, not the name from the header of the
second call.

To create a new application, you'll **POST** using `/v1/boarding/workflows/psp-cad/applications`

While there are no required fields to make an HTTP request, [fields highlighted
by a red asterisk](/docs/references/onboarding_API) are required to move an
application to the `in_review` state. The sample below has all of the required
fields for a PSP-CAD application. In the testing sandbox, this application would
be moved to `approved`.

Execute the following cURL request by adding your version, authorization header,
and pricing package ID, and the [required application
fields](/docs/references/onboarding_API).

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{
    "pricing_id": "123_YOUR_ID_123",
    "applicant": {
      "first_name": "Jane",
      "last_name": "Doe",
      "date_of_birth": "1988-03-25T22:00:00.00000Z",
      "phone_number": "222-222-2222",
      "email": "test@example.com",
      "agreement": {
        "name": "psp-cad/default/html/2017-04-03_21:25:10",
        "version": "o5xq2r8JtnqYUWr1mURrOEZVXyx_fihe",
        "timestamp": "2017-03-25T22:04:10.04399Z"
      },
      "address": {
        "address_line1": "123 Main Street",
        "city": "Victoria",
        "country":"CA"
      }
    },
    "business": {
      "company_name": "TEST_APPROVED",
      "annual_sales": 800000.00,
      "merchant_category": "5813",
      "entity_type": "partnership",
      "start_date": "2013-06-01T22:06:00.00000Z",
      "address": {
        "address_line1": "123 Main Street",
        "city": "Victoria",
        "country":"CA"
      },
      "bank_account": {
        "owner_name": "Jane Doe",
        "transit_number": "69877",
        "institution_number": "345",
        "account_number": "3453"
      }
    }
}'
```

> The `agreement` variables require the Terms and Conditions `version` and
> `name` from the first API call. All date and time variables are IS-8601 format
> `YYYY-MM-DDThh:mm:ssTZD`. For full dates that have no specific time, set the
> time to zeros.

### Reading an application

All submitted applications can be fetched through a **GET**.

`/v1/boarding/workflows/psp-cad/applications`

The application ID is returned in the initial POST request, and used to retrieve
the application. Using the cURL below, you'll add your authorization header,
version, and application ID.

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId} \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
```

After an application has reached the `approved` state, the Merchant ID in the
response will be used to process payments through your account.

> To find out if an application has been approved, use an HTTP GET with the application ID to request the application state.

### Updating an application

Any application currently in the `in_progress` state can be modified and updated using a **PUT**.

`/v1/boarding/workflows/psp-cad/applications/{applicationId}`

Using the application ID from the POST return, you'll be able to update information on an application.

If your update to an application is a single variable such as `phone_number`,
like in the cURL below, you can add just that data. Any fields not passed will
remain the way they were on creation.

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId} \
-X PUT \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{
      "applicant": {
      "phone_number": "222-867-5309"
      }
    }'
```

To remove a field from a previously submitted application, set the value of the field to an empty string or zero.

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId} \
-X PUT \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{
      "applicant": {
      "first_name": "",
      "last_name": ""
      }
    }'
```

### Uploading documentation

If you're using the SEPA-EUR, BACS-GBP, ACH-USD, EFT-CAD, or PSP-USD flows, you
can attach a document to an `in_progress` application. For this example, we'll
use the PSP-USD flow.

To upload documents, use **POST**.

`/v1/boarding/workflows/psp-usd/applications/{applicationId}/documents`

You'll use POST, GET, and DELETE for documents associated with an application.
Execute the following cURL with your version, authorization header, and
application ID to add a document.

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-usd/applications/{applicationId}/documents \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{
     "name": "bank_statement",
     "type": "pdf",
     "base64": "XXxx_PUT_BASE_64_ENCODED_STRING_OF_DOCUMENT_HERE_xxXX"
    }'
```

## Processing payments

Now that you're ready to begin processing payments, you can learn about
integrating with our [Payments API](/docs/references/payment_APIs). You can also
use our [Merchant Quickstart Guide](/docs/guides/merchant_quickstart) to get up
and running fast.
