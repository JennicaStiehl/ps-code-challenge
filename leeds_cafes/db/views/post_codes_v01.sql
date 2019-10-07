SELECT LEFT(post_code, 3)as "Post_Code_Prefix"
              , MAX(mc.Most_Chairs)as "Most_Chairs"
              , MAX(mc.cafe_name)as cafe_name
              , SUM(number_of_chairs)as "Total_Chairs"
              , COUNT(r.id)as "Total_Places"
              , (SELECT SUM(number_of_chairs) FROM restaurants)as "Total_Chairs_in_Leeds"
              , ROUND((SUM(number_of_chairs)* 1.0 / (SELECT SUM(number_of_chairs) FROM restaurants))*100, 2) as "Percent_Leeds_Chairs"
FROM restaurants r
LEFT OUTER JOIN (SELECT id, cafe_name, max(number_of_chairs)as Most_Chairs
                                  FROM restaurants
                                  GROUP BY id, cafe_name  )as mc
            on r.id = mc.id
GROUP BY LEFT(post_code, 3)
