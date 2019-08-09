connection: "thelook_events_redshift"

include: "basic_users.view"

view: users__always_filter_using_user_attribute {
  extends: [basic_users]

}

explore: users__always_filter_using_user_attribute {

  always_filter: {
    filters: {
      field: last_name
      value: "{{_user_attributes['email']}}"
    }
  }
}
