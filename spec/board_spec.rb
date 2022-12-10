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

    describe "valid_placement?" do
        it "invalid_coordinates" do

            expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
            expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
  
        end

        it "invalid_consecutive" do
            expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
            expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
        end

        it "invalid_diagonal" do
            expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
        end

        it "valid_coordinate" do
            expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
            expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
        end
    end

    it "placing_ships" do

        board.place(cruiser, ["A1", "A2", "A3"])   
        cell_1 = board.cells["A1"] 
        cell_2 = board.cells["A2"]
        cell_3 = board.cells["A3"]


        expect(cell_1.ship).to eq(cruiser)
        expect(cell_2.ship).to eq(cruiser)
        expect(cell_3.ship).to eq(cruiser)
        expect(cell_3.ship == cell_2.ship).to eq(true)

    end

    it "can't_overlap" do

        board.place(cruiser, ["A1", "A2", "A3"])
       
        expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)

    end

    it "rendering the board" do

        board.place(cruiser, ["A1", "A2", "A3"]) 
        expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    end 


end