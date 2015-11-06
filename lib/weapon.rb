class Weapon < Item

  #   attr_reader :name, :weight

  attr_reader :damage

  def initialize(name, weight, damage)
    @damage = damage
    super(name, weight)
  end

  def hit(robot)
    robot.wound(damage)
  end

  def print
    puts "Weapon"
    puts "name = #{name}"
    puts "weight = #{weight}"
    puts "damage points = #{damage}"
  end

end
