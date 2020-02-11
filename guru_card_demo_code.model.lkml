connection: "thelook_events_redshift"

view: orders {dimension:primary_key{} dimension:buyer_foreign_key{}}
view: buyers {dimension:primary_key{}}

explore: orders {
  join: buyers {
    relationship: many_to_one
    sql: ${orders.buyer_foreign_key}=${buyers.primary_key} ;;
  }
}

view: customer_order_summary {
  derived_table: {sql:
select orders.customer_id,
[any number of measures... fields defined with one aggregate function]
from public.orders
group by orders.customer_id
;;
  }
  dimension: customer_id {}
  dimension: primary_key {primary_key:yes sql:${customer_id};;}
}
