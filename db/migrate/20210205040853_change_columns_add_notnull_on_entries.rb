class ChangeColumnsAddNotnullOnEntries < ActiveRecord::Migration[5.2]
  def change
    change_column_null :entries, :user_id, false
    change_column_null :entries, :room_id, false
  end
end
