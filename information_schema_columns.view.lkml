# view: information_schema_columns {
#   sql_table_name:  information_schema.columns ;;
#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#
#   dimension: table_catalog {
#     type: string
#     sql: ${TABLE}.TABLE_CATALOG ;;
#   }
#
#   dimension: table_schema {
#     type: string
#     sql: ${TABLE}.TABLE_SCHEMA ;;
#   }
#
#   dimension: table_name {
#     type: string
#     sql: ${TABLE}.TABLE_NAME ;;
#   }
#
#   dimension: column_name {
#     type: string
#     sql: ${TABLE}.COLUMN_NAME ;;
#   }
#
#   dimension: ordinal_position {
#     type: number
#     sql: ${TABLE}.ORDINAL_POSITION ;;
#   }
#
#   dimension: column_default {
#     type: string
#     sql: ${TABLE}.COLUMN_DEFAULT ;;
#   }
#
#   dimension: is_nullable {
#     type: string
#     sql: ${TABLE}.IS_NULLABLE ;;
#   }
#
#   dimension: data_type {
#     type: string
#     sql: ${TABLE}.DATA_TYPE ;;
#   }
#
#   dimension: character_maximum_length {
#     type: number
#     sql: ${TABLE}.CHARACTER_MAXIMUM_LENGTH ;;
#   }
#
#   dimension: character_octet_length {
#     type: number
#     sql: ${TABLE}.CHARACTER_OCTET_LENGTH ;;
#   }
#
#   dimension: numeric_precision {
#     type: number
#     sql: ${TABLE}.NUMERIC_PRECISION ;;
#   }
#
#   dimension: numeric_scale {
#     type: number
#     sql: ${TABLE}.NUMERIC_SCALE ;;
#   }
#
#   dimension: datetime_precision {
#     type: number
#     sql: ${TABLE}.DATETIME_PRECISION ;;
#   }
#
#   dimension: character_set_name {
#     type: string
#     sql: ${TABLE}.CHARACTER_SET_NAME ;;
#   }
#
#   dimension: collation_name {
#     type: string
#     sql: ${TABLE}.COLLATION_NAME ;;
#   }
#
#   dimension: column_type {
#     type: string
#     sql: ${TABLE}.COLUMN_TYPE ;;
#   }
#
#   dimension: column_key {
#     type: string
#     sql: ${TABLE}.COLUMN_KEY ;;
#   }
#
#   dimension: extra {
#     type: string
#     sql: ${TABLE}.EXTRA ;;
#   }
#
#   dimension: privileges {
#     type: string
#     sql: ${TABLE}.PRIVILEGES ;;
#   }
#
#   dimension: column_comment {
#     type: string
#     sql: ${TABLE}.COLUMN_COMMENT ;;
#   }
#
#   dimension: generation_expression {
#     type: string
#     sql: ${TABLE}.GENERATION_EXPRESSION ;;
#   }
#
#   set: detail {
#     fields: [
#       table_catalog,
#       table_schema,
#       table_name,
#       column_name,
#       ordinal_position,
#       column_default,
#       is_nullable,
#       data_type,
#       character_maximum_length,
#       character_octet_length,
#       numeric_precision,
#       numeric_scale,
#       datetime_precision,
#       character_set_name,
#       collation_name,
#       column_type,
#       column_key,
#       extra,
#       privileges,
#       column_comment,
#       generation_expression
#     ]
#   }
#
#   parameter: select_table {
#     # suggest_explore: information_shcema_columns
#     suggest_dimension: table_name
#     type: unquoted
#   }
#
#   parameter: select_column {
#     # suggest_explore: information_shcema_columns
#     suggest_dimension: column_name
#     type: unquoted
#   }
#
#
#   dimension: selected_column {
#     sql: {% parameter select_table %}.{% parameter select_column %} ;;
#   }
# }
#
#
# view: leverage_params {
#   sql_table_name: public.{% parameter select_table %} ;;
#
#
#   parameter: select_table {
#     # suggest_explore: information_shcema_columns
# #     suggest_dimension: table_name
#     type: unquoted
#   }
#
#   parameter: select_column {
#     # suggest_explore: information_shcema_columns
# #     suggest_dimension: column_name
#     type: unquoted
#   }
#
#
#   dimension: selected_column {
#     label_from_parameter: select_column
#     sql: ${TABLE}.{% parameter select_column %} ;;
#   }
#   measure: count {
#     label: "Count Records"
#     type:count
#   }
#
#
# }
