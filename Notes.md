TO CONTINUE
  - Scraping book data and creating a hash with book data attributes WORKS in Scraper.scrape_book_info
  - Calling create_books in the CLI WORKS
  - So, book objects are being created and returned
  - Right now, the CLI appears to be functioning correctly.

Gameplan Today:
- Scraping for Review URL!
- Once CLI is working - displaying numbered lists of books (title, author, description), can work
    on scraping more difficult data (genre, publisher, price, book and review urls)

Bigger TODO:
- Test for edge cases in CLI input
- Questions: Do you always have to see your input in your terminal? Is there a way to make it disappear from the display after #gets?
- Best practices to do spacing?
- See books by genre
- See books alphabetical by title
- See books by author

- Additional functionality: Save a book to a reading list!

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



 Welcome message, project description.

 ask user how many books they would like to see: 10? >> in the CLI
 main screen loads all books
   also can include link to book cover
   or use a gem to pixelate cover in the terminal
 user can choose a book and then see more description
 build scraper first
 then book class
 then CLI (formatting happens in CLI)

 to avoid over-scraping
 use ||=
 set scraper to instance variable, indicate that until we exit program, keep using this variable
 or set it equal to a new scrape if scrape has not already occurred


Possible additions:
- Seach books by Genre
- Search Books by Author

- Additional attributes to scrape that require extra parsing
:publisher, :price, :cover_url, :review_link (only some have this)
