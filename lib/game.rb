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
end