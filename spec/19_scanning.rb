require_relative 'spec_helper'


# 19 - Scanning

# A given robot should be able to scan its surroundings
#  (tiles immediately next to its current @position)

# Note: You should leverage the class method implemented in #18


describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
  end

  describe ".scan" do

    it "should find out whether tiles immediately next to its current position are not empty" do
      @robot2.move_right
      expect(Robot.scan(@robot)).to eq(true)
    end

  end
end

