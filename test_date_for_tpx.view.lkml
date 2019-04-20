explore: extending_test_date_for_tpx {}

view: test_date_view_for_tpx_to_be_extended {
  dimension_group: t {
    type: time
    timeframes: [raw,date]
    sql:  ;;
  }
}

view: extending_test_date_for_tpx {
  extends: [test_date_view_for_tpx_to_be_extended]
  dimension: t {#invalidates t_date by overwriting t
    #intentionally caused errors, so commenting out
    # type:string
  }

#intentionally caused errors, so commenting out
  # dimension: refer_to_a_thing_we_think_exists{sql: ${t_date} ;;}
}
