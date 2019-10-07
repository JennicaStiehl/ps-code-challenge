SELECT post_code
              , id as "pc id"
              , max(number_of_chairs)as "Most Chairs"
              , sum(number_of_chairs)as "Total Chairs"
              , count(id)as "Total Places"
              , (SELECT sum(number_of_chairs) FROM restaurants)as "Total Chairs in Leeds"
              , (sum(number_of_chairs) / (SELECT sum(number_of_chairs) FROM restaurants))as "Percent Leeds Chairs"
FROM restaurants
GROUP BY post_code, id
ORDER BY post_code, sum(number_of_chairs) desc;
