require 'pry'

class NotableBooks2018::Scraper
  def self.scrape_page
    Nokogiri::HTML(open("https://www.nytimes.com/interactive/2018/11/19/books/review/100-notable-books.html"))
  end

  def self.genre_parse(css)
    genre_data = css
    
    genre_data.collect do |genre_name|
      NotableBooks2018::Genre.new(genre_name)
    end
  end

  def self.scrape_book_info
    books_array = []
     scrape_page.css(".g-book-data").each.with_index do |nodeset|
       book_hash = {}
       book_hash[:title] = nodeset.css(".g-book-title").text.strip
       book_hash[:author] = nodeset.css(".g-book-author b").text.strip.chomp(".")
       book_hash[:genre] = genre_parse(nodeset.css(".g-book-tag").text.split)
       book_hash[:description] = nodeset.css(".g-book-description").text.strip
      books_array << book_hash
      end
      NotableBooks2018::Book.create_from_collection(books_array)
  end

  #could create a helper method to correctly parse & format genres
  # currently, genre is a string containing 1-3 values
  # would like for a Book to have one or multiple Genre instances


   #then
    #book_hash[:genre] = genre_parse
  # end
end
