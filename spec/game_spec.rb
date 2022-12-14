require './spec/spec_helper'

RSpec.describe Game do

    let(:game) {Game.new}

    it "exists" do
        expect(game).to be_an_instance_of(Game)
    end

    it "initialize" do
        expect(game.player_board).to be_an_instance_of(Board)
        expect(game.cpu_board).to be_an_instance_of(Board)
        expect(game.player_cruiser).to be_a(Ship)
        expect(game.player_submarine).to be_a(Ship)
        expect(game.cpu_cruiser).to be_a(Ship)
        expect(game.cpu_submarine).to be_a(Ship)
    end
   
    it "valid_cpu_coordinates" do
        cpu_cruiser = game.cpu_cruiser
        cpu_submarine = game.cpu_submarine

        expect(game.valid_cpu_coordinates(cpu_cruiser).length).to eq(cpu_cruiser.length)
        expect(game.valid_cpu_coordinates(cpu_submarine).length).to eq(cpu_submarine.length)
    end

    it "place_cpu_ships" do
        game.place_cpu_ships
        expect(game.cpu_board.cells.values.map(&:ship).compact.empty?).to eq(false)
    end
end