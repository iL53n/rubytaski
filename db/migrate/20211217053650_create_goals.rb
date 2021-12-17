class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.integer :state, default: 0, null: false
      t.date :start_date, null: false
      t.date :due_date, null: false
      t.integer :number_of_stars, null: false
      t.string :prize, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
