require 'colorize'
require 'faker'


class Hangman

  def initialize
    @word = ""
    @lives = 6
    @word_teaser = " "
    @theme = ""
    @letters_chosen = []

  end

  #method to clean terminal when ever its called
  def clean_terminal
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  #method to make .txt files in art folder availiable here
  def hm_art file_name
    hm_art = File.join(File.dirname(__FILE__), '..', 'art', file_name)
    img = File.read(hm_art)
  end
  
  #method to help with platers response
  def yes? response 
    case response
      when "y", "Y"
        return true
      when "n", "N", "exit"
        return false
      else
        puts "Please enter y/Y or n/N:".colorize(:red)
        yes?(gets.chomp)
    end
  end

  def welcome
    clean_terminal
    puts hm_art('title.txt').colorize(:green)
    puts "Welcome to Hangman!".colorize(:red)
    puts "Instructions\n - Choose a theme of your choice\n - Attempt to uncover the hidden word\n - If you uncover the word before all your lives are up You Win!\n - If you run out of lives before that... Game Over!".colorize(:blue)
    puts "To exit the game at any point type 'exit'".colorize(:light_blue)

    puts "Start New Game? (Y/N)".colorize(:light_green)
    
    if not yes?(gets.chomp)
        puts "Closing game...".colorize(:light_red)
        exit
    end
    clean_terminal

  end

  def word
    while true
      puts "Please select a number corresponding to the theme you would like to choose:".colorize(:light_blue)
      puts "\n1) ANIMALS\n2) POKEMON\n3) BOOKS\n4) FOOD".colorize(:light_green)
      @theme = gets.chomp
      case @theme 
      when "1"
        @word = Faker::Creature::Animal.name.downcase
        break
      when "2"
        @word = Faker::Games::Pokemon.name.downcase
        break
      when "3" 
        @word = Faker::Book.title.downcase
        break 
      when "4"
        @word = Faker::Food.dish.downcase
        break
      when "exit"
        puts "Closing game...".colorize(:light_red)
        exit
        break
      else
          puts "Invalid choice, please try again.".colorize(:red)
      end
    end
  
    clean_terminal
  
  end


  def print_teaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser last_guess
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      if letter == '_' && @word[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess 
    if @lives > 0
      puts "The Hidden word has #{@word.size} letters."
      puts "Enter a letter".colorize(:light_blue)
      guess = gets.chomp

      good_guess = @word.include? guess        
    
      if guess == "exit"
        puts "Thanks for playing!".colorize(:light_blue)
      
      elsif good_guess
        clean_terminal
        puts hm_art("#{@lives}livesleft.txt").colorize(:yellow)
        puts "Good guess! #{guess.upcase} is in the hidden word".colorize(:green)

        print_teaser guess
        
        
        if @word == @word_teaser.split.join
          puts hm_art('victoryscreen.txt').colorize(:yellow)
          puts "Wow! Congratulations.. you have won this round!".colorize(:light_green)
        else
          make_guess
        end
      else
        @lives -= 1
        clean_terminal
        puts hm_art("#{@lives}livesleft.txt").colorize(:yellow)
        puts "Unlucky, you have #{@lives} lives remaining!".colorize(:light_red)
        puts "#{guess.upcase} is not in the hidden word".colorize(:light_red)

        print_teaser
        make_guess  
      end
    else
      puts "Your word was: #{@word}".colorize(:light_blue)
      puts "GAME OVER!".colorize(:red)
    end
  end

  def begin_game

    welcome
    word
    def m1
      @word.size.times do
        str = @word_teaser += "_ ".delete("\n")
        puts str
      end
      print_teaser
    end
    m1
    make_guess
  end



end

game = Hangman.new
game.begin_game

