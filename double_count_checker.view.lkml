view: double_count_checker {
  derived_table: {
    sql:
    SELECT
    users.id as users_id,
    COUNT(*) AS users_id_count,
    FROM public.order_items  AS order_items
    LEFT JOIN public.users  AS users ON users.id=order_items.user_id
    group by users.id
    ;;
  }
  dimension: users_id       {type:number  primary_key:yes }
  dimension: users_id_count {type:number                  }

}
