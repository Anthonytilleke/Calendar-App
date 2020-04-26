require 'colorize'
require 'faker'


class Hangman

  def initialize
    @word = ""
    @lives = 6
    @correct_guesses = []
    @word_teaser = ""
    @theme = ""
   
    @word.split.times do 
      @word_teaser += '_ '
    end
    

  end

  def clean_terminal
    Gem.win_platform? ? (system "cls") : (system "clear")
  end


  def hm_art file_name
    hm_art = File.join(File.dirname(__FILE__), '..', 'art', file_name)
    img = File.read(hm_art)
  end

  def yes? response 
    case response
      when "y", "Y"
        return true
      when "n", "N"
        return false
      else
        puts "Please enter y/Y or n/N:".colorize(:red)
        yes?(gets.chomp)
    end
  end

  def welcome
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
      puts "\n1) Animals\n2) Pokemon\n3) Books\n4) Food"
      @theme = gets.chomp
      case @theme 
      when "1"
        @word = Faker::Creature::Animal.name
        break
      when "2"
        @word = Faker::Games::Pokemon.name
        break
      when "3" 
        @word = Faker::Book.title
        break 
      when "4"
        @word = Faker::Food.dish
        break
      else
          puts "Invalid choice, please try again.".colorize(:red)
      end
    end
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
      puts "Enter a letter".colorize(:light_blue)
      guess = gets.chomp

      good_guess = @word.include? guess

      if guess == "exit"
        puts "Thank you for playing!"
      elsif good_guess
        puts "Good guess!".colorize(:green)

        print_teaser guess

        if @word == @word_teaser.split.join
          puts "Wow! Congratulations.. you have won this round!".colorize(:light_green)
        else
          make_guess
        end
      else
        @lives -= 1
        puts "Unlucky, you have #{@lives} lives remaining!".colorize(:light_red)
        print_teaser 
        puts "Your word has #{@word.size} letters."
        make_guess  
      end
    else
      puts "Gave Over!".colorize(:red)
    end
  end


  def begin
    welcome
    word
    print_teaser 
    puts "Your word has #{@word.size} letters." 
    make_guess
     
  end



end

game = Hangman.new
game.begin
