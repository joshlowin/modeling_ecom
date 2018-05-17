view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: sale_price_category {
    case: {
      when: {
        sql: ${sale_price} <= 15 ;;
        label: "Lil-money"
      }
      when: {
        sql: ${sale_price} > 15 AND ${sale_price} <= 50;;
        label: "mid-money"
      }
      when: {
        sql: ${sale_price} > 50;;
        label: "big-money"
      }
      else: "other-money"
    }
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  measure: max {
    type: max
    drill_fields: [sale_price]
  }

  measure: min {
    type: min
    drill_fields: [sale_price]
  }

  measure: average {
    type: average
    drill_fields: [sale_price]
  }
}
