require_relative 'spec_helper'

# 15 - Introduce Shields

# Robots can start with 50 shield points.
# When the robot is damaged it first drains the shield
# and then starts affecting actual health.

# You will likely also have to fix previous tests
# that will fail due to this enhancement.
# However, focus on running spec 16 until you are done,
# then rerun all your tests to find other failing tests
# and modify the tests to modify their expectations.

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#shield" do
    it "should be 50" do
      expect(@robot.shield).to eq(50)
    end
  end

# When the robot is damaged (by attack) it first drains the shield
#   def wound(points)
  describe "#wound" do
    it "first drains shield" do
      @robot.wound(49)                # new robots have 50 shield points and 100 health points
      expect(@robot.shield).to eq(1)
      expect(@robot.health).to eq(100)
    end

    it "after shield is drained next drains health" do
      @robot.wound(51)                # new robots have 50 shield points and 100 health points
      expect(@robot.shield).to eq(0)
      expect(@robot.health).to eq(99)
    end

    it "doesn't decrease health below 0" do
      @robot.wound(200)
      expect(@robot.health).to eq(0)
      expect(@robot.shield).to eq(0)
    end
  end

  describe "#heal" do
    it "first increases health" do
      @robot.wound(200)
      @robot.heal(99)
      expect(@robot.health).to eq(99)
      expect(@robot.shield).to eq(0)
    end

    it "doesn't increase health over 100" do
      @robot.wound(200)
      @robot.heal(125)

      expect(@robot.health).to eq(100)
      expect(@robot.shield).to eq(25)
    end

    it "doesn't increase shield over 50" do
      @robot.wound(200)
      @robot.heal(160)
      expect(@robot.health).to eq(100)
      expect(@robot.shield).to eq(50)

    end

  end

end

