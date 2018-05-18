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
