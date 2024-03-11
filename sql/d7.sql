-- What is our month over month revenue growth?

WITH
  monthly_revenue AS (
    SELECT
      EXTRACT(
        YEAR
        FROM
          dd.FULLDATEALTERNATEKEY
      ) AS year,
      EXTRACT(
        MONTH
        FROM
          dd.FULLDATEALTERNATEKEY
      ) AS month,
      SUM(fis.SALESAMOUNT) AS total_revenue
    FROM
      KATER.ADVENTUREWORKSDW.FACTINTERNETSALES fis
      JOIN KATER.ADVENTUREWORKSDW.DIMDATE dd ON fis.ORDERDATEKEY = dd.DATEKEY
    GROUP BY
      1,
      2
  ),
  month_over_month_growth AS (
    SELECT
      year,
      month,
      total_revenue,
      LAG (total_revenue) OVER (
        ORDER BY
          year,
          month
      ) AS prev_month_revenue,
      (
        total_revenue - LAG (total_revenue) OVER (
          ORDER BY
            year,
            month
        )
      ) / LAG (total_revenue) OVER (
        ORDER BY
          year,
          month
      ) * 100 AS growth_percentage
    FROM
      monthly_revenue
  )
SELECT
  year,
  month,
  total_revenue,
  prev_month_revenue,
  growth_percentage
FROM
  month_over_month_growth
ORDER BY
  year,
  month;