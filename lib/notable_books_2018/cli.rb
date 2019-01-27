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
    puts <<~DOC

      Enter the number of books you would like to view.
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
      puts "Enter a book number you would like more information about?"


      print_book_list(input)

      #How to make it so that user could enter "exit" even when not prompted and still exit?
      input = gets.chomp

      # method below will become something to find the index of the book
      # book_index = NotableBooks2018::Books.find(input.to_i)

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
          puts "I don't understand that answer."
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
    #NotableBooks2018.Book.information
    puts <<-HEREDOC
    Book cover URL
    Book author
    Book Price
    Book Publisher
    Book description
    HEREDOC
  end


  def goodbye
    puts "Thank you for browsing. Goodbye!"
    exit
  end

end
