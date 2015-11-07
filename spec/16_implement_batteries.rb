require_relative 'spec_helper'

# 16 - Implement Batteries

# Batteries are items that can be used by robot to recharge its shield.
# Implement Battery item that can be used to recharge the Robot’s shield.
# Batteries have a weight of 25.
#

describe Batteries do
  before :each do
    @batteries = Batteries.new("batteries", 25)
  end

  it "should be an item" do
    expect(@batteries).to be_an(Item)
  end

  it "should have name 'batteries'" do
    expect(@batteries.name).to eq("batteries")
  end

  it "should have weight 25" do
    expect(@batteries.weight).to eq(25)
  end

  describe "#recharge_shield" do
    before :each do
      @robot = Robot.new
    end

    it "recharge robots shield" do
      @robot.wound(40)
      @batteries.recharge_shield(@robot)
      expect(@robot.shield).to eq(50)
    end
  end
end
