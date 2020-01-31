connection: "snowlooker"

include: "basic_users*.view.lkml"                # include all views in the views/ folder in this project

view: snowflake_test {
  extends: [basic_users]

}

view: snowflake_derived_view_persistence_parameters_test {
  derived_table: {
    sql: select age,max(id) as max_id from ${snowflake_test.SQL_TABLE_NAME} group by age ;;
    # indexes: ["max_id"]
    # sortkeys: ["max_id"]
    # distribution: "age"
    # distribution_style: all
    # cluster_keys: ["max_id"]
    # persist_for: "1 hour"
    # partition_keys: ["max_id"]
  }
 dimension: age {type:number}
  dimension: max_id {type:number}
}
explore: snowflake_derived_view_persistence_parameters_test {}
