class NotableBooks2018::CLI
  def start
    welcome
    create_books
    main_menu
    book_selector
    goodbye
  end

  def welcome
    puts "Welcome to Notable Books of 2018."
    puts "You can use this gem to find more information about etc..."
  end

  def main_menu
    # How to phrase this?
    puts <<~DOC

      Please enter a number to see a list of books.

      Books:
      1-10
      11-19
      20-29
      30-39
      40-49
      50-59
      60-69
      70-79
      80-89
      90-100
    DOC
  end

  def book_selector
    input = nil

    while input != "exit"
      #initial input to choose numbered list of books
      input = gets.chomp.to_i

      print_book_list(input)

      puts "Enter the number of a book you would like more information about."
      #How to make it so that user could enter "exit" even when not prompted and still exit?
      input = gets.chomp.to_i

      print_book_info(input)

      puts "Would you like to see another book? Enter 'Yes' or 'No'."

      input = gets.chomp.downcase

      case input
        when "yes"
          # should this go to the main menu, or back to the smaller list? if so, how?
          main_menu
          book_selector
        when "no"
          goodbye
         else
          puts "That is not a valid selection."
          main_menu
          book_selector
      end

    end
  end

  def create_books
    books_array ||= NotableBooks2018::Scraper.scrape_book_info
    NotableBooks2018::Book.create_from_collection(books_array)
  end

  def print_book_list(by_number)

      puts "Displaying Notable Books #{by_number} - #{by_number+9}"
      puts ""

      NotableBooks2018::Book.all[by_number-1, 10].each.with_index(by_number) do |book, index|
        puts "#{index}. #{book.title} by #{book.author}"
      end
  end


  def print_book_info(book_index)
    NotableBooks2018::Book.all.each.with_index(1) do |book, index|
      if index == book_index
        puts book.title
        puts "by #{book.author}"
        puts ""
        puts "Genre(s): #{book.genre}"
        puts ""
        puts "Description: #{book.description}"
        puts ""
        #How to display book description with auto line wrapping? Or is it just my terminal
        # and small screen?
        # formatting - lines?
        # colorizing?
      end
    end
  end


  def goodbye
    puts "Thank you for browsing. Goodbye!"
    exit
  end

end
