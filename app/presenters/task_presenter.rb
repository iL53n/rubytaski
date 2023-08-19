class TaskPresenter < BasePresenter
  attr_reader :resource

  delegate :id, :title, :description, :state, :order, :has_reminder, :reminder, to: :resource

  COLUMNS = [
    { name: :id,          field: :id,          required: true,  label: 'ID',          align: 'left', sortable: true },
    { name: :order,       field: :order,       required: true,  label: '#',           align: 'left', sortable: true },
    { name: :has_reminder, field: :has_reminder,       required: false,  label: 'HAS REMINDER',           align: 'left', sortable: true },
    { name: :reminder_info, field: :reminder_info,       required: false,  label: 'REMINDER',           align: 'left'},
    { name: :title,       field: :title,       required: true,  label: 'TITLE',       align: 'left', sortable: true },
    { name: :description, field: :description, required: false, label: 'DESCRIPTION', align: 'left', sortable: false },
    { name: :state,       field: :state,       required: true,  label: 'STATE',       align: 'left', sortable: true },
    { name: :actions,     field: :actions,                      label: 'ACTION',      align: 'left' }
  ]

  def reminder_info
    if reminder
      time_utc = reminder.remind_at
      dtitles = []
      reminder.days.each do |day|
        dtitles.push(Date::ABBR_DAYNAMES[day])
      end
      days = dtitles.count == 7 ? 'day' : dtitles.join(', ')
      text_days = " every #{days}"
    end
    {
      time_utc:,
      text_days:
    }
  end

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
      { kind: 'all',      name: :reminder,  label: 'Reminder',  color: 'blue-5',   icon: 'circle_notifications' },
      { kind: 'all',      name: :edit,      label: 'Edit',      color: 'orange-5', icon: 'edit' },
      { kind: 'active',   name: :archive,   label: 'Archive',   color: 'brown-5',  icon: 'archive' },
      { kind: 'unactive', name: :unarchive, label: 'Unarchive', color: 'info',     icon: 'unarchive' },
      { kind: 'all',      name: :destroy,   label: 'Delete',    color: 'red-5',    icon: 'delete' }
    ]
  end
end
