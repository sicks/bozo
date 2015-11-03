class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :provider
      t.string :uid
      t.references :user

      t.timestamps null: false
    end
    add_index :auths, :provider
    add_index :auths, :uid
  end
end
