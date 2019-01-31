TO DO NEXT:

- Fill out gemspec and Readme
- text wrap paragraph desc to 80 characters?
- Scraping for Review URL! -- Need help!
- Blog Post
- Recording: 30 Mins
- Recording: 5 Min Walkthrough

- Formatting. Final proof text outputs.
- both print_book_info
  and print_book_info_from_genre inside the final iteration outputs the same info.
   - extract this to a helper method!

-Assessment - Keep In Mind
  - line by line explanation
  - how everything is connected
  - require vs. require_relative
  - how are files being executed in bin/notable-books-2018


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
