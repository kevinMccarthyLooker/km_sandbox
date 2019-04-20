connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: users__links
{
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {
    # html: {{ drill_holder._link }} ;;
    # html: <a href="#drillmenu" target="_self"> ;;
    drill_fields: [id,age]
html: <a href="{{ link }}">
<img border="0" src={% if value == 20 %}"https://github.com/MonuJain27/Images/blob/master/Green.jpg?raw=true"{% else %}"https://github.com/MonuJain27/Images/blob/master/Red.jpg?raw=true"{% endif %} width="100" height="100">
</a> ;;
  }
  measure: count {
    type: count
    drill_fields: [id,age]
    html: <a href="{{ link }}">
    <img border="0" src={% if value > 20 %}"https://github.com/MonuJain27/Images/blob/master/Green.jpg?raw=true"{% else %}"https://github.com/MonuJain27/Images/blob/master/Red.jpg?raw=true"{% endif %} width="100" height="100">
    </a> ;;
  }

  #two fields to control whether looker uses group by or not
  measure: drill_holder {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [id]

  }

}
#
explore: users__links {}
