view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }

  measure: max_retail_price {
    type: max
    drill_fields: [retail_price, brand, id]
    sql: ${retail_price} ;;
  }

  measure: max_cost {
    type: max
    drill_fields: [cost, brand, id]
    sql: ${cost} ;;
  }

  measure: min_retail_price {
    type: min
    drill_fields: [retail_price, brand, id]
    sql: ${retail_price} ;;
  }

  measure: min_cost {
    type: min
    drill_fields: [cost, brand, id]
    sql: ${cost} ;;
  }

  measure: average_retail_price {
    type: average
    drill_fields: [retail_price, brand, id]
    sql: ${retail_price} ;;
  }

  measure: average_cost {
    type: average
    drill_fields: [cost, brand, id]
    sql: ${cost} ;;
  }
}
