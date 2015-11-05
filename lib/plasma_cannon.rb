class PlasmaCannon < Weapon

  #   attr_reader :name, :weight   <-- from Item class

  #   attr_reader :damage
  #   initialize(name, weight, damage)   <--- from Weapon class

  def initialize
    super('Plasma Cannon', 200, 55)
  end

end
