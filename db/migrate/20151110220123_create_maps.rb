class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.references :corp
      t.string :title
      t.references :home

      t.timestamps null: false
    end
  end
end
