connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project


#my base table
view: users__cancel_grouping
{
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {}
  measure: count {}

  dimension: created_week {
    type: date_week_of_year
    sql: ${TABLE}.created_at ;;
  }
  dimension: created_week_at_month_begin {
    type: date_week_of_year
    sql: date_trunc('month',${TABLE}.created_at) ;;
  }

  dimension: created_week_of_month {
    type: number
    sql:${created_week}-${created_week_at_month_begin}  ;;
  }

  #two fields to control whether looker uses group by or not
  dimension: group_by__yes {sql: null ;;}
  dimension: group_by__no {sql: null ;;}
}

#demo explore
explore: users__cancel_grouping
{
  cancel_grouping_fields: [users__cancel_grouping.group_by__no]
  #other joins as usual
  join: order_items
  {
    relationship: one_to_many
    sql_on: ${users__cancel_grouping.id}=${order_items.id} ;;
  }
}
