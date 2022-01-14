class AddAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nick_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :parent, :boolean, default: false
  end
end
