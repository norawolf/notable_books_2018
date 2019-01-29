require 'pry'

class NotableBooks2018::Scraper
  def self.scrape_page
    Nokogiri::HTML(open("https://www.nytimes.com/interactive/2018/11/19/books/review/100-notable-books.html"))
  end


  def self.scrape_book_info
    books_array = []
     scrape_page.css(".g-book-data").each.with_index do |nodeset|
       book_hash = {}
       book_hash[:title] = nodeset.css(".g-book-title").text.strip
       book_hash[:author] = nodeset.css(".g-book-author b").text.strip.chomp(".")
       book_hash[:genre] = NotableBooks2018::Genre.new(nodeset.css(".g-book-tag").text.split.join(' '))
       binding.pry
       book_hash[:description] = nodeset.css(".g-book-description").text.strip
      books_array << book_hash
      end
      NotableBooks2018::Book.create_from_collection(books_array)
  end

end
