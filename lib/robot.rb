class Robot

  class RobotAlreadyDeadError < StandardError

  end

  class UnattackableEnemy < StandardError

  end

  CAPACITY = 250

  attr_reader :position, :items, :health

  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    position[0] -= 1
  end

  def move_right
    position[0] += 1
  end

  def move_up
    position[1] += 1
  end

  def move_down
    position[1] -= 1
  end


  # it "should automatically equip item if it's a weapon of any kind" do
  #   @robot.pick_up(@weapon)
  #   expect(@robot.equipped_weapon).to equal(@weapon)
  # end

  def pick_up(item)

    puts "in pick_up item = #{item}"
    puts "equipped_weapon #{equipped_weapon}"

    # binding.pry

    if (CAPACITY - items_weight) >= item.weight
      @items << item

      # binding.pry
      if item.class == PlasmaCannon || item.class == Laser
        # binding.pry
        self.equipped_weapon = item
      end

      true

    else
      false
    end

  end

  def items_weight

    @items.reduce(0) {|total_weight, item| total_weight + item.weight}
  end

  def wound(points)
    if (@health - points) < 0
      @health = 0
    else
      @health -= points
    end
  end

  def heal(points)
    if (@health + points) > 100
      @health = 100
    else
      @health += points
    end
  end

  def heal!(points)
    # raise an exception if the robot is already at 0 health or less.
    # Once a robot is dead, it cannot be revived.
    # begin

      raise RobotAlreadyDeadError if health <= 0

      if (@health + points) > 100
        @health = 100
      else
        @health += points
      end

    # rescue RobotAlreadyDeadError
    #   binding.pry
    #   puts "robot has health of 0 or less. Cannot heal! robot."
    # end

  end

  def attack(other_robot)

    if equipped_weapon.nil?
      other_robot.wound(5)
    else
      equipped_weapon.hit(other_robot)
    end

  end

  def attack!(other_robot)
    # begin
      raise UnattackableEnemy if other_robot.class != Robot

      if equipped_weapon.nil?
        other_robot.wound(5)
      else
        equipped_weapon.hit(other_robot)
      end

    # rescue UnattackableEnemy
    #   puts "Cannot attack! a non robot."
    # end
  end

  def print

    puts ""
    puts "Robot"
    puts "health = #{health}"

    puts "equipped_weapon"
    if equipped_weapon.nil?
      puts "nil"
    else
      equipped_weapon.print
    end

    puts "items"
    if @items.length == 0
      puts "[]"
    else
      items.each do |item|
        item.print
      end
    end
    puts ""

  end

end
