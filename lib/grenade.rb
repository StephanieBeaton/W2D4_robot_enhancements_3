class Grenade < Weapon

  #   attr_reader :name, :weight   <-- from Item class

  #   attr_reader :damage
  #   initialize(name, weight, damage)   <--- from Weapon class

  attr_reader :range

  def initialize
    super('Grenade', 40, 15)

    @range = 2
  end

end

