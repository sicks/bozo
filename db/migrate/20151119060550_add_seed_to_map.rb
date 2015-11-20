class AddSeedToMap < ActiveRecord::Migration
  def change
    add_column :maps, :seed, :integer
  end
end
