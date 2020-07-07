connection: "thelook_events_redshift"
include: "basic_users*"

view: users {extends: [basic_users]}
view: log_selection{
  derived_table: {
    persist_for: "1 second"
    create_process: {
      sql_step:
insert into profservices_scratch.parameter_log (
select getdate(),{{test_saving_me._parameter_value}} as parameter_value
)
;;
    }
  }
  parameter: test_saving_me {}
}
explore: write_parameters {
  view_name: users
  join: log_selection {sql:;; relationship: one_to_one}
}
