view: access_token {
  derived_table: {
    sql: select * from access_token
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: resource_owner_id {
    type: number
    sql: ${TABLE}.RESOURCE_OWNER_ID ;;
  }

  dimension: role_id {
    type: number
    sql: ${TABLE}.ROLE_ID ;;
  }

  dimension: grant_type {
    type: string
    sql: ${TABLE}.GRANT_TYPE ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension: credentials_api3_id {
    type: number
    sql: ${TABLE}.CREDENTIALS_API3_ID ;;
  }

  dimension: encrypted_code {
    type: string
    sql: ${TABLE}.ENCRYPTED_CODE ;;
  }

  dimension: encrypted_token {
    type: string
    sql: ${TABLE}.ENCRYPTED_TOKEN ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: expires_at {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension: workspace_id {
    type: string
    sql: ${TABLE}.WORKSPACE_ID ;;
  }

  dimension: user_overrides_workspace {
    type: string
    sql: ${TABLE}.USER_OVERRIDES_WORKSPACE ;;
  }

  set: detail {
    fields: [
      id,
      user_id,
      resource_owner_id,
      role_id,
      grant_type,
      session_id,
      credentials_api3_id,
      encrypted_code,
      encrypted_token,
      created_at_time,
      expires_at_time,
      workspace_id,
      user_overrides_workspace
    ]
  }
}
