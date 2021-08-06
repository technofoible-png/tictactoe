# is player

class Player
  attr_reader :name, :tile
  attr_accessor :turn

  def initialize(name, tile)
    @name = name
    @tile = tile
    @turn = false
  end
end