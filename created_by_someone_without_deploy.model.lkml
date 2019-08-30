connection: "thelook_events_redshift"

include: "basic_users.*"

view: basic_users_by_someone_without_deploy {
  extends: [basic_users]
  view_label: "testing deploy options"
}

explore: basic_users_by_someone_without_deploy {}
