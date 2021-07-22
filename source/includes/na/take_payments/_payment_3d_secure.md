## 3D Secure

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{

   "amount": 250.01,
   "payment_method": "card",
   "customer_ip": "123.123.123.123"
   "card": {
      "name": "Test User",
      "number": "4012000033330026",
      "expiry_month": "09",
      "expiry_year": "20",
      "3d_secure": {
         "browser": {
            "acceptHeader": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "javaEnabled": "false",
            "language": "en-US",
            "colorDepth": "24bits",
            "screenHeight": 1080,
            "screenWidth": 1920,
            "timeZone": -120,
            "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
            "JavascriptEnabled": true,
         },
         "enabled": true,
         "version": 2,
         "authRequired": false
      }
   }
}'```

Verified by Visa (VbV), MasterCard SecureCode, and AMEX SafeKey are security features that prompt customers to enter a passcode when they pay by Visa, MasterCard, or AMEX. Merchants that want to integrate VbV, SecureCode, or SafeKey must have signed up for the service through their bank merchant account issuer. This service must also be enabled by our support team.

[//]: # (Use one of these two options to implement 3D Secure:)

[//]: # (* Use our API based 2-Step process.)
[//]: # (* Or use your own authentication process and pass the secure token data to our API.)

See [here](/docs/guides/3D_secure) for more information on how to implement 3D Secure.
