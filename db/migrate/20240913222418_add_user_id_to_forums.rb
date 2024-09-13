class AddUserIdToForums < ActiveRecord::Migration[7.2]
  def change
    add_column :forums, :user_id, :integer
  end
end
