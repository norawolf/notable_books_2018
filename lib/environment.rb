require "pry"
require "nokogiri"
require "open-uri"
require "paint"

# here we will require all relevant files in dir notable_books_2018

require_relative "notable_books_2018/version.rb"
require_relative "notable_books_2018/cli.rb"
require_relative "notable_books_2018/book.rb"
require_relative "notable_books_2018/scraper.rb"
require_relative "notable_books_2018/genre.rb"
