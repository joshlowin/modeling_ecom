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
        label: "lil-money"
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

  measure: max_sale_price {
    type: max
    drill_fields: [sale_price, id, inventory_items.id, orders.id]
    sql: ${sale_price} ;;
  }

  measure: min_sale_price {
    type: min
    drill_fields: [sale_price, id, inventory_items.id, orders.id]
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    drill_fields: [sale_price, id, inventory_items.id, orders.id]
    sql: ${sale_price} ;;
    value_format: "$#.00;($#.00)" #accounting negatives
  }
#this is redundant because it returns strings - use above measure ^^
#  measure: average_sale_price_category {
#    type: average
#    drill_fields: [sale_price_category, sale_price, id, inventory_items.id, orders.id]
#    sql: ${sale_price_category} ;;
#  }
}
