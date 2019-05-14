view: gender_user_dt {
derived_table: {
  sql: select concat(gender,last_name) as value from users ;;
}

dimension: value {}
}
