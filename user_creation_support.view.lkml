view: user_creation_support {
  derived_table: {
#     sql: select {% parameter user_creation_support.input_string %}::varchar as value;;
    sql: select '1' as value ;;
  }
  parameter: input_string {type:string}
  dimension: value {sql:{% parameter input_string %};;}
  dimension: nothing {sql:1;;}
}
