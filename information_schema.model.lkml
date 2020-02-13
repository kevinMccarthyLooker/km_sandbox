connection: "thelook_events_redshift"

view: mock_suggestions_table {
  derived_table: {
    sql:
    select 'city' as column, 'Boston' as value union all
    select 'city' as column, 'New York' as value union all
    select 'state' as column, 'Vermont' as value union all
    select 'state' as column, 'Iowa' as value
    ;;
  }
  dimension: column {}
  dimension: value {}
}
explore: mock_suggestions_table {}

view: fields{
  derived_table: {
    sql: select table_name,column_name from information_schema.columns where table_name='users' ;;

  }
  dimension: table_name {}
  dimension: column_name {}
}
explore: fields {}
view: special_parameter {
sql_table_name: public.users ;;

#   dimension: field_names {
#     sql: */ ;;
#   }

#   parameter: select_column_name {
#     type: unquoted
# #     suggest_dimension: field_names

#     suggest_explore: fields
#     suggest_dimension: fields.column_name

#     allowed_value: {label:"city" value:"city"}
#     allowed_value: {label:"state" value:"state"}
#   }
#   dimension: selected_column {
#     # suggest_dimension: select_column_name
#     # sql: ${TABLE}.{% parameter select_column_name %} ;;
#     sql: ${TABLE}.city ;;
# #     sql: {{ select_column_name._parameter_value}}  ;;

# # sql: /* ;;#;;


#   }
  parameter:select_table {type:unquoted allowed_value:{value:"users"}}
  parameter: select_column {
    type:unquoted
    suggest_explore: mock_suggestions_table
    suggest_dimension: mock_suggestions_table.column
  }
  parameter: select_value {type:string
    suggest_explore: mock_suggestions_table
    suggest_dimension: mock_suggestions_table.value
    }
  dimension: parameterized_selected_column {
    sql: ${TABLE}.{{select_column._parameter_value}} ;;
  }

}
explore: special_parameter {
  sql_always_where: ${parameterized_selected_column}={{special_parameter.select_value._parameter_value}} ;;
}
