class NotableBooks2018::Genre

  attr_accessor :name
  attr_reader :books

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @books = []
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.find {|genre| genre.name == name}
  end

  def self.create_by_name(name)
    NotableBooks2018::Genre.new(name)
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create_by_name(name)
  end
end
