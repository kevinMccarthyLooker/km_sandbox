connection: "thelook_events_redshift"

include: "basic_users.view"

view: users__control_dimension_group_drill {
  extends: [basic_users]

  dimension_group: created_custom {
    type: time
    timeframes: [
      year
      ,month
      ,date
      ]
    sql: ${created_raw} ;;
    # drill_fields: [created_custom_month]
  }
  dimension: created_custom_hour1 {
    # group_label: "Created Custom Date"
    # group_item_label: "Hour"
    type: date_hour
    sql:  ;;
  }

  dimension_group: created_custom2 {
    type: time
    timeframes: [
      year
      ,month
      ,date
      ,hour
    ]
    sql: ${created_raw} ;;
  }

  dimension: t {
    group_label: "1"
    sql: 't' ;;
  }
  dimension: y {
    group_label: "1"
    sql: 'y' ;;
  }
}

explore: users__control_dimension_group_drill {}
