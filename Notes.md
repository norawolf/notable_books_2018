TO CONTINUE
  - Scraping book data and creating a hash with book data attributes WORKS in Scraper.scrape_book_info
  - Calling create_books in the CLI WORKS
  - So, book objects are being created and returned

  - Just discovered that some books (starting on index 30 - the Odyssey) have 2 genres listed under nested tags. Overall class ".g-book-tags". Then, for example.

  <span class="g-book-tag" data-slug="fiction">
                        Fiction.
                      </span>
  <span class="g-book-tag" data-slug="poetry">
          Poetry.
  </span>

- Includes /n that isn't getting removed with .strip
- I have temporarily commented out the :genre attr_accessor in Book and the book_hash[:genre]
in Scraper, until I figure out how to handle this weird data.
- Going to have to book_hash[:genre] = nodeset.css(".g-book-tag").text.strip.delete!("\n\s")
  # gets rid of all newlines and white spaces

  of the ones that have two genres listed (some have 3)
  pry(NotableBooks2018::Scraper)> book_hash[:genre] = nodeset.css(".g-book-tag")[0].text.strip
  does access the first one??



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

First idea for scraping data into hashes -- seems like extra work!
html = "https://www.nytimes.com/interactive/2018/11/19/books/review/100-notable-books.html"
page = Nokogiri::HTML(open(html))
binding.pry
books_array = []
page.css(".g-books").each do |nodeset|
  book_hash = {}
  #  publisher = parsed data
  #  price = parsed data
  book_hash[:cover_url]
  book_hash[:title] = nodeset.css(".g-book-title").text
  book_hash[:author] = nodeset.css(".g-book-author b").text
  book_hash[:genre] = nodeset.css("span.g-book-tag").text.strip
#  book_hash[:publisher] = publisher
#  book_hash[:price] = price
  book_hash[:description] = nodeset.css(".g-book-description").text
  # some book titles also have links to reviews. how to include url for optional review?


  # each book listing becomes a hash inside an array
  # assign the attributes
  #later, turn each has into a Book object a la the student scraper lab
  books_array << books_hash
  end
   books_array
