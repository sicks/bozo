class ChangeUid < ActiveRecord::Migration
  def change
    remove_column :chars, :uid
    add_column :chars, :uid, :integer, null: false, default: 0
  end
end
