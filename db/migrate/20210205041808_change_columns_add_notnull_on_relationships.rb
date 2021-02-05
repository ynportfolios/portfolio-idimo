class ChangeColumnsAddNotnullOnRelationships < ActiveRecord::Migration[5.2]
  def change
    change_column_null :relationships, :user_id, false
    change_column_null :relationships, :follow_id, false
  end
end
