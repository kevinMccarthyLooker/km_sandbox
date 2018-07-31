view: functions {
derived_table: {sql:select 1;;}
  dimension: functionA_parameterA {
    type: number
    sql: 1 ;;
  }
  dimension: functionA_parameterB {
    type: number
    sql: 2 ;;
  }

  dimension: functionA_result {
    type: number
    sql:  {{ functionA_parameterA._sql }} + {{ functionA_parameterB._sql }};;
  }

  dimension: function_add {
    type: number
    sql:  Replace_Parameter_1 + Replace_Parameter_2;;
  }

  dimension: safe_divide {
    type: number
    sql:  Replace_Parameter_1*1.0/nullif(Replace_Parameter_2,0);;
  }

}


view: function_use {
  dimension: combined_sales{
    type: number
    sql: {{ functions.function_add._sql | replace:'Replace_Parameter_1','4' | replace:'Replace_Parameter_2','5'}} ;;
  }
}
