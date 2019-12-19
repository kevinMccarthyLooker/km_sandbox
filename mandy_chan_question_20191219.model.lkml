connection: "thelook_events_redshift"

include: "basic_users.view"

view: mandy_chan_question_20191219 {
  extends: [basic_users]
  dimension: link_test__on_age {
    sql: ${age} ;;
    link: {label:"Testing"
      url:"google.com"}
  html: <a href="{{link}}">{{value}}</a> ;;
  }
}
explore: mandy_chan_question_20191219 {}
