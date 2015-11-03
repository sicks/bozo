class RemovePrimaryIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :primary_id
  end
end
