class NotableBooks2018::Book

  @@all = []

  attr_accessor :title, :author, :description, :publisher, :price
  attr_reader :genres

  def self.all
    @@all
  end

  def initialize(book_hash)
    book_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def genres=(genres)
    @genres = genres
    genres.each do |genre_instance|
      genre_instance.books << self
    end
  end

  def self.create_from_collection(book_array)
    book_array.each do |book_hash|
      NotableBooks2018::Book.new(book_hash)
    end
  end

end
