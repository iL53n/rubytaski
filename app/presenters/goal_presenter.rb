class GoalPresenter < BasePresenter
  attr_reader :resource

  delegate :id, :state, :start_date, :due_date, :number_of_stars, :prize, to: :resource

  COLUMNS = [
    # { name: :id,              field: :id,              required: true, label: 'ID',              align: 'left', sortable: true },
    { name: :start_date,      field: :start_date,      required: true, label: 'Start Date', align: 'left', sortable: true, style: 'width: 105px' },
    { name: :due_date,        field: :due_date,        required: true, label: 'Due Date',   align: 'left', sortable: true, style: 'width: 105px' },
    { name: :number_of_stars, field: :number_of_stars, required: true, label: 'Stars',      align: 'left', sortable: true },
    { name: :prize,           field: :prize,           required: true, label: 'Prize',      align: 'left', sortable: false },
    { name: :state,           field: :state,           required: true, label: 'State',      align: 'left', sortable: true },
    { name: :actions,         field: :actions,                         label: 'Action',     align: 'left' }
  ].freeze

  def columns
    COLUMNS
  end

  def columns_keys
    columns.map { |column| column[:name] }
  end

  def actions
    [
      { kind: 'active',   name: :done,      label: 'Done',      color: 'green-5',  icon: 'check_circle' },
      { kind: 'all',      name: :edit,      label: 'Edit',      color: 'orange-5', icon: 'edit' },
      { kind: 'active',   name: :archive,   label: 'Archive',   color: 'brown-5',  icon: 'archive' },
      { kind: 'unactive', name: :unarchive, label: 'Unarchive', color: 'info',     icon: 'unarchive' },
      { kind: 'all',      name: :destroy,   label: 'Delete',    color: 'red-5',    icon: 'delete' }
    ]
  end
end
