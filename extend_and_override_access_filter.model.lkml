connection: "thelook_events_redshift"

include: "*basic_users.*"

view: extend_and_override_access_filter {
  extends: [basic_users]
}

explore: extend_and_override_access_filter_base {
  from: extend_and_override_access_filter
  view_name: extend_and_override_access_filter
  access_filter: {
    field: extend_and_override_access_filter.last_name
    user_attribute: can_access_sensitive_data
  }
}

explore: extend_and_override_access_filter_extended {
  extends: [extend_and_override_access_filter_base]
  access_filter: {
    field: extend_and_override_access_filter.last_name
    user_attribute: test_no_filter
  }
}
