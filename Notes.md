TO DO NEXT:
- OK wow, everything *appears* to be working basically correctly
- Go through Genre methods to add
  - ability to exist
  - controls for invalid inputs
  - etc
- Formatting. Final proof text outputs.

- Scraping for Review URL! -- Need help!
- can work on scraping more difficult data (genre, publisher, price, book and review urls
  - if you scrape these, be sure to add to both genre and list #print methods
- Notes for Blog Post
- Recording

Bigger TODO:
- Best practices for CLI spacing, dividers, and linebreaks?
- Colorize! for fun!
- Additional attributes to scrape that require extra parsing (additional method?):
      :publisher, :price, :cover_url, :review_link (only some have this)
- investigate line wrapping (for description)


-Assessment - Keep In Mind
  - line by line explanation
  - how everything is connected
  - require vs. require_relative
  - how are files being executed in bin/notable-books-2018


- Additional functionality: Save a book to a reading list!
  - See books by genre
  - See books alphabetical by title
  - See books by author
  - use a gem to pixelate cover in the terminal?
- Big dreams functionality: Check if a library near you has a copy of this book!

Genre Class functionality notes:
  -


# alternate way to create books inside the NotableBooks2018::Scraper
#  def self.scrape_book_info
# scrape_page.css(".g-book-data").each do |nodeset|
#   title = nodeset.css(".g-book-title").text.strip
#   author = nodeset.css(".g-book-title").text.strip
#   genre = nodeset.css("span.g-book-tag").text.strip
#   description = nodeset.css(".g-book-description").text.strip
#   binding.pry
#   new_book = NotableBooks2018::Book.new(title, author, genre, description)
# end

if nodeset.css(".g-book-title.balance-text a")
  book_hash[:review_url] = nodeset.css(".g-book-title.balance-text a")[index]["href"]
end

 to avoid over-scraping
 use ||=
 set scraper to instance variable, indicate that until we exit program, keep using this variable
 or set it equal to a new scrape if scrape has not already occurred
