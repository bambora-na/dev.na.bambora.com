---
title: Configure the form
layout: tutorial

summary: Checkout provides you with an easy-to-use way to process payments on your site.

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.checkout_guide
    header_active: guides
---

# Configure the form

<div style='border-color:red; border-style:solid;padding: 1% 1%' ><p style='font-weight:bold'>PLEASE NOTE: Checkout will no longer be brandable after February 28, 2025.</p> 
 
To comply with the <a href="https://docs-prv.pcisecuritystandards.org/PCI%20DSS/Standard/PCI-DSS-v4_0.pdf" target="\_blank">PPCI DSS v4.0</a> the brandable functionality of Worldline’s hosted Checkout form will no longer be available after <strong>February 28, 2025</strong>. Please review the upcoming changes:
<ul>
  <li>Custom headers and footers will no longer be supported.</li>
  <li>We will implement a neutral colourway to seamlessly fit any checkout.</li>
  <li>For a fully brandable checkout solution, please use Worldline’s <a href="https://dev.na.bambora.com/docs/guides/custom_checkout/" target="\_blank">Custom Checkout.</a></li>
</ul>
</div>

<br>After the user clicks on the link or button on your site, they are redirected to the Worldline Checkout Form.

You can configure the form in the [Member Area](https://web.na.bambora.com). You can control what fields are displayed by default. Click on **configuration**, and select **checkout** to find a list of title and form options.

## Layout
These settings control the default appearance of the form. They can be overridden by settings passed in the URL.

- **Transaction Type** - Choose between *Purchase* or *Pre-Authorization* as the default transaction type.
- **Include Billing Address** - Show billing address fields. This setting is secondary to the 'Billing address optional' setting in *Order Settings*
- **Include Shipping Address** - Show shipping address fields.
- **Allow Price Modification** - Show and allow the user to edit the amount.
- **Include Invoice/Order** - Show and allow the user to edit the invoice/order number.
- **Include Card Selection** - Allow the user to select their card brand. This field redundant. We recommend that it is excluded.
- **Include comments** - Show the comments text field.
- **Include Google Pay Button** - Show the Google Pay Button.

Once you've finished customizing your form's fields, click **View Preview** at the bottom of the page to see your payment form. Click **Update Live** to confirm your changes and update your forms.

## Redirect pages
By default, Checkout displays feedback on a transaction's success or failure to the user. You can override this behaviour by setting a custom redirect to bring the user back to your website after a transaction has been completed.

You can either pass redirect URLs as a GET parameters in the Checkout URL (see below), or you can set them in the [Member Area](https://web.na.bambora.com). Click **administration**, then **account settings**, and then **order settings**. Under **Transaction Response Pages**.

### Testing redirects
You may fined it helpful tools like [PutsReq](http://putsreq.com) helpful while testing.
