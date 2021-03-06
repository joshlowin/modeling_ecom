connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: users_datagroup {
  sql_trigger: SELECT MAX(id) FROM users;;
  max_cache_age: "4 hour"
}

persist_with: users_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  sql_always_where: ${created_date} >= '2014-01-01';;
  join: products {
    type: left_outer
    fields: [products.id, products.retail_price, products.brand, products.item_name, products.category]
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_many
  }
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${inventory_items.id}  = ${order_items.inventory_item_id};;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
    relationship: one_to_one
  }
}

explore: products {
  join: inventory_items {
    type: inner
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: one_to_many
  }
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  persist_with: users_datagroup #I think is is redundant
  view_label: "The Sheeple's Shearings"
  always_filter: {
    filters: {
      field: state
      value: "California"
    }
    filters: {
      field: state
      value: "New York"
    }
  }
  join: orders {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: one_to_many
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${inventory_items.id} = ${order_items.id} ;;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
    relationship: one_to_one
  }
  join: user_data {
    type: left_outer
    sql_on: ${user_data.id} = ${users.id} ;;
    relationship: one_to_one
  }
  join: users_nn {
    type: left_outer
    sql_on: ${users_nn.id} = ${users.id} ;;
    relationship: one_to_one
  }
}

explore: users_nn {}
