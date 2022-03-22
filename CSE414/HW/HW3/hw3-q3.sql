SELECT F.origin_city as origin_city, ISNULL((SELECT COUNT(F2.fid) as count
                                      FROM FLIGHTS F2
                                      WHERE F2.actual_time < 180
                                      AND F2.canceled = 0
                                      AND F2.origin_city = F.origin_city
                                      GROUP BY F2.origin_city
                                    ) * 100.0/ COUNT(*), 0) AS percentage
FROM FLIGHTS F
WHERE F.canceled = 0
GROUP BY F.origin_city
ORDER BY percentage, origin_city;


-- the number of rows the query returns: 327

-- the time the query takes: 9s

/* the first 20 rows of the result:
Guam TT   0.000000000000
Pago Pago TT   0.000000000000
Aguadilla PR   28.897338403041
Anchorage AK   31.812080536912
San Juan PR   33.660531697341
Charlotte Amalie VI   39.558823529411
Ponce PR   40.983606557377
Fairbanks AK   50.116550116550
Kahului HI   53.514471352628
Honolulu HI   54.739028823682
San Francisco CA   55.828864537188
Los Angeles CA   56.080890822987
Seattle WA   57.609387792231
Long Beach CA   62.176439513998
New York NY   62.371834136728
Kona HI   63.160792951541
Las Vegas NV   64.920256372037
Christiansted VI   65.100671140939
Newark NJ   65.849971096980
Plattsburgh NY   66.666666666666
*/