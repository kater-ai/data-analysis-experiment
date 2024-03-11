-- What are our most lucrative demographics by sales?

SELECT
  dc.GENDER,
  dc.ENGLISHEDUCATION AS EDUCATION,
  dc.ENGLISHOCCUPATION AS OCCUPATION,
  dc.YEARLYINCOME,
  SUM(fis.SALESAMOUNT) AS TOTAL_REVENUE
FROM
  KATER.ADVENTUREWORKSDW.FACTINTERNETSALES fis
  JOIN KATER.ADVENTUREWORKSDW.DIMCUSTOMER dc ON fis.CUSTOMERKEY = dc.CUSTOMERKEY
GROUP BY
  dc.GENDER,
  dc.ENGLISHEDUCATION,
  dc.ENGLISHOCCUPATION,
  dc.YEARLYINCOME
ORDER BY
  TOTAL_REVENUE DESC;