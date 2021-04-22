class AddColumnsNullToMessages < ActiveRecord::Migration[6.0]
  def change
    change_column_null :messages, :content, false
    change_column_null :messages, :conversation_id, false
    change_column_null :messages, :user_id, false
  end
end
