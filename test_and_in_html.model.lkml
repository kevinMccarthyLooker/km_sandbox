connection: "thelook_events_redshift"

include: "/**/basic_users.view"
view: test_and_in_html {
  extends: [basic_users]
  dimension: test_base {
    sql: '1&2' ;;
  }
  dimension: html_test {
    sql: '1&2' ;;
    html: {{test_base._rendered_value}} ;;
  }
}

explore: test_and_in_html {}
