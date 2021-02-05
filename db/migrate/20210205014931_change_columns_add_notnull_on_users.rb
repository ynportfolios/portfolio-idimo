class ChangeColumnsAddNotnullOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :sex, false
    change_column_null :users, :birth_date, false
    change_column_null :users, :animal, false
  end
end
