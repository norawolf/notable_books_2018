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
    puts "Or, enter #{Paint["'exit'", :magenta]} to quit."

    input = gets.chomp
    if input.to_i == 1
      view_books_by_genre
    elsif input.to_i == 2
      view_books_by_num
    elsif input == "exit"
      goodbye
    else
      puts "\nThat is not a valid selection."
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
      puts name.split.map(&:capitalize).join(" ")
    end
  end

  def choose_genre
    puts "\nEnter a #{Paint["genre name", :magenta]} to browse books by genre."
    puts "Enter #{Paint["'main'", :magenta]} to return to the main menu or "\
      "#{Paint["'exit'", :magenta]} to quit."

    genre_name = gets.chomp.downcase

    if NotableBooks2018::Genre.all_names.include?(genre_name)
      @genre_obj = NotableBooks2018::Genre.find_by_name(genre_name)
      print_books_by_genre
    elsif genre_name == "main"
      welcome
    elsif genre_name == "exit"
      goodbye
    else
      puts "\nThat is not a valid entry."
      choose_genre
    end
  end

  def print_books_by_genre
    puts "\n--------------------------------------------"
    puts Paint["Viewing: #{@genre_obj.name.split.map(&:capitalize!).join(" ")}",
      :bright]
    puts "--------------------------------------------"
    puts ""

    @indices_from_genre = []

    @genre_obj.books.each.with_index(1) do |book, index|
      puts "#{index}. #{book.title} by #{book.author}"
      @indices_from_genre << index
    end
  end

  def select_book_by_number_through_genre
    puts "\nEnter the #{Paint["number", :magenta]} of a book you would like "\
      "to read more about."
    puts "Or, enter #{Paint["'back'", :magenta]} to return the genre list or "\
      "#{Paint["'exit'", :magenta]} to quit."

    @index_from_genre = gets.chomp

    # is there another way to access the indices, apart from storing them in an instance variable?
    # or a better way?
    if @indices_from_genre.include?(@index_from_genre.to_i)
      print_book_attributes(@genre_obj.find_by_index(@index_from_genre))
    elsif @index_from_genre == "back"
      view_books_by_genre
    elsif @index_from_genre == "exit"
      goodbye
    else
      puts "\nPlease enter a number between #{@indices_from_genre.first}-"\
      "#{@indices_from_genre.last}."
      select_book_by_number_through_genre
    end
  end

  def see_more_books_by_genre
    puts <<~DOC
      Would you like to see another book?
      Enter #{Paint["'back'", :magenta]} to return to your chosen genre's books.
      Enter #{Paint["'list'", :magenta]} to return to view all genres.
      Enter #{Paint["'number'", :magenta]} to switch to browsing books by number.
      Enter #{Paint["'exit'", :magenta]} to quit.
    DOC

    input = gets.chomp.downcase

    case input
      when "back"
        print_books_by_genre
        select_book_by_number_through_genre
        print_book_attributes(@genre_obj.find_by_index(@index_from_genre))
        see_more_books_by_genre
      when "list"
        view_books_by_genre
      when "number"
        view_books_by_num
      when "exit"
        goodbye
      else
        puts "\nThat is not a valid selction."
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

    puts "\nEnter a #{Paint["number", :magenta]} to see a list of books."
    puts "Enter #{Paint["'main'", :magenta]} to return to the main menu or "\
    "#{Paint["'exit'", :magenta]} to quit."

    @number_input = gets.chomp

    if (1..100).include?(@number_input.to_i)
      print_book_list(@number_input.to_i)
      select_book_by_number
      see_more_books
    elsif @number_input.downcase == "main"
      welcome
    elsif @number_input.downcase == "exit"
      goodbye
    else
      puts "\nThat is not a valid selection."
      choose_books_by_num
    end
    puts ""
  end

  def print_book_list(by_number)
    if by_number == 100
      puts "\n--------------------------------------------"
      puts "#{Paint["Displaying The 100th Notable Book", :bright]}"
      puts "--------------------------------------------"
    elsif by_number >= 92 && by_number != 100
      puts "\n--------------------------------------------"
      puts "#{Paint["Displaying Notable Books #{by_number} - 100", :bright]}"
      "--------------------------------------------"
    else
      puts "\n--------------------------------------------"
      puts "#{Paint["Displaying Notable Books #{by_number} - #{by_number+9}",
        :bright]}"
      puts "--------------------------------------------"
      puts ""
    end

    NotableBooks2018::Book.all[by_number-1, 10].each.with_index(by_number) do |book, index|
        puts "#{index}. #{book.title} by #{book.author}"
    end
  end


  def select_book_by_number
    puts "\nEnter the #{Paint["number", :magenta]} of a book you would like "\
      "more information about."
    puts "Or, enter #{Paint["'back'", :magenta]} to return to the numbered "\
      "book list or #{Paint["'exit'", :magenta]} to quit."
    second_input = gets.chomp

    if ((@number_input.to_i)..((@number_input.to_i)+9)).include?(second_input.to_i)
      print_book_info(second_input.to_i)
    elsif second_input == "back"
      view_books_by_num
    elsif second_input.downcase == "exit"
      goodbye
    else
      puts "\nPlease enter a number #{@number_input.to_i}-#{(@number_input.to_i)+9}."
      select_book_by_number
    end
  end

  def print_book_info(book_index)
    NotableBooks2018::Book.all.each.with_index(1) do |book, index|
      if index == book_index
        print_book_attributes(book)
      end
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
    book.genres.collect do |genre|
      #fix to capitalize here
      puts "#{genre.name}"
    end
    puts Paint["\nDescription:",:bright]
    puts "#{wrap_text(book.description)}"
    puts "\n--------------------------------------------"
  end

  def see_more_books
    puts <<~DOC
      Would you like to see another book?
      Enter #{Paint["'back'", :magenta]} to return to your selected list.
      Enter #{Paint["'list'", :magenta]} to return to the main list of books by number.
      Enter #{Paint["'genre'", :magenta]} to switch to browsing books by genre.
      Enter #{Paint["'exit'", :magenta]} to quit.
    DOC

    input = gets.chomp.downcase

    case input
    when "back"
        print_book_list(@number_input.to_i)
        select_book_by_number
        see_more_books
      when "list"
        view_books_by_num
      when "genre"
        view_books_by_genre
      when "exit"
        goodbye
      else
        puts "\nThat is not a valid selection."
        see_more_books
    end
  end

  def wrap_text(txt, col = 80)
    txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end

  def goodbye
    puts "\nThank you for browsing Notable Books 2018. Happy reading!"
    exit
  end

end
