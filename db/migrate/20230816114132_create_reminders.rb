class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.references :task, null: false, foreign_key: true
      t.string :remind_at, null: false
      t.string :recurrence, null: false
      t.integer :days, array: true, null: false

      t.timestamps
    end
  end
end
