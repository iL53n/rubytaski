class TaskPresenter < BasePresenter
  attr_reader :resource

  delegate :id, :title, :description, :state, :order, to: :resource

  COLUMNS = [ 
    { name: :id,          field: :id,          required: true,  label: 'ID',          align: 'left', sortable: true },
    { name: :order,       field: :order,       required: true,  label: '#',           align: 'left', sortable: true },
    { name: :title,       field: :title,       required: true,  label: 'TITLE',       align: 'left', sortable: true },
    { name: :description, field: :description, required: false, label: 'DESCRIPTION', align: 'left', sortable: false },
    { name: :state,       field: :state,       required: true,  label: 'STATE',       align: 'left', sortable: true },
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
      { kind: 'all',      name: :edit,      label: 'Edit',      color: 'orange-5', icon: 'edit' },
      { kind: 'active',   name: :archive,   label: 'Archive',   color: 'brown-5',  icon: 'archive' },
      { kind: 'unactive', name: :unarchive, label: 'Unarchive', color: 'info',     icon: 'unarchive' },
      { kind: 'all',      name: :destroy,   label: 'Delete',    color: 'red-5',    icon: 'delete' }
    ]
  end
end
