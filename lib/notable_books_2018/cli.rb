class NotableBooks2018::CLI
  def start
    welcome
    NotableBooks2018::Scraper.scrape_book_info
    main_menu
    book_selector
    goodbye
  end

  def welcome
    puts "Welcome to Notable Books of 2018!"
    puts "--------------------------------------------"
    puts <<~DOC
      The New York Times Book Review published a list of notable new book releases in 2018.
      You can use this gem to browse 2018's notable book selections and find more information about each book.
    DOC
  end

  def main_menu
    puts <<~DOC

      Books:
      1-10
      11-20
      21-30
      31-40
      41-50
      51-60
      61-70
      71-80
      81-90
      91-100

    DOC
  end

  def book_selector
    first_input = nil

    #INSTANCE VARIABLES to store this input from gets.chomp
    # also can use ||=, maybe
    # if input is equal to nil, run this block of code
    while first_input != "exit"
      puts "Please enter a number to see a list of books."
      first_input = gets.chomp.to_i

      #Edge case control: Only allow user to enter a valid number 1-100
      if (1..100).include?(first_input)
        print_book_list(first_input)
      else
        puts "That is not a valid selection."
        book_selector
      end

      #this should become another method
      puts "Enter the number of a book you would like more information about."
      second_input = gets.chomp.to_i

      # Currently, user can enter any number. 1-100 will return details for referenced book,
      # not just the numbered list that appears on screen
      # number outside the range goes to "Would you like to see another book."
      # FIX! Limit user input to displayed range.

      # a way to check if the second_input number is one of the numbered list currently being displayed.
      # if (first_input..(first_input+9)).include?(second_input)
      #   print_book_info(second_input)
      # else
      #   puts "Please select a valid number from the list. (DISPLAY ACTUAL LISTED NUMBERS)"
      #   call the second_method again
      # second_input = gets.chomp.to_i until (first_input..(first_input+9)).include?(second_input)
      # end


      print_book_info(second_input)

      puts "Would you like to see another book? Enter 'Yes' or 'No'."

      input = gets.chomp.downcase

      case input
        when "yes"
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

  def print_book_list(by_number)
    puts ""
    if by_number == 100
      puts "The 100th Notable Book"
      puts ""
    elsif by_number >= 92 && by_number != 100
      puts "Notable Books #{by_number} - 100"
      puts ""
    else
      puts "Notable Books #{by_number} - #{by_number+9}"
      puts ""
    end

    NotableBooks2018::Book.all[by_number-1, 10].each.with_index(by_number) do |book, index|
      puts "#{index}. #{book.title} by #{book.author}"
    end
  end


  def print_book_info(book_index)
    NotableBooks2018::Book.all.each.with_index(1) do |book, index|
      if index == book_index
        puts ""
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
