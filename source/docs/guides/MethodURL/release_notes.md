---
title: Method URL Release Notes
layout: tutorial

summary: >
  Release notes for Worldline Method URL.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.method_url
  header_active: References
---

# Method URL Release Notes

## 1.0.0

**February 11, 2025**

- First release of Worldline's Method URL JS library
- https://web.na.bambora.com/assets/emv3ds/1/methodurl.js
- Support for card number integration - The library supports the Method URL process for card number only.

## 2.0.0

**August 12 , 2025**

-	Second major release of Worldline's Method URL JS library
-	https://web.na.bambora.com/assets/emv3ds/2/methodurl.js
- This library version supports the following functionality:
  - Support for Payment Profile integration: The library's execute method contract has been reconstructed to support the Method URL process for saved payment profiles. The payment profile process is using a low level token without using customer code or profile ID.
  - Support for Waitforstatus: The library has introduced wait time functionality to help the merchant's checkout solution to wait until the Method URL process completes before actually submitting the checkout page. The merchant's checkout page submission can integrate this method to implement wait time functionality without any additional code, or provide a no code solution where the library encapsulates and handles it internally.