connection: "thelook_events_redshift"

view: baseball_teams {
  derived_table: {
    sql:
    select 1 as baseball_id,'Boston' as city, 'Red Sox' as team union all
    select 2 as baseball_id,'New York' as city, 'Mets' as team union all
    select 3 as baseball_id,'New York' as city, 'Yankees' as team
    ;;
  }
  dimension: baseball_id {primary_key:yes type:number}
  dimension: city {}
  dimension: team {label:"Baseball Team Name"}
}
view: football_teams {
  derived_table: {
    sql:
    select 1 as football_id,'New England' as city, 'Patrios' as team union all
    select 2 as football_id,'New York' as city, 'Giants' as team
    ;;
  }
  dimension: football_id {primary_key:yes type:number}
  dimension: city {}
  dimension: team {label:"Football Team Name"}
}
view: parameters {
  sql_table_name:  ;;
  parameter: join_type {
    type: unquoted
    allowed_value: {value:"left_outer_join" label:"left outer join"}
    allowed_value: {value:"inner_join" label:"inner join"}
    allowed_value: {value:"full_outer_join" label:"full outer"}
    allowed_value: {value:"cross_join" label:"cross join"}
  }
}
explore: baseball_teams {
  join: parameters {sql:;; relationship:one_to_one}
  join: football_teams {
    relationship:many_to_many
    sql: {{ parameters.join_type._parameter_value | replace: "_"," " }} ${football_teams.SQL_TABLE_NAME}
    {% if parameters.join_type._parameter_value == 'cross_join' %}
    {% else %}
    on ${baseball_teams.city} = ${football_teams.city}
    {% endif %}
    ;;
  }
}

include: "users.*"
include: "events.*"
include: "order_items.*"
view: join_paths {
  derived_table: {
sql:/*define join_paths*/
{% if events._in_query %} select 'users-events' as join_path union all {% endif %}
{% if order_items._in_query %} select 'users-order_items' as join_path union all {% endif %}
select null as join_path where 1=0/*closeout last union all by adding no rows*/
  ;;
  }
  dimension: join_path {}
}
explore: users {
  join: join_paths {
    type: cross
    relationship: one_to_one
  }
  join: events {
    type: left_outer
    relationship: one_to_many
    sql_on:
${events.user_id}=${users.id}
  AND ${join_paths.join_path}='users-events';;
  }
  join: order_items {
    type: left_outer
    relationship: one_to_many
sql_on:
${order_items.user_id}=${users.id}
  AND ${join_paths.join_path}='users-order_items';;
  }
}
