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
    end

    def start 
        p "Welcome to BATTLESHIP"
        p "Enter p to play. Enter q to quit."

        user_input = gets.chomp.upcase
        if user_input == "p"
            place_cpu_ships
        else
            p "Come again"
        end
    end

    def turn_action
        p "I have laid out my ships the grid."
        p "You now need to lay out your two ships."
        p "The Cruiser is three units long and the Submarine is two units long."





    end
end