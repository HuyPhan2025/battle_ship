class Board
    attr_reader :cells
    def initialize
        @cells = {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4"),            
        }
    end
    
    def valid_coordinate?(coordinate)
        @cells[coordinate] != nil
    end
    
    def valid_placement?(ship, coordinates) 
        ship.length == coordinates.length &&
        horizontal_valid_placement?(coordinates) &&
        vertical_valid_placement?(coordinates) 
    end
    
    def duplicate_letter?(coordinates)
        letter = coordinates.map { |coordinate| coordinate.split('').first }
        letter.each_cons(2).all? { |letter_1, letter_2| letter_1 == letter_2 }
    end

    def consecutive_number?(coordinates)
        number = coordinates.map { |coordinate| coordinate.split('').last }
        number.each_cons(2).all? { |number_1, number_2| number_2.to_i - 1 == number_1.to_i }
    end

    def horizontal_valid_placement?(coordinates)
        duplicate_letter?(coordinates) && consecutive_number?(coordinates)
    end

    def consecutive_letter?(coordinates)
        letter = coordinates.map { |coordinate| coordinate.split('').first }
        letter.each_cons(2).all? { |letter_1, letter_2| letter_2.ord - 1 == letter_1.ord }
    end

    def duplicate_number?(coordinates)
        number = coordinates.map { |coordinate| coordinate.split('').last }
        number.each_cons(2).all? { |number_1, number_2| number_2.to_i == number_1.to_i }
    end

    def vertical_valid_placement?(coordinates)
        consecutive_letter?(coordinates) && duplicate_number?(coordinates)
    end


    
end

    