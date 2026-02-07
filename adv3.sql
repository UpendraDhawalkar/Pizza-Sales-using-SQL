-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name, revenue
from
(select category, name, revenue,
rank() over(partition by category order by revenue) as rn
from
(select pizza_types.category,pizza_types.name,
sum(orders_details.quantity*pizzas.price) as revenue
from orders_details join pizzas
on 
orders_details.pizza_id=pizzas.pizza_id
join pizza_types on
pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.category,pizza_types.name) as a) as b
where rn<= 3;