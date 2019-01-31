require 'pry'

class NotableBooks2018::Scraper
  def self.scrape_page
    url = "https://www.nytimes.com/interactive/2018/11/19/books/review/100-notable-books.html"
    Nokogiri::HTML(open(url))
  end

  def self.scrape_book_info
    books_array = []
     scrape_page.css(".g-book-data").each.with_index do |nodeset|
       book_hash = {}

       book_hash[:title] = nodeset.css(".g-book-title").text.strip
       book_hash[:author] = nodeset.css(".g-book-author b").text.strip.chomp(".")
       book_hash[:genre] = create_genres(nodeset.css(".g-book-tag").text
        .split(".").map!(&:strip).reject(&:empty?))
       book_hash[:description] = nodeset.css(".g-book-description").text.strip
       book_hash[:publication_info] = nodeset.css(".g-book-author").text
        .split(". ").map!(&:strip).slice(1..-1).join(". ")
      books_array << book_hash
      end

      NotableBooks2018::Book.create_from_collection(books_array)
  end

  def self.create_genres(css)
    genre_data = css
    genre_data.collect do |genre_name|
      NotableBooks2018::Genre.find_or_create_by_name(genre_name)
     end
  end
end
