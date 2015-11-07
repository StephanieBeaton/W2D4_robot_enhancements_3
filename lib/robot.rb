class Robot

  class RobotAlreadyDeadError < StandardError

  end

  class UnattackableEnemy < StandardError

  end

  CAPACITY = 250

  MAX_SHIELD_POINTS = 50

  @@robot_list = []


  #   board
  #
  #    -3 -2 -1 0 1 2 3
  #  3  R
  #  2
  #  1
  #  0          2R
  # -1
  # -2
  # -3

  @@board = []   # <-- outer arrays are rows, inner arrays are columns

  @@board = [
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]],
  [[],[],[],[],[],[],[],[],[],[]]
  ]


  attr_reader :position, :items, :health

  attr_accessor :equipped_weapon, :shield

  def initialize
    @position = [0,0]
    @@board[0][0] = [] if @@board[0][0] == nil
    @@board[0][0] << self
    @items = []
    @health = 100
    @equipped_weapon = nil
    @shield = MAX_SHIELD_POINTS
    @@robot_list << self
  end


  # 19 - Scanning

  # A given robot should be able to scan its surroundings
  #  (tiles immediately next to its current @position)

  # Note: You should leverage the class method  in_position(x, y)
  # implemented in #18

  # return true is any of the surrounding tiles are occupied

  def self.scan(robot)

    position = robot.position

    #  must check 8 surrounding tiles

    position_to_left = []
    position_to_right = []
    position_above = []
    position_below = []
    position_to_NW = []
    position_to_NE = []
    position_to_SW = []
    position_to_SE = []

    position_to_left[0] = position[0] - 1
    position_to_left[1] = position[1]

    position_below[0] = position[0]
    position_below[1] = position[1] - 1

    position_to_right[0] = position[0] + 1
    position_to_right[1] = position[1]

    position_above[0] = position[0]
    position_above[1] = position[1] + 1

    position_to_NW[0] = position[0] - 1
    position_to_NW[1] = position[1] + 1


    position_to_NE[0] = position[0] + 1
    position_to_NE[1] = position[0] + 1


    position_to_SW[0] = position[0] - 1
    position_to_SW[1] = position[1] - 1

    position_to_SE[0] = position[0] + 1
    position_to_SE[1] = position[1] - 1

    return true if @@board[position_to_left[0], position_to_left[1]] != []

    return true if @@board[position_to_right[0], position_to_right[1]] != []

    return true if @@board[position_above[0], position_above[1]] != []

    return true if @@board[position_below[0], position_below[1]] != []

    return true if @@board[position_NW[0], position_NW[1]] != []

    return true if @@board[position_NE[0], position_NE[1]] != []

    return true if @@board[position_SW[0], position_SW[1]] != []

    return true if @@board[position_SE[0], position_SE[1]] != []

  end

  # def self.initialize_board

  #   for i in -20..20
  #     @@array[i] = []
  #     for j in -20..20
  #       @@array[i] << []
  #     end
  #   end
  # end

  #  Robot.in_position(x, y)
  #
  # The Robot class can be asked to return all robots
  # in a given position (x,y).
  # It should return an array of all the robots
  # since multiple robots could potentially be at position 0,0 (for example)
  def self.in_position(x, y)

    @@board[x][y]
  end

  def self.list
    @@robot_list
  end


  def self.remove_robot_from_position_on_board(x, y, robot)
    # remove this robot from the array at old position on the board

    temp_array = @@board[x][y]  # <-- returns an array, remove from array

    if temp_array != nil
      temp_array.delete_if { |item| item.object_id == robot.object_id }
      @@board[x][y] = temp_array
    end

  end


  def self.add_robot_to_position_on_board(x, y, robot)
   temp_array = @@board[x][y]

    if temp_array == nil
      temp_array = []
    end

    temp_array << robot
    @@board[x][y] = temp_array

  end

  def move_left
    # remove this robot from the array at old position on the board
    Robot.remove_robot_from_position_on_board(position[0], position[1], self)
    position[0] -= 1
    Robot.add_robot_to_position_on_board(position[0], position[1], self)
  end

  def move_right
    Robot.remove_robot_from_position_on_board(position[0], position[1], self)
    position[0] += 1
    Robot.add_robot_to_position_on_board(position[0], position[1], self)
  end

  def move_up
    Robot.remove_robot_from_position_on_board(position[0], position[1], self)
    position[1] += 1
    Robot.add_robot_to_position_on_board(position[0], position[1], self)
  end

  def move_down
    Robot.remove_robot_from_position_on_board(position[0], position[1], self)
    position[1] -= 1
    Robot.add_robot_to_position_on_board(position[0], position[1], self)
  end


  # it "should automatically equip item if it's a weapon of any kind" do
  #   @robot.pick_up(@weapon)
  #   expect(@robot.equipped_weapon).to equal(@weapon)
  # end

  def pick_up(item)

    # binding.pry

    if (CAPACITY - items_weight) >= item.weight
      @items << item

      # binding.pry
      if item.class == PlasmaCannon || item.class == Laser
        # binding.pry
        self.equipped_weapon = item
      end

      # The robot should now be smart enough that if it picks up health and needs
      # to consume it, then it will automatically feed on the bolts.
      # It should only feed on the bolts if it needs all of the energy from them
      if item.class == BoxOfBolts
         #  should automatically feed box of bolts if at or below 80hp
         item.feed(self) if health <= 80
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

    remaining = [shield - points, 0].min
    remaining = remaining.abs

    @shield = [0, shield - points].max

    @health = [0, health - remaining].max

  end

  def heal(points)

    remaining = [@health + points - 100, 0].max

    @health = [@health + points, 100].min

    @shield = [@shield + remaining, MAX_SHIELD_POINTS].min

  end

  def heal!(points)
    # raise an exception if the robot is already at 0 health or less.
    # Once a robot is dead, it cannot be revived.
    # begin

      raise RobotAlreadyDeadError if health <= 0

      remaining = [@health + points - 100, 0].max

      @health = [@health + points, 100].min

      @shield = [@shield + remaining, MAX_SHIELD_POINTS].min

      # if (@health + points) > 100
      #   @health = 100
      # else
      #   @health += points
      # end

    # rescue RobotAlreadyDeadError
    #   binding.pry
    #   puts "robot has health of 0 or less. Cannot heal! robot."
    # end

  end


  # Since grenades have a range of 2, if the robot has one equipped,
  # it can attack an enemy robot that is 2 tiles away instead of just 1 tile away

  def block_within_2_blocks_to_this_robot(other_robot)

    return true if block_next_to_this_robot?(other_robot)

    # is other_robot 2 blocks away from this robot ??

    #  ...check 16 positions

    other_robot_position = other_robot.position

    # binding.pry
    # test for 5 positions two squares to left of this robot
    if other_robot_position[0] == position[0] - 2 &&
      ((other_robot_position[1] == position[1] + 2) ||
       (other_robot_position[1] == position[1] + 1) ||
       (other_robot_position[1] == position[1] + 0) ||
       (other_robot_position[1] == position[1] - 1) ||
       (other_robot_position[1] == position[1] - 2) )
          return true
    end

    # test for 5 positions two squares to right of this robot
    if other_robot_position[0] == position[0] + 2 &&
      ((other_robot_position[1] == position[1] + 2) ||
       (other_robot_position[1] == position[1] + 1) ||
       (other_robot_position[1] == position[1] + 0) ||
       (other_robot_position[1] == position[1] - 1) ||
       (other_robot_position[1] == position[1] - 2) )
          return true
    end

    # test for 3 position two squares above this robot
    if other_robot_position[1] == position[1] + 2 &&
     ((other_robot_position[0] == position[0] - 1) ||
      (other_robot_position[0] == position[0] - 0) ||
      (other_robot_position[0] == position[0] + 1))
          return true
    end

    # test for 3 position two squares below this robot
    if other_robot_position[1] == position[1] - 2 &&
     ((other_robot_position[0] == position[0] - 1) ||
      (other_robot_position[0] == position[0] - 0) ||
      (other_robot_position[0] == position[0] + 1))
          return true
    end

    false

  end

  # Robots can only attack enemy robots that are in the tile/block next to them
  # So if an enemy robot is directly above, below, or next to the robot,
  # then it will wound the enemy robot
  # Otherwise the attack method should not do anything
  def block_next_to_this_robot?(other_robot)

    position_to_left = []
    position_to_right = []
    position_above = []
    position_below = []

    position_to_left[0] = position[0] - 1
    position_to_left[1] = position[1]

    position_below[0] = position[0]
    position_below[1] = position[1] - 1

    position_to_right[0] = position[0] + 1
    position_to_right[1] = position[1]

    position_above[0] = position[0]
    position_above[1] = position[1] + 1

    other_robot_position = other_robot.position

    # binding.pry

    return true if position[0] == other_robot_position[0] &&
                   position[1] == other_robot_position[1]

    return true  if position_to_left[0] == other_robot_position[0] &&
                    position_to_left[1] == other_robot_position[1]

    return true  if position_below[0] == other_robot_position[0] &&
                    position_below[1] == other_robot_position[1]

    return true  if position_to_right[0] == other_robot_position[0] &&
                    position_to_right[1] == other_robot_position[1]

    return true  if position_above[0] == other_robot_position[0] &&
                    position_above[1] == other_robot_position[1]

    false

  end

  # test 09
  # expect(@weapon).to receive(:hit).with(@robot2)

  def attack(other_robot)

    # Since grenades have a range of 2, if the robot has one equipped,
    # it can attack an enemy robot that is 2 tiles away instead of just 1 tile away
    # That said, it will also discard/unequip the grenade
    # binding.pry

    if equipped_weapon.is_a?(Grenade)

      # binding.pry

      if block_within_2_blocks_to_this_robot(other_robot)

        # binding.pry

        equipped_weapon.hit(other_robot)

        # binding.pry
        # remove from items array too
        # get FIRST index of element searched
        index = items.index{ |item| item.object_id == equipped_weapon.object_id }
        # binding.pry
        # remove the element at that index
        items.slice!(index) if index.nil? == false
        # binding.pry
        self.equipped_weapon = nil
        # binding.pry

      end

    elsif block_next_to_this_robot?(other_robot)

      # Robots can only attack enemy robots that are in the tile/block next to them
      # So if an enemy robot is directly above, below, or next to the robot,
      # then it will wound the enemy robot
      # Otherwise the attack method should not do anything

      if equipped_weapon.nil?
        other_robot.wound(5)
      else
        equipped_weapon.hit(other_robot)
      end
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
