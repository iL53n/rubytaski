class CreateStars < ActiveRecord::Migration[6.1]
  def change
    create_table :stars do |t|
      t.belongs_to :user, null: false
      t.belongs_to :task, null: false
      t.integer :state, default: 0, null: false
      t.datetime :due_date
      t.datetime :done_date

      t.timestamps
    end
  end
end
