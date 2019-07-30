connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project


#my base table
view: users__no_sort_cost
{
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {
    order_by_field: sort_by_nothing

  }
  measure: count {type:count}
  dimension: sort_by_nothing {
    sql: null::varchar;;
  }
  #two fields to control whether looker uses group by or not
  dimension: group_by__yes {sql: null ;;}
  dimension: group_by__no {sql: null ;;}
}

#demo explore
explore: users__no_sort_cost
{}
