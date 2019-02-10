class NotableBooks2018::Genre

  attr_accessor :name
  attr_reader :books

  @@all = []
  @@all_names = []

  def initialize(name)
    @name = name
    @@all << self
    @books = []
    @@all_names << name
  end

  def self.all
    @@all
  end

  def self.all_names
    @@all_names
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

#@books is the array of book instances for a particular genre
  def find_by_index(index)
    @books[(index.to_i)-1]
  end

end
