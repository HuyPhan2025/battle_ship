require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
    let(:cell) {Cell.new("B4")}
    let(:cruiser) {Ship.new("Cruiser", 3)} 
    let(:cell_2) {Cell.new("C3")}

    it "exists" do
        
        expect(cell).to be_an_instance_of(Cell)

    end

    it "has coordinate" do

        expect(cell.coordinate).to eq("B4")
        expect(cell.ship).to eq(nil)
        expect(cell.empty?).to eq(true)

    end

    it "place ship" do

        cell.place_ship(cruiser)
        expect(cell.ship).to eq(cruiser)
        expect(cell.empty?).to eq(false)

    end

    it "fire upon?" do
        # require 'pry'; binding.pry
        cell.place_ship(cruiser)
        expect(cell.fired_upon?).to eq(false)
        cell.fire_upon
        expect(cell.ship.health).to eq(2)
        expect(cell.fired_upon?).to eq(true)

    end

    it "render" do

        expect(cell.render).to eq(".")
        cell.fire_upon
        expect(cell.render).to eq("M")
        cell_2.place_ship(cruiser)
        expect(cell_2.render).to eq(".")
        expect(cell_2.render(true)).to eq("S")
        cell_2.fire_upon
        expect(cell_2.render).to eq("H")
        expect(cruiser.sunk?).to eq(false)
        cruiser.hit
        cruiser.hit
        expect(cruiser.sunk?).to eq(true)
        expect(cell_2.render).to eq("X")

    end
end