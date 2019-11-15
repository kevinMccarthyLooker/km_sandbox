connection: "thelook_events_redshift"

include: "*basic_users.view"

include: "*dashboard_hacking*"

view:dashboard_hacking {
  extends:[basic_users]

  }

explore: dashboard_hacking {}
