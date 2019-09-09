require "./bin/airport.rb"
require "./bin/fuel_inventory.rb"
RSpec.describe Airport do
	
	let(:fuel_quantity){ 20000 }
	let(:fuel_inventory){ FuelInventory.new(fuel_quantity) }
	let(:aircraft){ Aircraft.new('6E-102') }
	let(:airport){ Airport.new(1, "Indira Gandhi International Airport", "Delhi", fuel_inventory) }

	it "shows Airport details" do
		expect(airport.full_name).to eq("Indira Gandhi International Airport, Delhi")
		expect(airport.available_fuel).to eq(fuel_quantity)
	end

	context "Fill aircraft" do
		it "fills `20000` ltrs fuel in aircraft" do
			expect(airport.fill_aircraft(aircraft.aircraft_id, fuel_quantity)).to eq("Success: Request for the has been fulfilled\n")
		end

		it "shows error when request for the fuel is beyond availability at airport" do
			expect(airport.fill_aircraft(aircraft, fuel_quantity * 4)).to end_with("Failure: Request for the fuel is beyond availability at airport\n")
		end
	end
end