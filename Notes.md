TO CONTINUE
  - Right now, the CLI appears to be functioning correctly.

Gameplan Today:
- Scraping for Review URL! -- Need help!
- can work on scraping more difficult data (genre, publisher, price, book and review urls)
- Once I control for edgecases via input in #book_selector - should some input cues be extracted into helper methods to DRY?

Bigger TODO:
- Test for edge cases in CLI input
- Questions: Do you always have to see your input in your terminal? Is there a way to make it disappear from the display after #gets?
- Best practices to do spacing?
- Colorize! for fun!
- Additional attributes to scrape that require extra parsing (additional method?):
      :publisher, :price, :cover_url, :review_link (only some have this)


- Additional functionality: Save a book to a reading list!
  - See books by genre
  - See books alphabetical by title
  - See books by author
  - use a gem to pixelate cover in the terminal?
- Big dreams functionality: Check if a library near you has a copy of this book!

Logic Needed to fix print_book_info conditionals:
  #some kind of loop. put in a helper method? case statement?
  # If second_input is not within the list range output above by print_book_list
  # keep asking for second_input until it is within range
  # then, print_book_info(second_input)

  # a way to check if the second_input number is one of the numbered list currently being displayed.
  # if (first_input..(first_input+9)).include?(second_input)
  #   print_book_info(second_input)
  # else
  #   puts "Please select a valid number from the list."
  #   second_input = gets.chomp.to_i until (first_input..(first_input+9)).include?(second_input)
  # end



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
