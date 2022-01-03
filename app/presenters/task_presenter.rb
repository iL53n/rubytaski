class TaskPresenter < BasePresenter
  attr_reader :resource

  delegate :id, :title, :description, to: :resource

  COLUMNS = [ 
    { name: :id,          field: :id,          required: true,  label: 'ID',          align: 'left', sortable: true },
    { name: :title,       field: :title,       required: true,  label: 'TITLE',       align: 'left', sortable: true },
    { name: :description, field: :description, required: false, label: 'DESCRIPTION', align: 'left', sortable: false },
    { name: :actions,     field: :actions,                      label: 'ACTION',      align: 'left' }
  ]

  def columns
    COLUMNS
  end

  def columns_keys
    columns.map { |column| column[:name] }
  end

  def actions
    [
      { name: :edit, label: 'Edit' },
      { name: :destroy, label: 'Delete' }
    ]
  end
end
