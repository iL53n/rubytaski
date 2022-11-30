class AddProvidersFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string  :provider, limit: 50,  default: ''
      t.string  :uid,      limit: 500, default: ''
    end
  end
end
