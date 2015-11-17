class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :map
      t.references :from
      t.references :to
      t.references :hole
      t.boolean :eol, default: false
      t.integer :stage, default: 1

      t.timestamps null: false
    end
  end
end
