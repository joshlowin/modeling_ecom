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
