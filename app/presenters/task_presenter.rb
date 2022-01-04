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
    # TODO: can implement separation actions by roles
    # TODO: move frontend elements (color, icon) to components
    [
      { name: :edit,    label: 'Edit',    color: 'green-5',  icon: 'edit' },
      { name: :archive, label: 'Archive', color: 'orange-5', icon: 'archive' },
      { name: :destroy, label: 'Delete',  color: 'red-5',    icon: 'delete' }
    ]
  end
end
