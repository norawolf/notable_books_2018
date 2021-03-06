class NotableBooks2018::CLI

  def run
    NotableBooks2018::Scraper.scrape_book_info
    welcome
    goodbye
  end

  def welcome
    puts "\n--------------------------------------------"
    puts Paint["Welcome to Notable Books of 2018!", :bright]
    puts "--------------------------------------------"
    puts <<~DOC

      At the end of 2018, The New York Times Book Review published a list of the
      notable new book releases from that year. You can use this gem to browse
      2018's book selections and find more information about each book that
      interests you.

      Would you like to browse books by genre or view books by list number?
    DOC

    choose_display
  end

  def choose_display
    puts "\nEnter #{Paint["1", :magenta]} to view books by genre."
    puts "Enter #{Paint["2", :magenta]} to view the numbered book list."
    print_quit_choice

    input = gets.chomp
    if input.to_i == 1
      view_books_by_genre
    elsif input.to_i == 2
      view_books_by_num
    elsif input == "exit"
      goodbye
    else
      not_valid
      choose_display
    end
  end

  def view_books_by_genre
    list_genres
    choose_genre
    select_book_by_number_through_genre
    see_more_books_by_genre
  end

  def list_genres
    puts "\n--------------------------------------------"
    puts Paint["Displaying All Genres", :bright]
    puts "--------------------------------------------"
    puts "\n"

    NotableBooks2018::Genre.all_names.each do |name|
      puts format_genre(name)
    end
  end

  def choose_genre
    puts "\nEnter a #{Paint["genre name", :magenta]} to browse books by genre."
    print_main_menu_choice
    print_quit_choice

    genre_name = gets.chomp.downcase

    if NotableBooks2018::Genre.all_names.include?(genre_name)
      @genre_obj = NotableBooks2018::Genre.find_by_name(genre_name)
      print_books_by_genre
    elsif genre_name == "main"
      welcome
    elsif genre_name == "exit"
      goodbye
    else
      not_valid
      choose_genre
    end
  end

  def print_books_by_genre
    puts "\n--------------------------------------------"
    puts Paint["Viewing: #{format_genre(@genre_obj.name)}", :bright]
    puts "--------------------------------------------"
    puts ""

    @genre_obj.books.each.with_index(1) do |book, index|
      puts "#{index}. #{book.title} by #{book.author}"
    end
  end

  def select_book_by_number_through_genre
    print_read_more
    puts "Or, enter #{Paint["'back'", :magenta]} to return the genre list."
    print_quit_choice

    @index_input = gets.chomp

    if (1..@genre_obj.books.size).include?(@index_input.to_i)
      print_book_attributes(@genre_obj.find_by_index(@index_input))
    elsif @index_input == "back"
      view_books_by_genre
    elsif @index_input == "exit"
      goodbye
    else
      puts "\nPlease enter a number between 1-#{@genre_obj.books.size}."
      select_book_by_number_through_genre
    end
  end

  def see_more_books_by_genre
    print_see_another
    puts <<~DOC
      Enter #{Paint["'back'", :magenta]} to return to your chosen genre's books.
      Enter #{Paint["'list'", :magenta]} to return to view all genres.
      Enter #{Paint["'number'", :magenta]} to switch to browsing books by number.
    DOC
    print_quit_choice

    input = gets.chomp.downcase

    case input
      when "back"
        print_books_by_genre
        select_book_by_number_through_genre
        print_book_attributes(@genre_obj.find_by_index(@index_input))
        see_more_books_by_genre
      when "list"
        view_books_by_genre
      when "number"
        view_books_by_num
      when "exit"
        goodbye
      else
        not_valid
        see_more_books_by_genre
    end
  end

  def view_books_by_num
    display_number_groups
    choose_books_by_num
  end

  def display_number_groups
    puts <<~DOC

      --------------------------------------------
      #{Paint["View Books Numbered:", :bright]}
      --------------------------------------------
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

  def choose_books_by_num
    @number_input = nil

    puts "\nTo browse books, you can enter a number suggested above"
    puts "or enter any number 1 - 100 to start the list."
    puts "\nEnter a #{Paint["number", :magenta]} number to generate a list of books."

    print_main_menu_choice
    print_quit_choice

    @number_input = gets.chomp

    if (1..100).include?(@number_input.to_i)
      @number_input = @number_input.to_i
      print_book_list
      select_book_by_number
      see_more_books
    elsif @number_input.downcase == "main"
      welcome
    elsif @number_input.downcase == "exit"
      goodbye
    else
      not_valid
      choose_books_by_num
    end
    puts ""
  end

  def print_book_list
    if @number_input == 100
      puts "\n--------------------------------------------"
      puts "#{Paint["Displaying The 100th Notable Book", :bright]}"
      puts "--------------------------------------------"
    elsif @number_input >= 92 && @number_input != 100
      puts "\n--------------------------------------------"
      puts "#{Paint["Displaying Notable Books #{@number_input} - 100", :bright]}"
      "--------------------------------------------"
    else
      puts "\n--------------------------------------------"
      puts "#{Paint["Displaying Notable Books #{@number_input} - #{@number_input+9}",
        :bright]}"
      puts "--------------------------------------------"
      puts ""
    end

    NotableBooks2018::Book.all[@number_input-1, 10].each.with_index(@number_input) do |book, index|
        puts "#{index}. #{book.title} by #{book.author}"
    end
  end


  def select_book_by_number
    print_read_more
    puts "Or, enter #{Paint["'back'", :magenta]} to return to the numbered book list"
    print_quit_choice

    second_input = gets.chomp

    if (@number_input..@number_input+9).include?(second_input.to_i)
      print_book_attributes(NotableBooks2018::Book.find_by_index(second_input.to_i))
    elsif second_input == "back"
      view_books_by_num
    elsif second_input.downcase == "exit"
      goodbye
    else
      puts "\nPlease enter a number #{@number_input.to_i}-#{(@number_input.to_i)+9}."
      select_book_by_number
    end
  end

  def print_book_attributes(book)
    puts "\n--------------------------------------------"
    puts Paint["#{book.title}", :bright]
    puts "by #{book.author}"
    puts "--------------------------------------------"
    puts "#{Paint["\nPublisher:", :bright]} #{book.publisher}"
    puts "#{Paint["Price:", :bright]} #{book.price}"
    if book.genres.length == 1
      puts Paint["\nGenre:", :bright]
    else
      puts Paint["\nGenres:", :bright]
    end
    book.genres.each do |genre|
      puts "#{format_genre(genre.name)}"
    end
    puts Paint["\nDescription:",:bright]
    puts "#{wrap_text(book.description)}"
    puts "\n--------------------------------------------"
  end

  def see_more_books
    print_see_another
    puts <<~DOC
      Enter #{Paint["'back'", :magenta]} to return to your selected list.
      Enter #{Paint["'list'", :magenta]} to return to the main list of books by number.
      Enter #{Paint["'genre'", :magenta]} to switch to browsing books by genre.
    DOC
    print_quit_choice

    input = gets.chomp.downcase

    case input
    when "back"
        print_book_list
        select_book_by_number
        see_more_books
      when "list"
        view_books_by_num
      when "genre"
        view_books_by_genre
      when "exit"
        goodbye
      else
        not_valid
        see_more_books
    end
  end

  def format_genre(name)
    if name.include?("/")
      name.split("/").map(&:capitalize).join("/")
    else
      name.split.map(&:capitalize).join(" ")
    end
  end

  def print_quit_choice
    puts "Enter #{Paint["'exit'", :magenta]} to quit."
  end

  def print_main_menu_choice
    puts "Enter #{Paint["'main'", :magenta]} to return to the main menu."
  end

  def not_valid
    puts "\nThat is not a valid selction."
  end

  def print_read_more
    puts "\nEnter the #{Paint["number", :magenta]} of a book you would like "\
      "to read more about."
  end

  def print_see_another
    puts "Would you like to see another book?"
  end

  def wrap_text(txt, col = 80)
    txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end

  def goodbye
    puts "\nThank you for browsing Notable Books 2018. Happy reading!"
    exit
  end

end
