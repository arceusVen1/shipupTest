class Country
  attr_reader :name, :distance_tab

  def initialize(name, distance_tab)
    @name = name
    @distance_tab = distance_tab
  end
end