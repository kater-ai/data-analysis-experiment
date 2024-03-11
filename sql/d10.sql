-- What are the monthly moving averages of revenue received, as well as total revenue received, from sales promotion type Volume Discount?

WITH
  MonthlySales AS (
    SELECT
      dd.FULLDATEALTERNATEKEY AS Month,
      SUM(fis.SALESAMOUNT) AS TotalSales
    FROM
      KATER.ADVENTUREWORKSDW.FACTINTERNETSALES fis
      LEFT JOIN KATER.ADVENTUREWORKSDW.DIMPROMOTION dpro ON fis.PROMOTIONKEY = dpro.PROMOTIONKEY
      LEFT JOIN KATER.ADVENTUREWORKSDW.DIMDATE dd ON fis.ORDERDATEKEY = dd.DATEKEY
    WHERE
      dpro.ENGLISHPROMOTIONTYPE = 'Volume Discount'
    GROUP BY
      dd.FULLDATEALTERNATEKEY
  ),
  MovingAverages AS (
    SELECT
      Month,
      AVG(TotalSales) OVER (
        ORDER BY
          Month ROWS BETWEEN 1 PRECEDING
          AND CURRENT ROW
      ) AS MovingAverage
    FROM
      MonthlySales
  )
SELECT
  ms.Month,
  ms.TotalSales,
  ma.MovingAverage
FROM
  MonthlySales ms
  LEFT JOIN MovingAverages ma ON ms.Month = ma.Month
ORDER BY
  ms.Month
LIMIT 300;