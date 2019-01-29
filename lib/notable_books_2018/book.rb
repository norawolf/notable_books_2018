class NotableBooks2018::Book

  @@all = []

  attr_accessor :title, :author, :description #:review_url #:cover_url, :publisher, :price,
  attr_reader :genre

  def self.all
    @@all
  end

  def initialize(book_hash)
    book_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def genre=(genre)
    @genre = genre
    #genre is an array of 1 or 2 or 3 instances
    # for each instance in the genre array (Fiction, Poetry, etc)
    # associate this Book instance being created to that genre
    genre.each do |genre_instance|
      genre_instance.books << self
    end
  end

  def self.create_from_collection(book_array)
    book_array.each do |book_hash|
      NotableBooks2018::Book.new(book_hash)
    end
  end


end
