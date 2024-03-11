-- Which resellers have the highest sales by territory?

WITH
  FirstPurchase AS (
    SELECT
      fis.CUSTOMERKEY,
      MIN(fis.ORDERDATE) AS FirstPurchaseDate
    FROM
      KATER.ADVENTUREWORKSDW.FACTINTERNETSALES fis
      JOIN KATER.ADVENTUREWORKSDW.DIMPROMOTION dp ON fis.PROMOTIONKEY = dp.PROMOTIONKEY
    WHERE
      dp.ENGLISHPROMOTIONTYPE = 'Volume Discount'
    GROUP BY
      fis.CUSTOMERKEY
  ),
  RetainedCustomers AS (
    SELECT
      fis.CUSTOMERKEY
    FROM
      KATER.ADVENTUREWORKSDW.FACTINTERNETSALES fis
      JOIN FirstPurchase fp ON fis.CUSTOMERKEY = fp.CUSTOMERKEY
    WHERE
      fis.ORDERDATE > fp.FirstPurchaseDate
    GROUP BY
      fis.CUSTOMERKEY
  ),
  TotalCustomers AS (
    SELECT
      COUNT(DISTINCT CUSTOMERKEY) AS TotalCustomers
    FROM
      FirstPurchase
  ),
  RetentionRate AS (
    SELECT
      (
        CAST(COUNT(DISTINCT rc.CUSTOMERKEY) AS FLOAT) / (
          SELECT
            TotalCustomers
          FROM
            TotalCustomers
        )
      ) * 100 AS CustomerRetentionRate
    FROM
      RetainedCustomers rc
  )
SELECT
  *
FROM
  RetentionRate;