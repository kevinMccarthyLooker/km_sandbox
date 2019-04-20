connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard



view: derived {
  derived_table: {
    sql:
    select * from public.users
    ;;
  }
}

view: derived2 {
  derived_table: {
    sql:
    --select * from ${derived.SQL_TABLE_NAME}
    select * from public.users
    ;;
  }
  dimension: id {}
}

explore: derived2 {}
