class RemoveCcpIdFromChars < ActiveRecord::Migration
  def change
    remove_column :chars, :ccp_id
  end
end
