class AddSomethingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :sex, :integer
    add_column :users, :birth_date, :date
    add_column :users, :animal, :string
    add_column :users, :profile, :text
  end
end
