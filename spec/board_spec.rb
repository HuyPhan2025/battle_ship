require 'rspec'
require './lib/cell'
require './lib/board'
require './lib/ship'

RSpec.describe Board do
    let(:board) {Board.new}
    let(:cruiser) {Ship.new("Cruiser", 3)} 
    let(:submarine) {Ship.new("Submarine", 2)} 

    it "exists" do
        
       expect(board).to be_an_instance_of(Board)

    end

    it "has cells" do

      expect(board.cells).to be_an_instance_of(Hash)

    end

    it "valid_coordinate?" do

        expect(board.valid_coordinate?("A1")).to eq(true)
        expect(board.valid_coordinate?("D4")).to eq(true)
        expect(board.valid_coordinate?("A5")).to eq(false)
        expect(board.valid_coordinate?("E1")).to eq(false)
        expect(board.valid_coordinate?("A22")).to eq(false)
        
    end

    it "valid_placement?" do

        expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
        # expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
        # expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)

    end

    it "consecutive_valid_placement?" do
        expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
        expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
        expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
        expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end

    it "!diagonal_valid_placement?" do
        expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
        expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    end

    it "true_valid_placement?" do
        expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
        expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    end


end