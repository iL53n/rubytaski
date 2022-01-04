class GoalPresenter < BasePresenter
  attr_reader :resource

  delegate :id, :state, :start_date, :due_date, :number_of_stars, :prize, to: :resource

  COLUMNS = [
    { name: :id,              field: :id,              required: true, label: 'ID',              align: 'left', sortable: true },
    { name: :start_date,      field: :start_date,      required: true, label: 'START DATE',      align: 'left', sortable: true },
    { name: :due_date,        field: :due_date,        required: true, label: 'DUE DATE',        align: 'left', sortable: true },
    { name: :number_of_stars, field: :number_of_stars, required: true, label: 'NUMBER OF STARS', align: 'left', sortable: true },
    { name: :prize,           field: :prize,           required: true, label: 'PRIZE',           align: 'left', sortable: false },
    { name: :state,           field: :state,           required: true, label: 'STATE',           align: 'left', sortable: true },
    { name: :actions,         field: :actions,                         label: 'ACTION',          align: 'left' }
  ]

  def columns
    COLUMNS
  end

  def columns_keys
    columns.map { |column| column[:name] }
  end

  def actions
    [
      { name: :edit,    label: 'Edit',    color: 'green-5',  icon: 'edit' },
      { name: :archive, label: 'Archive', color: 'orange-5', icon: 'archive' },
      { name: :destroy, label: 'Delete',  color: 'red-5',    icon: 'delete' }
    ]
  end
end
