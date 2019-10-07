SELECT category
              , SUM(number_of_chairs)as "Total_Chairs"
              , COUNT(id)as "Total_Places"
              , (SELECT SUM(number_of_chairs) FROM restaurants)as "Total_Chairs_in_Leeds"
              , ROUND((SUM(number_of_chairs)* 1.0 / (SELECT SUM(number_of_chairs) FROM restaurants))*100, 2) as "Percent_Leeds_Chairs"
FROM restaurants
GROUP BY category
