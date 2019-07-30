connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: users_for_test_constants {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {
    label: "{% assign x = '@{test_constant}' %}{{x | replace: 'sfo','other value' }}"
  }
  dimension: now {
    sql: @{constant__now} ;;
  }
}

explore: users_for_test_constants {}
