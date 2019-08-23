connection: "thelook_events_redshift"

include: "basic*.view"

view: basic_users_alert_testing2 {
  extends: [basic_users]
  #forces the trigger query to get pulled into the query
  filter: apply_trigger1 {
    type: yesno
    #main query will only return data if there were matching rows in the trigger query (otherwise resolves to null instead of true
    sql:(select max(1) from ${trigger1_query.SQL_TABLE_NAME});;#NOTE : FIRES EVEN IF NO IS SELECTED
  }
  filter: apply_trigger2 {
    type: yesno
    sql:(select max(1) from ${trigger2_query.SQL_TABLE_NAME});;
  }
  filter: apply_trigger3 {
    label: "trigger: any age has over 2000 users"
    description: "Kevin's First Trigger"
    type: yesno
    sql:(select max(1) from ${trigger3_query.SQL_TABLE_NAME});;
  }
  dimension: c {
    case: {
      when:{
        label: "1"
        sql: (select max(1) from ${trigger2_query.SQL_TABLE_NAME}) ;;
      }
    }
  }
}

view: trigger1_query {
  derived_table: {
    explore_source: basic_users_alert_testing2 {
      column: count {}
      filters: {
        field: basic_users_alert_testing2.age
        value: ">20"
      }
      filters: {
        field: basic_users_alert_testing2.count
        value: ">10000"
      }
    }
  }
}

view: trigger2_query {
  derived_table: {
    explore_source: basic_users_alert_testing2 {
      column: count {}
      filters: {
        field: basic_users_alert_testing2.age
        value: ">40"
      }
      filters: {
        field: basic_users_alert_testing2.count
        value: ">1000000"
      }
    }
  }
}

view: trigger3_query {
  derived_table: {
    explore_source: basic_users_alert_testing2 {
      column: count {}
      column: age {}
      filters: {
        field: basic_users_alert_testing2.count
        value: ">2000"
      }
    }
  }
  dimension: count {
    type: number
  }
  dimension: age {
    type: number
  }
}

view: trigger4_query {
  derived_table: {
    explore_source: basic_users_alert_testing2 {
      column: count {}
      column: age {}
      filters: {
        field: basic_users_alert_testing2.count
        value: ">2000"
      }
    }
  }
  dimension: count {
    type: number
  }
  dimension: age {
    type: number
  }
  dimension: join {
    sql: ${age}=${basic_users_alert_testing2.age} ;;
  }
  dimension: x {sql:true;;}
  filter: f {
    # type: yesno
    type: string

    # sql: 'Yes' ;;
  }
  parameter: p {
    allowed_value: {
      label: "Yes"
      value: "Yes"
    }
  }
}

view: alert_selector {
  parameter: alert_select {
    allowed_value: {
      label: "1"
      value: "1"
    }
  }
  dimension: apply_alert {
    type: yesno
    sql:
(
{% if alert_select._parameter_value == '' %}true
{% elsif alert_select._parameter_value == '1' %}${trigger4_query.x}=true
{%endif%}
)
    ;;
  }
}

explore: basic_users_alert_testing2 {
  # always_join: [trigger1]
  join: trigger1_query {sql:;; relationship: one_to_one}
  join: trigger2_query {sql:;; relationship: one_to_one}
  join: trigger3_query {sql:;; relationship: one_to_one}
  join: trigger4_query {
    sql_on: ${trigger4_query.join} ;;
    type: inner
    relationship: one_to_one
  }
  join: alert_selector {sql:;; relationship:one_to_one}
}

  # join: trigger1 {from:trigger_placeholder sql_table_name:(select 1);;}
  # sql_always_where: 1=1 ;; #override the sql_always_where to avoid circular reference

  # {% if basic_users_alert_testing2.custom_trigger._parameter_value == "'trigger1'" %}
  #   (SELECT count(*) FROM public.users)>10000
  # {% elsif basic_users_alert_testing2.custom_trigger._parameter_value == "'trigger2'" %}
  #   (SELECT count(*) FROM public.users)>100000
  # {% elsif basic_users_alert_testing2.custom_trigger._parameter_value == "'trigger3'" %}
  #   (select triggered from trigger1_query)
  # {%else%}
  #   true
  # {%endif%}

#   sql_always_where:
#   /* marker */

#   {% if basic_users_alert_testing2.custom_trigger._parameter_value == "'trigger1'" %}
#     (SELECT count(*) FROM public.users)>10000
#   {% elsif basic_users_alert_testing2.custom_trigger._parameter_value == "'trigger2'" %}
#     (SELECT count(*) FROM public.users)>100000
#   {% elsif basic_users_alert_testing2.custom_trigger._parameter_value == "'trigger3'" %}
#     (select triggered from trigger1_query)
#     --${trigger1.count}--reference to trigger1 to force the trigger query to happen in a with clause
#   {%else%}
#     true
#   {%endif%}
# ;;
#${trigger1.SQL_TABLE_NAME}

#   join: trigger1_query {sql_on:1=1 /*${trigger1_query.SQL_TABLE_NAME}*/;;relationship:one_to_one}
#   always_join: [trigger1_query]
# sql_always_where: select triggered from trigger1_query ;;

  # #use parameter for superior UI
  # parameter: custom_trigger {
  #   allowed_value: {
  #     label: "Kevin's Trigger1 - User Count>10000"
  #     value: "trigger1"
  #   }
  #   allowed_value: {
  #     label: "Kevin's Trigger2 - User Count>100000"
  #     value: "trigger2"
  #   }
  #   allowed_value: {
  #     label: "Kevin's Trigger3 - ..."
  #     value: "trigger3"
  #   }
  # }

  # explore: trigger_holder_explore {
#   from:  basic_users_alert_testing2
#   extends: [basic_users_alert_testing2]
#   # always_join: []
# }
