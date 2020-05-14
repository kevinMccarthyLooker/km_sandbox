connection: "thelook_events_redshift"

include: "/basic_users.view"

view: different_customizations_different_customers {
  extends: [basic_users]
}

view: customer_1_custom_fields {}
