-- What are the top 3 products sold per month in 2011?

WITH
  MonthlySales AS (
    SELECT
      dd.DATEKEY,
      dd.CALENDARYEAR,
      dd.MONTHNUMBEROFYEAR,
      fis.PRODUCTKEY,
      SUM(fis.SALESAMOUNT) AS TotalSales
    FROM
      KATER.ADVENTUREWORKSDW.FACTINTERNETSALES fis
      JOIN KATER.ADVENTUREWORKSDW.DIMDATE dd ON fis.ORDERDATEKEY = dd.DATEKEY
    WHERE
      dd.CALENDARYEAR = 2011
    GROUP BY
      dd.DATEKEY,
      dd.CALENDARYEAR,
      dd.MONTHNUMBEROFYEAR,
      fis.PRODUCTKEY
  ),
  RankedProducts AS (
    SELECT
      CALENDARYEAR,
      MONTHNUMBEROFYEAR,
      PRODUCTKEY,
      TotalSales,
      RANK() OVER (
        PARTITION BY
          MONTHNUMBEROFYEAR
        ORDER BY
          TotalSales DESC
      ) AS SalesRank
    FROM
      MonthlySales
  )
SELECT
  rp.CALENDARYEAR,
  rp.MONTHNUMBEROFYEAR,
  rp.PRODUCTKEY,
  dp.ENGLISHPRODUCTNAME AS PRODUCTNAME,
  rp.TotalSales
FROM
  RankedProducts rp
  JOIN KATER.ADVENTUREWORKSDW.DIMPRODUCT dp ON rp.PRODUCTKEY = dp.PRODUCTKEY
WHERE
  rp.SalesRank <= 3
ORDER BY
  rp.MONTHNUMBEROFYEAR,
  rp.SalesRank;