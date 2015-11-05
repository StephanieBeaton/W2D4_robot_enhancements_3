class Laser < Weapon

  #   attr_reader :name, :weight   <-- from Item class

  #   attr_reader :damage
  #   initialize(name, weight, damage)   <--- from Weapon class

  def initialize
    super('Laser', 125, 25)
  end

end
