connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project


#my base table
view: users__cancel_grouping
{
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {}
  measure: count {}

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
