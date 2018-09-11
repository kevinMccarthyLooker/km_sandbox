connection: "looker"

label: "ilooker"

# include all the views
include: "*.view"

# include all the dashboards
# include: "*.dashboard"

explore: access_token {}

# explore: content_ranking_new {
#   hidden: yes
#
#   join: group {
#     sql_on: ${group.id} = ${content_ranking_new.group_id} ;;
#     relationship: many_to_one
#     fields: [name]
#   }
# }
#
# explore: content_ranking {
#   hidden: yes
# }
#
# explore: dashboard_layout_component {
#   label: "Dashboard"
#   hidden: yes
#
#   join: dashboard_layout {
#     foreign_key: dashboard_layout_id
#   }
#
#   join: dashboard_element {
#     foreign_key: dashboard_element_id
#   }
#
#   join: dashboard {
#     foreign_key: dashboard_layout.dashboard_id
#   }
#
#   join: space {
#     foreign_key: dashboard.space_id
#   }
#
#   join: user {
#     foreign_key: dashboard.user_id
#   }
#
#   join: role_user {
#     sql_on: role_user.user_id = user.id ;;
#     relationship: one_to_many
#     fields: []
#   }
#
#   join: role {
#     foreign_key: role_user.role_id
#   }
#
#   join: look {
#     foreign_key: dashboard_element.look_id
#   }
#
#   join: query {
#     foreign_key: look.query_id
#   }
# }
#
# explore: db_connection {
#   hidden: yes
#   fields: [ALL_FIELDS*, -user.roles]
#
#   join: user {
#     foreign_key: user_id
#   }
# }
#
# explore: event {
#   hidden: yes
#
#   join: user {
#     foreign_key: user_id
#   }
#
#   join: role_user {
#     sql_on: role_user.user_id = user.id ;;
#     relationship: one_to_many
#     fields: []
#   }
#
#   join: role {
#     foreign_key: role_user.role_id
#   }
# }
#
# explore: event_attribute {
#   hidden: yes
#
#   join: event {
#     foreign_key: event_id
#   }
#
#   join: user {
#     foreign_key: event.user_id
#   }
#
#   join: role_user {
#     sql_on: role_user.user_id = user.id ;;
#     relationship: one_to_many
#     fields: []
#   }
#
#   join: role {
#     foreign_key: role_user.role_id
#   }
# }
#
# explore: field_usage {
#   hidden: yes
# }
#
# explore: history {
# #   hidden: yes
#
# join: look {
#   foreign_key: look_id
# }
#
# join: query {
#   foreign_key: query_id
# }
#
# join: user {
#   foreign_key: user_id
# }
#
# join: space {
#   foreign_key: look.space_id
# }
#
# join: role_user {
#   sql_on: history.user_id = role_user.user_id ;;
#   relationship: many_to_one
#   fields: []
# }
#
# join: user_direct_role {
#   relationship: one_to_many
#   sql_on: ${user.id} = ${user_direct_role.user_id} ;;
#   fields: []
# }
#
# join: group_user {
#   relationship: one_to_many
#   sql_on: ${user.id} = ${group_user.user_id} ;;
#   fields: []
# }
#
# join: group {
#   relationship: one_to_many
#   sql_on: ${group.id} = ${group_user.group_id} ;;
# }
#
# join: role_group {
#   relationship: one_to_many
#   sql_on: ${role_group.group_id} = ${group_user.group_id} ;;
#   fields: []
# }
#
# join: role {
#   relationship: one_to_many
#   sql_on: ${role.id} = ${user_direct_role.role_id} or ${role_group.role_id} = ${role.id} ;;
# }
#
# join: permission_set {
#   foreign_key: role.permission_set_id
# }
#
# join: model_set {
#   foreign_key: role.model_set_id
# }
#
# join: dashboard {
#   relationship: many_to_one
#   sql_on: ${history.dashboard_id} = ${dashboard.id} ;;
# }
#
# join: dashboard_element {
#   relationship: one_to_many
#   sql_on: ${dashboard.id} = ${dashboard_element.dashboard_id} ;;
# }
#
# join: credentials_api {
#   sql_on: ${user.id} = credentials_api.user_id ;;
#   relationship: many_to_one
# }
#
# join: credentials_api3 {
#   sql_on: ${user.id} = credentials_api3.user_id ;;
#   relationship: many_to_one
# }
#
# join: sql_text {
#   sql_on: ${history.cache_key} = ${sql_text.cache_key} ;;
#   relationship: many_to_one
# }
# }
#
# explore: look {
# #   hidden: yes
# fields: [ALL_FIELDS*, -user.roles]
#
# join: user {
#   foreign_key: user_id
# }
#
# join: role_user {
#   sql_on: role_user.user_id = user.id ;;
#   relationship: one_to_many
#   fields: []
# }
#
# join: role {
#   foreign_key: role_user.role_id
# }
#
# join: query {
#   foreign_key: query_id
# }
#
# join: space {
#   foreign_key: space_id
# }
# }
#
# explore: scheduled_task {
# #   hidden: yes
# fields: [ALL_FIELDS*, -user.roles, -sta_user.roles]
#
# join: user {
#   foreign_key: user_id
# }
#
# join: scheduled_task_action_email {
#   sql_on: scheduled_task_action_email.scheduled_task_id = scheduled_task.id
#       AND scheduled_task_action_email.deleted_at IS NULL
#        ;;
#   relationship: one_to_many
# }
#
# join: sta_user {
#   from: user
#   foreign_key: scheduled_task_action_email.user_id
# }
#
# join: scheduled_task_look {
#   sql_on: scheduled_task_look.scheduled_task_id = scheduled_task.id
#       AND scheduled_task.type = 'look'
#        ;;
#   relationship: one_to_one
# }
#
# join: look {
#   foreign_key: scheduled_task_look.look_id
# }
#
# join: space {
#   foreign_key: look.space_id
# }
#
# join: query {
#   foreign_key: look.query_id
# }
# }
#
# explore: scheduled_task_dashboard {
#   hidden: yes
#   fields: [ALL_FIELDS*, -user.roles, -sta_user.roles]
#
#   join: scheduled_task {
#     sql_on: scheduled_task_dashboard.scheduled_task_id = scheduled_task.id
#       AND scheduled_task.type = 'dashboard' AND scheduled_task.deleted_at IS NULL
#        ;;
#     relationship: one_to_one
#   }
#
#   join: scheduled_task_action_email {
#     sql_on: scheduled_task_action_email.scheduled_task_id = scheduled_task.id
#       AND scheduled_task_action_email.deleted_at IS NULL
#        ;;
#     relationship: one_to_many
#   }
#
#   join: sta_user {
#     from: user
#     foreign_key: scheduled_task_action_email.user_id
#   }
#
#   join: dashboard {
#     foreign_key: scheduled_task_dashboard.dashboard_id
#   }
#
#   join: user {
#     foreign_key: scheduled_task.user_id
#   }
#
#   join: role_user {
#     sql_on: role_user.user_id = user.id ;;
#     relationship: one_to_many
#     fields: []
#   }
#
#   join: role {
#     foreign_key: role_user.role_id
#   }
#
#   join: space {
#     foreign_key: dashboard.space_id
#   }
# }
#
# explore: session {
#   hidden: yes
#
#   join: user {
#     foreign_key: user_id
#   }
#
#   join: access_token {
#     foreign_key: access_token_id
#   }
#
#   join: role {
#     foreign_key: access_token.role_id
#   }
#
#   join: credentials_api3 {
#     foreign_key: access_token.credentials_api3_id
#   }
#
#   join: permission_set {
#     foreign_key: role.permission_set_id
#   }
#
#   join: model_set {
#     foreign_key: role.model_set_id
#   }
# }
#
# explore: user {
# #   hidden: yes
#
# join: credentials_api {
#   sql_on: user.id = credentials_api.user_id ;;
#   relationship: one_to_one
# }
#
# join: credentials_api3 {
#   sql_on: user.id = credentials_api3.user_id ;;
#   relationship: one_to_one
# }
#
# join: role_user {
#   sql_on: role_user.user_id = user.id ;;
#   relationship: one_to_many
#   fields: []
# }
#
# join: role {
#   foreign_key: role_user.role_id
# }
#
# join: permission_set {
#   foreign_key: role.permission_set_id
# }
# }
#
# explore: user_access_filter {
#   hidden: yes
#
#   join: user {
#     foreign_key: user_id
#   }
#
#   join: role_user {
#     sql_on: role_user.user_id = user.id ;;
#     relationship: one_to_many
#     fields: []
#   }
#
#   join: role {
#     foreign_key: role_user.role_id
#   }
# }
