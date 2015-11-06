class Item
  attr_reader :name, :weight

  def initialize(name, weight)
    @name = name
    @weight = weight
  end

  def print
    puts "Item"
    puts "name = #{name}"
    puts "weight = #{weight}"
  end
end
