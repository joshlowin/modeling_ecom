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

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
#parameterize the below measures
  measure: max_retail_price {
    type: max
    drill_fields: [retail_price, brand, id]
    sql: ${retail_price} ;;
  }

  measure: min_retail_price {
    type: min
    drill_fields: [retail_price, brand, id]
    sql: ${retail_price} ;;
  }

  measure: average_retail_price {
    type: average
    drill_fields: [retail_price, brand, id]
    sql: ${retail_price} ;;
  }

}
