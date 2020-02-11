connection: "thelook_events_redshift"

include: "basic_users.view.lkml"                # include all views in the views/ folder in this project

view: bare_joined_parameter_users {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {type:number}
  dimension: age_multiplied {
    type: number
    sql: ${age} * {{multiplier_parameters.multiplier._parameter_value}} ;;
  }
}

view: bare_joined_parameter_order_items {
  sql_table_name: public.order_items ;;
  dimension: id {primary_key:yes}
  dimension: sale_price {type:number}
  dimension: sale_price_multiplied {
    type: number
    sql: ${sale_price} * {{multiplier_parameters.multiplier._parameter_value}} ;;
  }
}

view: multiplier_parameters {
  parameter: multiplier {
    type: number
  }
}

explore: bare_joined_parameter_users {
  join: multiplier_parameters {
    relationship: one_to_one
    sql:  ;;
  }
}

explore: bare_joined_parameter_order_items {
  join: multiplier_parameters {
    relationship: one_to_one
    sql:  ;;
  }
}
