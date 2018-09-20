view: users_for_window_fun {
  sql_table_name: users ;;

  dimension: id {type: number}
  dimension: first_name {  }
  dimension: last_name {  }
  dimension: email {  }
  dimension: age {  }
  dimension: city {  }
  dimension: state {  }
  dimension: country {  }
  dimension: zip {  }
  dimension: gender {}
  dimension: created_at_date {type: date sql: ${TABLE}.created_at ;;}
  dimension: traffic_source {  }

###measures
  measure: count {type: count}


##special fields
#.... seems there's no way to gaurantee that we match the order that query has been sorted
  dimension: order_by_sql {
    sql:
    {% assign order_by_string = ' order by ' %}
    {% if users_for_window_fun.id._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.id._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.first_name._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.first_name._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.last_name._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.last_name._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.email._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.email._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.age._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.age._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.city._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.city._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.state._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.state._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.country._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.country._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.zip._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.zip._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.latitude._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.latitude._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.longitude._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.longitude._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.gender._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.gender._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.created_at._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.created_at._sql | append: ',' %}{% endif %}
    {% if users_for_window_fun.traffic_source._is_selected %}{% assign order_by_string = order_by_string | append: users_for_window_fun.traffic_source._sql | append: ',' %}{% endif %}

    {% assign order_by_string_size = order_by_string | size | minus: 1 %}
    {% assign order_by_string = order_by_string | slice: 0, order_by_string_size %}
    {% if order_by_string == ' order by' %}{% assign order_by_string = '' %}{% endif %}
    {{order_by_string}}
    ;;
  }

}
