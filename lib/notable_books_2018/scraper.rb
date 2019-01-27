require 'pry'

class NotableBooks2018::Scraper
  def self.scrape_page
    Nokogiri::HTML(open("https://www.nytimes.com/interactive/2018/11/19/books/review/100-notable-books.html"))
  end


  def self.scrape_book_info
    book_array = []
     scrape_page.css(".g-book-data").each do |nodeset|
       book_hash = {}
       book_hash[:title] = nodeset.css(".g-book-title").text.strip
       book_hash[:author] = nodeset.css(".g-book-author b").text.strip.chomp(".")
       book_hash[:genre] = nodeset.css(".g-book-tag").text.split.join(' ')
       book_hash[:description] = nodeset.css(".g-book-description").text.strip
      book_array << book_hash
      end
      book_array
    end

  # def self.scrape_more_info
      # expanded functionality to scrape for
      # :cover_url
      # and scrape + parse :publisher and :price and :review_url
  # end
end
