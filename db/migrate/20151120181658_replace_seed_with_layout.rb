class ReplaceSeedWithLayout < ActiveRecord::Migration
  def change
    remove_column :maps, :seed
    add_column :maps, :layout, :text
  end
end
