require './lib/robot.rb'
require './lib/item.rb'
require './lib/weapon.rb'
require './lib/laser.rb'
require './lib/plasma_cannon.rb'
require './lib/box_of_bolts.rb'


robot = Robot.new

robot.print

robot.equipped_weapon = PlasmaCannon.new

robot.print


box_of_bolts = BoxOfBolts.new

box_of_bolts.print

robot.pick_up(box_of_bolts)

robot.print

puts robot.items_weight

robot.wound(100)

# robot.heal!(20)

robot.attack!(box_of_bolts)

# robot.items.each do |item|
#   puts "item = #{item.inspect}"
#   # loop thru the properties
#   # item.instance_variables.each do |key|
#   #   puts "key #{key}"
#   # end

# end

# laser = Laser.new

# robot.pickup(laser)

# robot2 = Robot.new

# robot.attack(robot2)

# puts "robot2"
# robot2.print



