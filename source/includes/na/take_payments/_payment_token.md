## Single-use Token

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYU..."
-H "Content-Type: application/json"
-d '{
    "payment_method":"token",
    "order_number":"MyOrderId-01234",
    "amount":15.99,
    "token":{
        "code":"gt7-0f2f20dd-777e-487e-b688-940b...",
        "name":"John Doe",
        "complete":true
    }
}'
```

```php
$beanstream = new \Beanstream\Gateway('300200578', '4BaD82D9197b4cc4b70a221911eE9f70', 'www', 'v1');

$token_payment_data = array(
    'order_number' => "orderNum45678",
    'amount' => 100.0,
    'name' => 'Mrs. Token Testerson'
);
try {
    $result = $beanstream->payments()->makeSingleUseTokenPayment($token, $token_payment_data, TRUE);
    print_r( $result );
} catch (\Beanstream\Exception $e) {
    //handle exception
}
```

```python
beanstream = gateway.Beanstream()
beanstream.configure(
        '300200578',
        payment_passcode='4BaD82D9197b4cc4b70a221911eE9f70')
txn = beanstream.purchase_with_token(22.13, token)
txn.set_cardholder_name("Gizmo")
resp = txn.commit()
```

```java
Gateway beanstream = new Gateway("v1",
    300200578,
    "4BaD82D9197b4cc4b70a221911eE9f70");

TokenPaymentRequest tokenReq = new TokenPaymentRequest();
tokenReq.setAmount(100.00);
tokenReq.setOrderNumber("myOrder9999");
tokenReq.getToken()
        .setName("John Doe")
        .setCode(myToken);

try {
    PaymentResponse response = beanstream.payments().makePayment(tokenReq);
    System.out.println("Token Payment Approved? "+ response.isApproved());

} catch (BeanstreamApiException ex) {
    //TODO handle exception
}
```

```csharp
Gateway bambora = new Gateway () {
    MerchantId = 300200578,
    PaymentsApiKey = "4BaD82D9197b4cc4b70a221911eE9f70",
    ApiVersion = "1"
};

PaymentResponse response = bambora.Payments.MakePayment (
    new TokenPaymentRequest ()
    {
        Amount = 30.0,
        OrderNumber = "myOrder88888",
        Token = new Token {
            Code = token, // your single use token
            Name = "John Doe"
        }
    }
);
```

Single-use tokens provide a secure method of taking payments that reduces your PCI scope. You can take a payment using a token the same as you would take a payment with a credit card, the main difference being the ‘payment_method’ parameter and supplying the token.

To process a transaction using a token, you first need to have created a token. You can either do this from the browser/client using the [Tokenization API](/docs/references/payment_APIs) or using the [Browser SDKs](/docs/references/payment_SDKs/collect_card_data).

A single-use token is a 'single-use nonce'. It is distinct from a multi-use Payment Profile token. See [here](/docs/references/payment_SDKs/save_customer_data).


#### Pre-Auth and Complete

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYU..."
-H "Content-Type: application/json"
-d '{
    "payment_method":"token",
    "order_number":"MyOrderId-01234",
    "amount":15.99,
    "token":{
        "code":"gt7-0f2f20dd-777e-487e-b688-940b526172cd",
        "name":"John Doe",
        "complete":false
    }
}'

#
# completion:
#

Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments/{transId}/completions
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYU..."
-H "Content-Type: application/json"
-d '{
    "amount":9.33
}'
```

```php
$beanstream = new \Beanstream\Gateway('300200578', '4BaD82D9197b4cc4b70a221911eE9f70', 'www', 'v1');

$token_payment_data = array(
    'order_number' => "orderNum45678",
    'amount' => 100.0,
    'name' => 'Mrs. Token Testerson'
);
try {
    $result = $beanstream->payments()->makeTokenPayment($token, $token_payment_data, FALSE);//set to FALSE for Pre-Auth
    $transaction_id = $result['id'];
    // complete payment
    $result = $beanstream->payments()->complete($transaction_id, 12.5);
    print_r( $result );
} catch (\Beanstream\Exception $e) {
    //todo handle exception
}
```

```python
beanstream = gateway.Beanstream()
beanstream.configure(
    '300200578',
    payment_passcode='4BaD82D9197b4cc4b70a221911eE9f70')
txn = beanstream.preauth_with_token(50.0, token)
txn.set_cardholder_name("Gizmo")
resp = txn.commit()
# complete payment
trans2 = beanstream.preauth_completion(resp.transaction_id(), 25.00)
resp2 = trans2.commit()
```

```java
Gateway beanstream = new Gateway("v1",
    300200578,
    "4BaD82D9197b4cc4b70a221911eE9f70");

TokenPaymentRequest req = new TokenPaymentRequest();
req.setAmount(80.00);
req.setOrderNumber("myOrder77777");
req.getToken()
    .setName("John Doe")
    .setCode(mySingleUseToken);

try {
    PaymentResponse response = beanstream.payments().preAuth(req);
	// complete payment
    response = beanstream.payments().preAuthCompletion(response.id, 55.30, response.orderNumber);
} catch (BeanstreamApiException ex) {
    //todo handle error
}
```

```csharp
Gateway bambora = new Gateway () {
    MerchantId = 300200578,
    PaymentsApiKey = "4BaD82D9197b4cc4b70a221911eE9f70",
    ApiVersion = "1"
};

PaymentResponse response = bambora.Payments.PreAuth (
    new TokenPaymentRequest ()
    {
        Amount = 30,
        OrderNumber = "orderNumber66666",
        Token = new Token {
            Code = token, // your single use token
            Name = "John Doe"
        }
    }
);

response = bambora.Payments.PreAuthCompletion (response.TransactionId, 15.45);
```
