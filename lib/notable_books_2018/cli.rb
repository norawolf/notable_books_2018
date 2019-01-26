class NotableBooks2018::CLI
  def start
    puts "NYT's Notable Books of 2018"
  end

end

# Welcome message, project description.
# How would you like to display the books?

# List all books
  # List all 100 books
  # Choose which book you would like more info on.
    # next level of all book info + descriptions
# Search authors
# Seach books by genre

# OR

# ask user how many books they would like to see: 10? >> in the CLI
# main screen loads all books
  # also can include link to book cover
  # or use a gim to pixelate cover in the terminal
# user can choose a book and then see more description
# build scraper first
# then book class
# then CLI (formatting happens in CLI)

# to avoid over-scraping
# use ||=
# set scraper to instance variable, indicate that until we exit program, keep using this variable
# or set it equal to a new scrape if scrape has not already occurred
