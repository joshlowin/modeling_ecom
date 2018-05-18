- dashboard: modeling_ecom_base_dash
  title: 'Modeling Ecom Base Dash'
  description: 'I kinda know what I am doing'
  layout: newspaper
  show_applied_filters: true
  refresh: 1 day
  auto_run: true

  filters:

  - name: global filter one
    title: In America
    type: field_filter
    default_value: USA
    required: false
    model: modeling_ecom
    explore: users
    listens_to_filters: []
    field: users.country

  elements:
    - name: user_count
      type: single_value
      model: modeling_ecom
      explore: users
      measures: [users.count]

    - name: Age and Gender in Texas and Washington
      model: modeling_ecom
      explore: users
      type: looker_column
      fields:
        - users.age_tier
        - users.count
        - users.gender
      pivots:
        - users.gender
      fill_fields:
        - users.age_tier
      filters:
        users.state: Texas,Washington
      sorts:
        - users.gender 0
        - users.age_tier
      stacking: "
      show_value_labels: true
      label_density: 25
      legend_position: right
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      x_axis_reversed: false
      y_axis_reversed: false
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhoutette: false
      totals_color: "#808080"
      colors:
        - 'palette: Santa Cruz'
      series_colors: []
      listen:
        global filter one: users.country

    - name: Highest Relative Profit by Brand
      model: modeling_ecom
      explore: order_items
      type: looker_pie
      fields:
        - products.brand
        - order_items.average_relative_profit
      sorts:
        - order_items.average_relative_profit desc
      limit: 10
      value_labels: legend
      label_type: labPer
      stacking: "
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_lables: true
      show_y_axis_ticks: true
      y_axis_tick_denisty: default
      y_axis_tick_denisty_custom: 5
      show_x_axis_labels: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      show_null_points: true
      point_style: circle
      interpolation: linear
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      ordering: none
      show_null_labels: false
      series_types: []
      colors:
        - 'palette: Random'
      series_colors: []
      listen:
        global filter one: users.country
