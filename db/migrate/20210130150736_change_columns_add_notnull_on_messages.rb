class ChangeColumnsAddNotnullOnMessages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :messages, :content, false
  end
end
