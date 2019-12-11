connection: "thelook_events_redshift"

view: liquid_looping_on_users_data {
  sql_table_name: public.users ;;

## basic fields {
  dimension: id {primary_key: yes}
  dimension: age {type: number}
  dimension: city {}
  dimension: country {map_layer_name: countries}
  dimension_group: created {
    type: time
    timeframes: [raw,time,date,week,month,quarter,year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {}
  dimension: first_name {}
  dimension: gender {}
  dimension: last_name {}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: state {map_layer_name:us_states}
  dimension: traffic_source {}
  dimension: zip {type: zipcode}
  measure: count {type:count}
##} end basic fields

  # will use count measures for simplicity. Focusing on liquid in HTML
  measure: s1_creating_any_variable {type: count
    html:
    {% comment %}
      This is liquid comment syntax
      Let's create a variable to do examples on.  Most often, you'll do similar logic but set variables to (or use directly) looker's liquid variables: value/other_field._value, rendered_value/other_field._rended_value,link/other_field._link
      This example could easily come from a listagg type field, and it would be useful to iterate through values
    {% endcomment %}
    {% assign my_example_variable  = '2000,2004,2019' %}
    when testing, literal text note can help trouble shooting the dynamic content: {{my_example_variable}}
<br>
    {% comment %}
      Let's say we want to make leap years blue
      We want to break the values appart an check each individually
      Create arrays from strings, by using the split liquid function
    {% endcomment %}
    {% assign years_array = my_example_variable | split: ','%}
    years is now an array of the values between the commas: {{years_array}}
<br>
    note: reference specific elements of an array as follows: 1st:{{years_array[0]}}, 2nd:{{years_array[1]}},etc. or also there's this: {{years_array.last}}
<br>
    {% comment %}
      we can iterate through the array directly with a for loop as follows
      we are creating a new variable which will be set to the next element automatically on each iteration of the array
    {% endcomment %}
    {% for year in years_array %}
      This array element is:{{year}}.
      {% if year == '2004' or year == '2008' or year == '2012' or year == '2016' or year == '2020' %}
        <font color='blue'>{{year}}</font>
      {%else%}
        <font color='red'>{{year}}</font>
      {%endif%}
    {% endfor %}
<br>
    {% comment %}
      can also generate a loop that runs on an iterating counter
      could use this to fill missing values, etc
    {% endcomment %}
    Years List
    {% for another_year_variable in (2000..2020) %}
      <br>this iteration value:{{another_year_variable}}.
    {%endfor%}
<br>
    {% assign green_value = 0 %}
    {% assign blue_value = 0 %}
    {% for green_value in (1..25)%}
      {% for blue_value in (1..25)%}<span style='background-color:rgb(125,{{green_value |times:10}},{{blue_value | times:10}})'>-</span>{%endfor%}
      <br>
    {%endfor%}



    ;;
  }

#
}

explore: liquid_looping_on_users_data {}
