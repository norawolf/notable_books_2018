class NotableBooks2018::CLI

  def run
    NotableBooks2018::Scraper.scrape_book_info
    welcome
    goodbye
  end

  def welcome
    puts "\n--------------------------------------------"
    puts Paint["\nWelcome to Notable Books of 2018!", :bright]
    puts "\n--------------------------------------------"
    puts <<~DOC

      The New York Times Book Review published a list of notable new book releases in 2018.
      You can use this gem to browse 2018's book selections and find more information about each book.

      You can view books by genre or view books by numbered list.
    DOC

    choose_display
  end

  def choose_display
    puts "\nEnter #{Paint["1", :magenta]} to view books by genre."
    puts "Enter #{Paint["2", :magenta]} to view books by numbered list."
    puts "Or, enter #{Paint["exit", :magenta]} to quit."

    input = gets.chomp
    if input.to_i == 1
      view_books_by_genre
    elsif input.to_i == 2
      choose_books_by_num
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
    # could alphabetize genre names with: NotableBooks2018::Genre.all.sort_by{|genre| genre.name}.each do..
    @all_genre_names = []
    NotableBooks2018::Genre.all.collect do |genre|
      puts genre.name
      @all_genre_names << genre.name.downcase
    end
  end

  def choose_genre
    puts "\nEnter a #{Paint["genre name", :magenta]} to browse books by genre."
    puts "Enter #{Paint["'main'", :magenta]} to return to the main menu or #{Paint["'exit'", :magenta]} to quit."

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
    puts "\n--------------------------------------------"
    puts Paint["Viewing: #{genre_name.split.map(&:capitalize!).join(" ")}", :bright]
    puts "--------------------------------------------"
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
    puts "\nEnter the #{Paint["number", :magenta]} of a book you would like to read more about."
    puts "Or, you can enter #{Paint["'list'", :magenta]} to return the genre list or #{Paint["'exit'", :magenta]} to quit."

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
            book_info_contents(book)
          end
        end
      end
    end
  end

  def see_more_books_by_genre
    puts <<~DOC
      Would you like to see another book?
        Enter #{Paint["'yes'", :magenta]} to return to your chosen genre's books.
        You can enter #{Paint["'list'", :magenta]} to return to all genres.
        You can enter #{Paint["'number'", :magenta]} to switch to browsing books by number.
        Or enter #{Paint["'exit'", :magenta]} to quit.
    DOC

    input = gets.chomp.downcase

    case input
      when "yes"
        display_books_by_genre(@genre_name)
        select_book_by_number_through_genre
        print_book_info_from_genre(@book_index_from_genre)
        see_more_books_by_genre
      when "list"
        view_books_by_genre
      when "number"
        choose_books_by_num
      when "exit"
        goodbye
      else
        puts "That is not a valid selction."
        see_more_books_by_genre
    end
  end

  def display_number_groups
    puts <<~DOC

      --------------------------------------------

      #{Paint["View Books Numbered:", :bright]}
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
    display_number_groups
    @number_input = nil

    puts "\nPlease enter a #{Paint["number", :magenta]} to see a list of books."
    puts "You can enter #{Paint["'main'", :magenta]} to return to the main menu or #{Paint["'exit'", :magenta]} to quit."

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
      puts "#{Paint["Displaying Notable Books #{by_number} - #{by_number+9}", :bright]}"
      puts "--------------------------------------------"
      puts ""
    end

    NotableBooks2018::Book.all[by_number-1, 10].each.with_index(by_number) do |book, index|
      puts "#{index}. #{book.title} by #{book.author}"
    end
  end


  def select_book_by_number
    puts "\nEnter the #{Paint["number", :magenta]} of a book you would like more information about."
    puts "Enter #{Paint["'list'", :magenta]} to return to the book list or #{Paint["'exit'", :magenta]} to quit."
    second_input = gets.chomp

    if ((@number_input.to_i)..((@number_input.to_i)+9)).include?(second_input.to_i)
      print_book_info(second_input.to_i)
    elsif second_input == "list"
      choose_books_by_num
    elsif second_input.downcase == "exit"
      goodbye
    else
      puts "\nPlease enter a number #{@number_input.to_i}-#{(@number_input.to_i)+9} to get book information."
      select_book_by_number
    end
  end

  def print_book_info(book_index)
    NotableBooks2018::Book.all.each.with_index(1) do |book, index|
      if index == book_index
        book_info_contents(book)
      end
    end
  end

  def book_info_contents(book)
    puts "\n--------------------------------------------"
    puts Paint["#{book.title}", :bright]
    puts "by #{book.author}"
    puts "--------------------------------------------"
    puts "#{Paint["\nPublication Details:", :bright]} #{book.publication_info}"
    if book.genre.length == 1
      puts Paint["\nGenre:", :bright]
    else
      puts Paint["\nGenres:", :bright]
    end
    book.genre.collect do |genre|
      puts "#{genre.name}"
    end
    puts Paint["\nDescription:",:bright]
    puts "#{wrap_text(book.description)}"
    puts ""
  end

  def wrap_text(txt, col = 80)
    txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end

  def see_more_books
    puts <<~DOC
      Would you like to see another book?
        Enter #{Paint["'yes'", :magenta]} to return to the book list.
        You can enter #{Paint["'genre'", :magenta]} to switch to browsing books by genre.
        Or enter #{Paint["'exit'", :magenta]} to quit.
    DOC

    input = gets.chomp.downcase

    case input
      when "yes"
        choose_books_by_num
      when "genre"
        view_books_by_genre
      when "exit"
        goodbye
      else
        puts "\nThat is not a valid selection."
        see_more_books
    end
  end

  def goodbye
    puts "\nThank you for browsing Notable Books 2018. Happy reading!"
    exit
  end

end
