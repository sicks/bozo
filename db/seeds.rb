# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

puts "Adding 7699 systems to the DB. This will take a while."
System.delete_all
count = 0
CSV.foreach(Rails.root.join('db','seed_data','systems.csv'), headers: true) do |row|
  System.create! row.to_hash
  count += 1
  if count % 100 == 0
    puts "#{count}/7699 systems added"
  end
end
puts "7699/7699 systems added! All done!"

puts "Adding system bonus data"
WormholeEffect.delete_all
CSV.foreach(Rails.root.join('db','seed_data','black_hole.csv'), headers: true) do |row|
  WormholeEffect.create! row.to_hash
end
CSV.foreach(Rails.root.join('db','seed_data','cataclysmic_variable.csv'), headers: true) do |row|
  WormholeEffect.create! row.to_hash
end
CSV.foreach(Rails.root.join('db','seed_data','magnetar.csv'), headers: true) do |row|
  WormholeEffect.create! row.to_hash
end
CSV.foreach(Rails.root.join('db','seed_data','pulsar.csv'), headers: true) do |row|
  WormholeEffect.create! row.to_hash
end
CSV.foreach(Rails.root.join('db','seed_data','wolf_rayet.csv'), headers: true) do |row|
  WormholeEffect.create! row.to_hash
end
CSV.foreach(Rails.root.join('db','seed_data','red_giant.csv'), headers: true) do |row|
  WormholeEffect.create! row.to_hash
end
puts "Done."

puts "Noting which systems have which bonuses"
SystemBonus.delete_all
CSV.foreach(Rails.root.join('db','seed_data','system_bonus.csv'), headers: true) do |row|
  SystemBonus.create! row.to_hash
end
puts "Done."

puts "Adding Hole types"
Hole.delete_all
CSV.foreach(Rails.root.join('db','seed_data','holes.csv'), headers: true) do |row|
  Hole.create! row.to_hash
end
puts "Done."

puts "Adding System Adjacency info. This will take a while."
SystemJump.delete_all
count = 0
CSV.foreach(Rails.root.join('db','seed_data','system_jumps.csv'), headers: true) do |row|
  SystemJump.create! row.to_hash
  count += 1
  if count % 100 == 0
    puts "#{count}/14340 system connections added"
  end
end
puts "All system connections added!"