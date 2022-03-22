-- hw1-q5
SELECT M.name, M.distance
FROM MyRestaurants AS M
WHERE M.distance <= 20
ORDER BY M.name ASC;