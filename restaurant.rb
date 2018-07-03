class Restaurant
  attr_accessor :name
  attr_accessor :type
  attr_accessor :seating
  attr_accessor :rating
  attr_accessor :visited
  def initialize (name, style=[], seating_max=0, rating=0, visited=[])  
    @name = name
    @type = style
    @seating = seating
    @rating = rating
    @visited = visited
  end
end

