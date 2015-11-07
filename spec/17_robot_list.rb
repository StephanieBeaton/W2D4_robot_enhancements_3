require_relative 'spec_helper'

# 17 - Robot list

# The Robot class should keep track of all robots that are instantiated.

describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
  end

  describe ".list" do

    it "should keep track of all robots that are instantiated" do
      expect(Robot.list).to eq([@robot, @robot2])
    end
  end

end

