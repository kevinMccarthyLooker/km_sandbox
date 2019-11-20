connection: "thelook_events_redshift"

include: "basic_users.view"
# include: "merge_filter_example.dashboard"

include: "test_thin*"

view: dashboard_layers_fun {
  extends: [basic_users]

  measure: picture1 {
    sql: max(1) ;;
    html: <img src="https://lou.looker.com/assets/img/profile_picture/fabio.jpg" /> ;;
  }

}
explore: dashboard_layers_fun {}
include: "overlay.dashboard"
