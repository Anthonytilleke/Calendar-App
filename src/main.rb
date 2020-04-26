require 'faker'
require 'colorize'
require 'tty-prompt'

class Hangman

    def initialize()
        @guessing_word = ""
        @array_of_guessing_words = []
        @letters_in_word = []
        @lives = 6
        @correct_letters = []
        @incorrect_letters = []
        @letters_included_array = []
        @theme =  ""
        @the_word = 

    end

    def faker_word 
        while true
            puts "Please select a number corresponding to the theme you would like to choose:"
            puts "\n1) Animals\n2) Pokemon\n3) Books\n4) Food"
            @theme = gets.chomp
            case @theme
            when "1"
                @guessing_word = Faker::Creature::Animal.name.upcase
                break  
            when "2"
                @guessing_word = Faker::Games::Pokemon.name.upcase
                break
            when "3"
                @guessing_word = Faker::Book.title.upcase
                break
            when "4"
                @guessing_word = Faker::Food.dish.upcase
                break
            else
                puts "Invalid choice, please try again."
            end
        end
    end


    def begin
        
    end


end

