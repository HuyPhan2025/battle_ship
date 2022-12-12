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
        player_shot
        cpu_shot
        if @cpu_cruiser.sunk? && @cpu_submarine.sunk?
            puts "You win you beautiful bastard!"

        elsif @player_cruiser.sunk? && @player_submarine.sunk?
            puts "Better luck next time you good for nothing slug!"

        else 
            turn
        end
    end

    def player_shot
        puts "Please enter the coordinate you want to fire upon."
        fire_input = gets.chomp.upcase
    
        until @cpu_board.valid_coordinate?(fire_input) && @cpu_board.cells[fire_input].fired_upon? == false
            puts "Invalid coordinate.  Pick a different coordinate that is valid, wtf."
            fire_input = gets.chomp.upcase
        end
    
        @cpu_board.cells[fire_input].fire_upon
        fire_input 
    
    end

    def cpu_shot
        cpu_shot = @player_board.cells.keys.sample
    
        until @player_board.cells[cpu_shot].fired_upon? == false
            cpu_shot = @player_board.cells.keys.sample
        end
    
        @player_board.cells[cpu_shot].fire_upon
        cpu_shot
    end

    def start 
        puts "Welcome to BATTLESHIP"
        puts "Enter p to play. Enter q to quit."

        user_input = gets.chomp.downcase
        if user_input == "p"
            place_cpu_ships
            place_player_cruiser
            place_player_submarine
            turn
            
        else
            p "Come again"
        end
    end
end