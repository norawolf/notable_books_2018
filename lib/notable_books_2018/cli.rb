class NotableBooks2018::CLI

  def run
    NotableBooks2018::Scraper.scrape_book_info
    welcome
    goodbye
  end

  def welcome
    puts "\nWelcome to Notable Books of 2018!"
    puts "--------------------------------------------"
    puts <<~DOC
      The New York Times Book Review published a list of notable new book releases in 2018.
      You can use this gem to browse 2018's notable book selections and find more information about each book.

      You can view books by genre or view books by numbered list.
    DOC

    choose_display
  end

  def choose_display
    puts "\nEnter 1 to view books by genre, or"
    puts "Enter 2 to view books by numbered list."

    input = gets.chomp.to_i
    if input == 1
      view_books_by_genre
    elsif input == 2
      view_books_by_list
    else
      puts "That is not a valid selection."
      choose_display
    end
  end

  def view_books_by_genre
    list_genres
    choose_genre
    select_book_by_number_through_genre
    see_more_books_by_genre?
  end

  def list_genres
    puts "\nDisplaying All Genres"
    puts "\n"
    # could alphabetize genre names with: NotableBooks2018::Genre.all.sort_by{|genre| genre.name}.each do..
    @all_genre_names = []
    NotableBooks2018::Genre.all.collect do |genre|
      puts genre.name
      @all_genre_names << genre.name.downcase
    end
  end

  def choose_genre
    puts "\nEnter a genre name to browse its books."
    puts "Enter 'main' to return to the main menu or 'exit' to quit."

    @genre_name = gets.chomp.downcase

    if @all_genre_names.include?(@genre_name)
      display_books_by_genre(@genre_name)
    elsif @genre_name == "main"
      welcome
    elsif @genre_name == "exit"
      goodbye
    else
      puts "That is not a valid entry."
      choose_genre
    end
  end

  def display_books_by_genre(genre_name)
    #this capitalization works for all but "Comics/graphics."
    puts "\nViewing All #{genre_name.split.map(&:capitalize!).join(" ")} Books"
    puts ""

    @indices_from_genre = []
    NotableBooks2018::Genre.all.each do |genre|
      if genre_name == genre.name.downcase
        genre.books.each.with_index(1) do |book, index|
          puts "#{index}. #{book.title} by #{book.author}"
          @indices_from_genre << index.to_i
        end
      end
    end
  end

  def select_book_by_number_through_genre
    puts "\nEnter the number of a book you would like to read more about."
    puts "Or, you can enter 'list' to return the genre list or 'exit' to quit."

    @book_index_from_genre = gets.chomp

    if @indices_from_genre.include?(@book_index_from_genre.to_i)
      print_book_info_from_genre(@book_index_from_genre.to_i)
    elsif @book_index_from_genre == "list"
      view_books_by_genre
    elsif @book_index_from_genre == "exit"
      goodbye
    else
      puts "\nPlease enter a number between #{@indices_from_genre.first}-"\
      "#{@indices_from_genre.last}."
      select_book_by_number_through_genre
    end
  end

  def print_book_info_from_genre(book_index)
    NotableBooks2018::Genre.all.each do |genre_instance|
      if @genre_name == genre_instance.name.downcase
        genre_instance.books.each.with_index(1) do |book, index|
          if book_index == index
            puts ""
            puts book.title
            puts "by #{book.author}"
            puts ""
            puts "Genre(s):"
              book.genre.collect do |genre|
                puts genre.name
              end
            puts "\nDescription: #{book.description}"
            puts ""
          end
        end
      end
    end
  end

  def see_more_books_by_genre?
    puts <<~DOC
      Would you like to see another book?
        Enter 'Yes' to return to your chosen genre's books.
        You can enter 'list' to return to all genres.
        You can enter 'number' to switch to browsing books by number.
        Or enter 'exit' to quit.
    DOC

    input = gets.chomp.downcase

    case input
      when "yes"
        display_books_by_genre
        select_book_by_number_through_genre
        print_book_info_from_genre(@book_index_from_genre)
        see_more_books_by_genre?
      when "list"
        view_books_by_genre
      when "number"
        view_books_by_list
      when "exit"
        goodbye
      else
        puts "That is not a valid selction."
        see_more_books_by_genre?
    end
  end

  def view_books_by_list
    display_list
    @number_input = nil
    # also can use ||=, maybe
    # if input is equal to nil, run this block of code
      puts "\nPlease enter a number to see a list of books."
      puts "You can enter 'main' to return to the main menu or 'exit' to quit."
      @number_input = gets.chomp

      if (1..100).include?(@number_input.to_i)
        print_book_list(@number_input.to_i)
        select_book_by_number
        see_more_books?
      elsif @number_input.downcase == "main"
        welcome
      elsif @number_input.downcase == "exit"
        goodbye
      else
        puts "\nThat is not a valid selection."
        view_books_by_list
      end
      puts ""
  end

  def display_list
    puts <<~DOC

      View Books:
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

  def select_book_by_number
    # ADD HERE an option to return to main menu
    puts "\nEnter the number of a book you would like more information about."
    puts "Enter 'list' to return to the book list or 'exit' to quit."
    second_input = gets.chomp

    if ((@number_input.to_i)..((@number_input.to_i)+9)).include?(second_input.to_i)
      print_book_info(second_input.to_i)
    elsif second_input == "list"
      view_books_by_list
    elsif second_input.downcase == "exit"
      goodbye
    else
      puts "\nPlease enter a number #{@number_input.to_i}-#{(@number_input.to_i)+9} to get book information."
      select_book_by_number
    end

    #see_more_books?
  end

    def see_more_books?
      puts <<~DOC
        Would you like to see another book?
          Enter 'yes' to return to the book list.
          You can enter 'genre' to switch to browsing books by genre.
          Or enter 'exit' to quit.
      DOC

      input = gets.chomp.downcase

      case input
        when "yes"
          view_books_by_list
        when "genre"
          view_books_by_genre
        when "exit"
          goodbye
         else
          puts "\nThat is not a valid selection."
          see_more_books?
      end
    end

  def print_book_list(by_number)
    puts ""
    if by_number == 100
      puts "Displaying The 100th Notable Book"
      puts ""
    elsif by_number >= 92 && by_number != 100
      puts "Displaying Notable Books #{by_number} - 100"
      puts ""
    else
      puts "Displaying Notable Books #{by_number} - #{by_number+9}"
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
        puts "Genre(s):"
          book.genre.collect do |genre|
            puts genre.name
          end
        puts "\nDescription: #{book.description}"
        puts ""
      end
    end
  end

  def goodbye
    puts "\nThank you for browsing Notable Books 2018. Happy reading!"
    exit
  end

end
