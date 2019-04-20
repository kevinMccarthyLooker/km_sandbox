connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# view: function__multiplier__numberA__numberB {
#   dimension: numberA {sql:1;;}
#   dimension: numberB {sql:2;;}
#   dimension: number_output {sql:${numberA}*${numberB};;}
# }

view: function__safe_divide {
## EXPLAIN FUNCTION: function takes numerator and denominator numeric inputs. Avoids truncation and division by zero errors.
# COPY BELOW THEN UN-COMMENT FIRST TWO LINES
#   extends: [function__safe_divide]
#   dimension: function__safe_divide__output {}#use "sql:${function__safe_divide__output};;" as the sql paramater of the field you want the answer to go in
  dimension: numerator_field {sql:__REPLACE_ME__;;hidden:yes}
  dimension: denominator_field {sql:__REPLACE_ME__;;hidden:yes}

# actual work of the calculation done here
  dimension: function__safe_divide__output {sql:1.0*${numerator_field}/nullif(${denominator_field},0);;}
}

view: function__random_number_between_1_and__X {
## EXPLAIN FUNCTION: random integer between 1 and X minus 1
#   extends: [function__random_number_between_1_and__X]
#   dimension: function__random_number_between_1_and__X__output {} #answer field
  dimension: X {sql:__REPLACE_ME__;;hidden:yes}

# actual work of the calculation done here
  dimension: function__random_number_between_1_and__X__output {sql:cast (random() * ${X} as int);;}
}



view: test_use_functions{
  sql_table_name: public.users ;;
  dimension: age {type:number}
  dimension: id {}

#   extends: [function__multiplier__numberA__numberB]
#   dimension: numberA {sql:2;;}
#   dimension: numberB {sql:3;;}
#   dimension: number_output {}

#I know the input columns and I want to put the answer in my_EZ field...
  dimension: my_EZ_calculated_field {sql:${function__safe_divide__output};;}
#paste from function definition.
  extends: [function__safe_divide]
  dimension: function__safe_divide__output {}#use "sql:${function__safe_divide__output};;" as the sql paramater of the field you want the answer to go in
  dimension: numerator_field {sql:${age};;hidden:yes}
  dimension: denominator_field {sql:${id};;hidden:yes}

  dimension: random_number_up_to_my_age{
    type:number
    sql:${function__random_number_between_1_and__X__output};; #slap my output field in here
  }
## EXPLAIN FUNCTION: random integer between 1 and X minus 1
  extends: [function__random_number_between_1_and__X]
  dimension: function__random_number_between_1_and__X__output {} #answer field
  dimension: X {sql:${age};;hidden:yes} #updated the sql parameter here
  measure: count {type:count}

}

explore: test_use_functions {}
