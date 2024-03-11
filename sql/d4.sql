-- What are the demographics of repeating customers?

WITH
  CustomerPurchases AS (
    SELECT
      CUSTOMERKEY,
      COUNT(DISTINCT SALESORDERNUMBER) AS NumberOfPurchases
    FROM
      KATER.ADVENTUREWORKSDW.FACTINTERNETSALES
    GROUP BY
      CUSTOMERKEY
  ),
  RepeatCustomers AS (
    SELECT
      CUSTOMERKEY
    FROM
      CustomerPurchases
    WHERE
      NumberOfPurchases > 1
  ),
  RepeatCustomerDetails AS (
    SELECT
      dc.*,
      cp.NumberOfPurchases
    FROM
      KATER.ADVENTUREWORKSDW.DIMCUSTOMER dc
      JOIN RepeatCustomers rc ON dc.CUSTOMERKEY = rc.CUSTOMERKEY
      JOIN CustomerPurchases cp ON dc.CUSTOMERKEY = cp.CUSTOMERKEY
  )
SELECT
  *
FROM
  RepeatCustomerDetails
LIMIT 300;