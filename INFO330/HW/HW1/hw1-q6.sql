-- hw1-q6
SELECT *
FROM MyRestaurants
WHERE liked = 0
AND DATEADD(month, -11, GETDATE()) < lastvist;




