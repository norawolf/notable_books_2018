class NotableBooks2018::Genre

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.find {|genre| genre.name == name}
  end

  def save
    @@all << self
  end

  def self.create_by_name(name)
    NotableBooks2018::Genre.new(name).tap {|genre| genre.save}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create_by_name(name)
  end

  # def books
  #   NotableBooks2018::Book.all.select {|book| book.genre == self}
  # end

end
