connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view:  taylor_q_restriction_from_scheduling {
  extends: [basic_users]

  dimension: age {hidden:yes}
  dimension: restricted_copy_of_age {
    sql: concat('hashed for security',MD5(${age})) ;;
    html: {{_user_attributes['name']}},{{age._rendered_value}} , {{_query['_query_timezone']}} ,{{_query['source']}},{{_query['result_source']}},{{_query[] | join:','}};;
  }
}

explore: taylor_q_restriction_from_scheduling {
  sql_always_where: 1=1 --{{'now' | date: "%Y-%m-%d %H:%M"}}=getdate() and {{_query['_query_timezone']}} and ;;
}
