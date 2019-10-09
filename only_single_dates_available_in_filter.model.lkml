connection: "thelook_events_redshift"

include: "basic_users.*"

view:  only_single_dates_available_in_filter{
  extends: [basic_users]
  # dimension: special_date_filter {
  #   type: string
  #   case: {
  #   when: {label:"2019-01-01" sql:'2019-01-01';;}
  #   when: {label:"2019-01-02" sql:'2019-01-02';;}
  #   when: {label:"2019-01-03" sql:'2019-01-03';;}
  #   }
  # }
  parameter:special_date_filter {
    allowed_value: {value:"2019-01-01"}
    allowed_value: {value:"2019-01-02"}
    allowed_value: {value:"2019-01-03"}
  }


}

explore: only_single_dates_available_in_filter {
  sql_always_where: {%condition only_single_dates_available_in_filter.special_date_filter %}${only_single_dates_available_in_filter.created_date}{%endcondition%} ;;
  # sql_always_where: {%condition only_single_dates_available_in_filter.created_date %}${only_single_dates_available_in_filter.special_date_filter}{%endcondition%} ;;
}
