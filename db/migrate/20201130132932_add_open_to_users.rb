class AddOpenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :secret, :boolean
  end
end
