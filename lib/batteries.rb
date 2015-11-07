class Batteries  < Item

  attr_reader :recharge_points

  def initialize(name, weight)
    # initialize(name, weight)
    super(name, weight)
    @recharge_points = 40

  end


  def recharge_shield(robot)
    binding.pry
    robot.shield = Robot::MAX_SHIELD_POINTS
    binding.pry
  end

end
