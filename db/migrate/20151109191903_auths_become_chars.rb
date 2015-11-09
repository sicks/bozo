class AuthsBecomeChars < ActiveRecord::Migration
  def change
    rename_table :auths, :chars
    add_column :chars, :ccp_id, :integer
    add_column :chars, :name, :string, null: false, default: ""
    add_column :chars, :owner, :string, null: false, default: ""
  end
end
