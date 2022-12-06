require 'rspec'
require './lib/ship'

Rspec.describe Ship do
    it "exists" do
        cruiser = Ship.new("Cruiser", 3)

        expect(ship).to be_an_instance_of(ship)
    end
        
    it "has attributes" do
        cruiser = Ship.new("Cruiser", 3)

        expect(ship.name).to eq("Cruiser")
        expect(ship.length).to eq(3)
        expect(ship.health).to eq(ship.length)
    end

end
