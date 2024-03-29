## Get Transactions

```shell
Definition
GET /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments/{transactionId} \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
```

```php
try {
    $result = $beanstream->reporting()->getTransaction($transaction_id);
} catch (\Beanstream\Exception $e) {
    //handle exception
}
```

```python
txn = self.beanstream.get_transaction(transId)
resp = txn.commit()
```

```java
try {
    Transaction transaction = beanstream.reports().getTransaction(transactionId);

} catch (BeanstreamApiException ex) {
    // todo handle error
}
```

```csharp
Transaction trans = beanstream.Reporting.GetTransaction (TransactionId);
```

You can retrieve a previous transaction using this method. All you need is the transaction ID.

You must use the correct API key for this method.

## Search by Specific Criteria

```shell
Definition
POST /v1/reports HTTP/1.1

Request
curl https://api.na.bambora.com/v1/reports \
-u "284000000:30c9dbd6505a4c8e960451feba6f036a" \
-d '{
     "name": "Search",
     "start_date": "2012-01-01T01:01:03",
     "end_date": "2014-06-05T16:05:00",   
     "start_row": "1",
     "end_row": "2",
     "criteria": [
       {
         "field": "1",
         "operator": "%3C%3D",
         "value": "10000001"
       }
     ]
   }'
```

```php
$search_criteria = array(
     'name' => 'TransHistoryMinimal', // or 'Search',
     'start_date' => '1999-01-01T00:00:00',
     'end_date' => '2016-01-01T23:59:59',   
     'start_row' => '1',
     'end_row' => '500',
     'criteria' => array(
         'field' => '1',
         'operator' => '%3E',
         'value' => '1000000'
     )
);
try {
    $result = $beanstream->reporting()->getTransactions($search_criteria);
} catch (\Beanstream\Exception $e) {
    //handle exception
}
```

```python
startDate = datetime.now() - timedelta(hours=1) #1 hour ago
endDate = datetime.now() + timedelta(hours=1)  #1 hour from now

txn = self.beanstream.query_transactions()
criteria = [Criteria(Fields.TransactionId, Operator('='), transId)]
txn.set_query_params(startDate, endDate, 1, 10, criteria) #1 and 10 are the paging numbers
resp = txn.commit()
```

```java
try {
    Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, -1);
	Date startDate = cal.getTime(); // yesterday
	cal = Calendar.getInstance();
	cal.add(Calendar.DATE, 1);
	Date endDate = cal.getTime(); // tomorrow
	Criteria[] searchFilter = new Criteria[]{
		new Criteria(QueryFields.OrderNumber, Operators.Equals, "myOrderNumber001")
	};
	List<TransactionRecord> query = beanstream.reports().query(startDate, endDate, 1, 2, searchFilter);

} catch (BeanstreamApiException ex) {
    // todo handle error
}
```

```csharp
List<TransactionRecord> records = beanstream.Reporting.Query (  
	DateTime.Now.Subtract(TimeSpan.FromMinutes(1)),
	DateTime.Now.Add(TimeSpan.FromMinutes(5)),
	1,
	500,
	new Criteria[]{
		new Criteria() {
			Field = QueryFields.TransactionId,
			Operator = Operators.GreaterThanEqual,
			Value = "1"
		},
		new Criteria() {
			Field = QueryFields.TransactionId,
			Operator = Operators.LessThanEqual,
			Value = "99999999"
		}
	}
);
```

With the Reporting API you can access basic summary order information using simple search functions.

Each search can be performed using a date range and an optional number of search criteria, to narrow down the search.

Notes: 
* Make sure you are using the Reporting API key gathered from the member area in your account.
* **Paging limit is set to 500 records**

### Parameters
There are several parameters that are required to perform a search:

* **Date Range:** The start and end dates that you want to search between.
* **Paging rows:** If you are searching for possibly a lot of records, these parameters let you page the results. The starting row value must be 1 or greater. If you are just looking to retrieve one row, set the start row to 1 and the end row to 2. If the difference between start and end rows is greater than 500, only the top 500 records will be retrieved.
* **Criteria:** (Optional) You can narrow down your search by using specific search criteria

#### Search Criteria
The search criteria require 3 parameters: field, operator, and value. You can supply as many criteria as you wish and each Criteria will be ANDed together eg. CriteriaA AND CriteriaB AND CriteriaC

##### 1. Field
The criteria operate on over 20 different fields of a transaction record. Each field is specified by a numeric value, in order starting from 1. The SDKs will handle this mapping for you, but if you are using REST directly then you will want to take note of this table:

| Index | Field Name        |
| ----- | ----------------- |
| 1     | TransactionId     |
| 2     | Amount            |
| 3     | MaskedCardNumber  |
| 4     | CardOwner         |
| 5     | OrderNumber       |
| 6     | IPAddress         |
| 7     | AuthorizationCode |
| 8     | TransType         |
| 9     | CardType          |
| 10    | Response          |
| 11    | BillingName       |
| 12    | BillingEmail      |
| 13    | BillingPhone      |
| 14    | ProcessedBy       |
| 15    | Ref1              |
| 16    | Ref2              |
| 17    | Ref3              |
| 18    | Ref4              |
| 19    | Ref5              |
| 20    | ProductName       |
| 21    | ProductID         |
| 22    | CustCode          |
| 23    | IDAdjustmentTo    |
| 24    | IDAdjustedBy      |

##### 2. Operator
There are 6 operators available. They must be encoded:

| Operator   | Encoded      |
| ---------- | ------------ |
| =          | %3D          |
| <          | %3C          |
| >          | %3E          |
| <=         | %3C%3D       |
| >=         | %3E%3D       |
| Start With | START%20WITH |


##### 3. Value
This is the value you want to match against.

## Analyze Payment Errors
You can read the errors returned by the API [here](/docs/references/payment_APIs).
