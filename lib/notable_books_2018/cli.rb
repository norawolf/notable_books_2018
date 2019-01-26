class NotableBooks2018::CLI
  def start
    welcome
    main_menu
    book_selector
    goodbye
  end

  def welcome
    puts "Welcome to NYT's Notable Books of 2018."
    puts "Project description here."
  end

  def main_menu
    puts <<~DOC

      Enter the number of books you would like to view.
      1-19
      20-39
      40-59
      60-79
      80-100
    DOC
  end

  def book_selector
    input = nil

    while input != "exit"
      #initial input to choose numbered list of books
      input = gets.chomp
      puts "Which book would you like more information about?"


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

  def print_book_list(by_number)
      puts "1. Title by Author"
      puts "2. Title by Author"
      puts "3. Title by Author"
      puts "4. Title by Author"
      puts "5. Title by Author"
  end


  def print_book_info(book_index)
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
