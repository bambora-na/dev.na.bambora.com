---
title: Custom Commissions Report API Spec
layout: tutorial

summary: >
  API spec for our Custom Commissions Report API.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: References

---

# Custom Commissions Report API

This document lists and describes the properties expected in the request and response objects.

- **URL** - <https://na.bambora.com/scripts/reporting/report.aspx>
- **Method** - POST

## Request

The API expects an XML document in the body of the request. The XML declaration should identify the version as "1.0" and
the encoding as "UTF-8".

```
<?xml version="1.0" encoding="UTF-8"?>
```

The API requires the XML document to include `merchantId` and `passCode` elements for authorization, and `serviceName` and `rptFormat` elements to identify the format of report to be returned. All other supported elements are filters to constrain the results in the report.

Filters are assembled as in groups containing a column name (`rptFilterBy`), and a value (`rptFilterValue`). The API requires the XML document to include both, if any one is included.

### Elements

- **merchantId** - The authorizing partner ID. Length: 9 chars. [Numeric string]
- **passCode** - The reporting passcode for the authorizing merchant. Max length: 64 chars. [Alphanumeric string]
- **serviceName** - Type of report
  - **custom_commissions_payout**
- **rptFormat** - Format of the response, valid values are
  - **JSON**
  - **XML**
- **rptVersion** - API version. Current version: "1.0" [Numeric String]
- **rptFilterBy**
  - **status** - Status of a custom commissions payout record.
- **rptFilterValue** - Valid values for 'status' filter are (case insensitive)
  - **Scheduled**
  - **On Hold**
  - **Superseded**
  - **In Process**
  - **Approved**
  - **Declined**
  - **Pending Payment**
  - **Full Payment**
- **rptDays** - The number of days from today to look at history.
- **rptFromDateTime** - Start date and time that custom commissions payout calculation happened.
- **rptToDateTime** - End date and time that custom commissions payout calculation happened.
- **rptStartRow** - The first row number in the result set.
- **rptEndRow** - The last row number in the result set.
- **camelCase** - Default is true. If set to false, snake case will be used for response fields.

## Response

The format of the response object is relative to `rptFormat` element in the request in either JSON or XML formats.

JSON and XML response object contains a "code" property indicating the success of the request. This will be a number between 1 and 8, inclusive, where "1" indicates success. It also has a message property with a description of the code.

- Code: "**1**", Message:	"Report Generated"
- Code: "**2**", Message:	"Unknown error"
- Code: "**3**", Message:	"Malformed xml request"
- Code: "**4**", Message:	"Unsupported content type"
- Code: "**5**", Message:	"Unsecure connection"
- Code: "**6**", Message:	"Data validation failed"
- Code: "**7**", Message:	"Authentication failed"
- Code: "**8**", Message:	"Authorization failed"

## Report Fields

This section documents the fields returned in response body.

- **payout_id** - Custom commission payout identifier. This is a unique value.
- **amount** - Amount of the custom commission payout record to settle in partner's account.
- **start_datetime** - Date and time since the previous payout is calculated or if there is no previous payout then when the custom commission service is first enabled.
- **end_datetime** - Date and time that the custom commission is calculated.
- **expected_settlement_date** - Date the custom commission payout is expected to settle.
- **statement_id** - Id of a statement that includes the custom commissions payout.
- **status** - Status of custom commissions payout record.