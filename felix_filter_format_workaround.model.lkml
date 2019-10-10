connection: "thelook_events_redshift"

include: "basic_users.*"

view: felix_filter_format_workaround {
  extends: [basic_users]
}

explore: felix_filter_format_workaround {

  sql_always_where:
  {%date_start felix_filter_format_workaround.created_date %}<=${created_raw}
  and
  {%date_end felix_filter_format_workaround.created_date %}>${created_raw}
  ;;
}
