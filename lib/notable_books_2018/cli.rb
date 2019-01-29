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
    @first_input = nil
    # also can use ||=, maybe
    # if input is equal to nil, run this block of code
      puts "Please enter a number to see a list of books or enter 'exit' to quit."
      @first_input = gets.chomp

      if (1..100).include?(@first_input.to_i)
        print_book_list(@first_input.to_i)
      elsif @first_input.downcase == "exit"
        goodbye
      else
        puts "That is not a valid selection."
        book_selector
      end

      select_book_by_number

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

    #end
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

  def select_book_by_number
    puts "Enter the number of a book you would like more information about or enter 'exit' to quit."
    second_input = gets.chomp

    if ((@first_input.to_i)..((@first_input.to_i)+9)).include?(second_input.to_i)
      print_book_info(second_input.to_i)
    elsif second_input.downcase == "exit"
      goodbye
    else
      puts "Please enter a number #{@first_input.to_i}-#{(@first_input.to_i)+9} to get book information."
      select_book_by_number
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
      end
    end
  end


  def goodbye
    puts "Thank you for browsing. Goodbye!"
    exit
  end

end
