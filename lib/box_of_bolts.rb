class BoxOfBolts < Item

  def initialize
    # initialize(name, weight)
    super("Box of bolts", 25)
  end

  def feed(robot)
    robot.heal(20)
  end
end
