require './lib/board'
require './lib/ship'

class Game
    attr_reader :player_board,
                :cpu_board,
                :player_cruiser,
                :player_submarine,
                :cpu_cruiser,
                :cpu_submarine

    def initialize
        @player_board = Board.new
        @cpu_board = Board.new
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
        @cpu_cruiser = Ship.new("Cruiser", 3)
        @cpu_submarine = Ship.new("Submarine", 2)
    end

    def valid_cpu_coordinates(ship)
        coordinates = []
        
        until @cpu_board.valid_placement?(ship, coordinates)
            coordinates = @cpu_board.cells.keys.sample(ship.length)
        end
        coordinates 
    end

    def place_cpu_ships
        ships = [@cpu_cruiser, @cpu_submarine]
        ships.each do |ship|
            coordinates = valid_cpu_coordinates(ship)
            @cpu_board.place(ship, coordinates)
        end
        puts @cpu_board.render(show = true)
    end

    def place_player_cruiser
        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your two ships."
        puts "The Cruiser is three units long and the Submarine is two units long."
        puts "Enter the squares for the Cruiser (3 spaces):"
        puts ">"

        user_input = gets.chomp.upcase.split 

        until @player_board.valid_placement?(@player_cruiser, user_input) == true 
            puts "Try again, type in different coordinates"
            user_input = gets.chomp.upcase.split 
        end
        @player_board.place(@player_cruiser, user_input)
         puts @player_board.render(show = true)
    end

    def place_player_submarine 

        puts "Enter the squares for the Submarine (2 spaces):"
        puts ">" 

        user_input = gets.chomp.upcase.split

        until @player_board.valid_placement?(@player_submarine, user_input) == true 
            puts "Try again, type in different coordinates"
            user_input = gets.chomp.upcase.split 
        end
        @player_board.place(@player_submarine, user_input)
         puts @player_board.render(show = true)
    end

    def turn
        puts "=============COMPUTER BOARD============="
        puts @cpu_board.render
        puts "==============PLAYER BOARD=============="
        puts @player_board.render(show = true)
    end

    # def player_shot

    #     user_input = gets.chomp.upcase
    #     @cpu_board.valid_coordinate?(user_input) == true
    #     @cpu_board.cells[user_input].fire_upon
    #     if @cpu_board.cells[user_input].empty?
    #         "M"
    #         puts "I will get you next time"
    #     elsif @cpu_board.cells[user_input].ship.sunk?
    #         "X"
    #         puts "I destroyed your ship"
    #     elsif @cpu_board.cells[user_input].!empty?
    #         "H"
    #         puts "I got you this time"
    #     else 
    #         "."
    #     end

    # end

    def start 
        puts "Welcome to BATTLESHIP"
        puts "Enter p to play. Enter q to quit."

        user_input = gets.chomp.downcase
        if user_input == "p"
            place_cpu_ships
            place_player_cruiser
            place_player_submarine
            turn
            # player_shot
        else
            p "Come again"
        end
    end

  








end