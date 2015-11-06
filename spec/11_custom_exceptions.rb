require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @weapon = PlasmaCannon.new
    @non_weapon = BoxOfBolts.new
  end

  # throws custom Exception UnattackableEnemy if attack! is on a non-robot
  describe "#attack!" do
    it "should throw custom Exception UnattackableEnemy when attacking non-robot" do

      expect{ @robot.attack!(@weapon) }.to raise_error(Robot::UnattackableEnemy)
    end

  end

  # throws custom Exception
  describe "#heal!" do
    it "should throw custom Exception RobotAlreadyDeadError when healing a dead robot" do
      @another_robot = Robot.new
      @another_robot.wound(100)    #  kill another_robot
      expect { @another_robot.heal!(20) }.to raise_error(Robot::RobotAlreadyDeadError)
    end
  end

end


