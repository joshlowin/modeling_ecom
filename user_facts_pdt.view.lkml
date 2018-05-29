view: user_facts_pdt {
    derived_table: {
      sql: SELECT
      ${TABLE}.id AS user_id,
      MIN(DATE(${TABLE}.created)) AS first_order,
      MAX(DATE(${TABLE}.created)) AS latest_order,
      DATEDIFF(day, first_order, latest_order) AS days_since_first_purchase,
      CASE
      WHEN COUNT(${TABLE}.user_id > 1 THEN "yes"
      WHEN COUNT(${TABLE}.user_id = 1 THEN "no"
      ELSE "no orders" END AS repeat_customer,
      ROUND(COUNT(${TABLE}.user_id)/DATEDIFF(month, first_order, latest_order),1.0) AS average_orders_per_month
      FROM ${TABLE}
      GROUP BY user_id;;
    }

    dimension: user_id {
      type: number
      sql: ${TABLE}.id ;;
    }
    dimension: first_order {
      type: date
      sql: MIN(DATE(${TABLE}.created)) ;;
    }
    dimension: latest_order {
      type: date
      sql: MAX(DATE(${TABLE}.created ;;
    }
    dimension: days_since_first_purchase {
      type: number
      sql:  DATEDIFF(day, first_order, latest_order) ;;
    }
    dimension: repeat_customer {
      type: yesno
      sql: COUNT(${TABLE}.user_id > 1 ;;
    }
    measure: average_orders_per_month {
      type: number
      sql:  ROUND(COUNT(${TABLE}.user_id)/DATEDIFF(month, first_order, latest_order),1.0) ;;
    }
  }
