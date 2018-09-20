view: user_creation_support2 {
  derived_table: {
#     sql: select {% parameter user_creation_support.input_string %}::varchar as value;;
  sql: select '1' as value ;;
}
parameter: input_string {type:string}
dimension: nothing {sql:1;;}
dimension: value {sql: {% parameter input_string %};;
#   html: Hello and welcome please go to {{value}};;
  html: <a href="https://profservices.dev.looker.com/account/setup/{{value}}">Complete Account Activation</a> ;;

  }
}
