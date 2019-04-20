connection: "thelook_events_redshift"

# include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: users_for_row_liquid_test {
  sql_table_name: public.users ;;
  dimension: id {
    primary_key:yes
    sql: /*goodfy test*/${TABLE}.id ;;
  }
  dimension: id_referenced {sql:/*add test*/${id};;}
  dimension: age {type:number
    }
  measure: count {type:count}
  dimension: row_liquid_test {
#     sql: {{ row['users_for_row_liquid_test.age'] }} ;; #throws an error - variable row not found
    type: number
    sql: ${age} ;;
    html: age:{{ row['users_for_row_liquid_test.age'] }}! ;;
  }
  dimension: row_liquid_test__value {
#     sql: {{ row['users_for_row_liquid_test.age'] }} ;; #throws an error - variable row not found
    type: number
    sql: ${age} ;;
    html: age_value:{{ users_for_row_liquid_test.age._value }}! ;;
  }

  measure: example_for_mean {
    sql: count(*) ;;
    html: {{mean}} ;;
  }

}

explore: users_for_row_liquid_test {}
