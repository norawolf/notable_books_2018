#Can't get the NotableBooks2018::Scraper namespacing to work. Gives uninitialized constant NameError
require 'pry'

class NotableBooks2018::Scraper
  def self.scrape_page
    page = Nokogiri::HTML(open("https://www.nytimes.com/interactive/2018/11/19/books/review/100-notable-books.html"))
  end

  def self.scrape_book_info
    scrape_page.css(".g-books")
  end

  def self.create_books
     scrape_book_info.each do |nodeset|
       binding.pry
        #Book.new_from_page(nodeset)
        #nodeset is now all the data for the books
      end
  end
end
