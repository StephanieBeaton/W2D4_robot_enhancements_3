require_relative 'spec_helper'

# 18 - Robot.in_position(x, y)

# The Robot class can be asked to return all robots
# in a given position (x,y).
# It should return an array of all the robots
# since multiple robots could potentially be at position 0,0 (for example)


describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
  end

  describe ".in_position" do

    it "should keep track of all robots that are in position x,y" do
      expect(Robot.in_position(0,0)).to eq([@robot, @robot2])
    end

    it "should keep track of all robots in position when a robot moves right" do
      @robot.move_right
      @robot.move_right
      expect(Robot.in_position(2,0)).to eq([@robot])
    end


    it "should keep track of all robots in position when a robot moves left" do
      @robot.move_left
      expect(Robot.in_position(-1,0)).to eq([@robot])
    end


    it "should keep track of all robots in position when a robot moves up" do
      @robot.move_up
      @robot.move_up
      expect(Robot.in_position(0,2)).to eq([@robot])
    end


    it "should keep track of all robots in position when a robot moves down" do
      @robot.move_down
      @robot.move_down
      expect(Robot.in_position(0,-2)).to eq([@robot])
    end

  end

end


