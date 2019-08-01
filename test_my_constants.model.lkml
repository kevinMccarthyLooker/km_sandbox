connection: "thelook_events_redshift"

include: "test_config_file.lkml"
view: users_for_test_my_constants {
  sql_table_name: public.users ;;
  dimension: age {
    label: "{% assign x = my_constants.capitalize._sql %}{{'te' | x }},{{ 'test' | my_constants.capitalize._sql }}"

  }
}

explore: users_for_test_my_constants {
  join: my_constants {sql:;; relationship:one_to_one}
}
