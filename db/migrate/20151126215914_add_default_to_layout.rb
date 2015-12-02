class AddDefaultToLayout < ActiveRecord::Migration
  def change
    change_column :maps, :layout, :string, null: false, default: ""
  end
end
