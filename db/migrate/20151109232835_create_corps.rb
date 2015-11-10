class CreateCorps < ActiveRecord::Migration
  def change
    create_table :corps do |t|
      t.string :name
      t.integer :ccp_id

      t.timestamps null: false
    end
  end
end
