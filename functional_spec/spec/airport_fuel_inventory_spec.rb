require 'singleton'
require "./bin/airport_fuel_inventory_system.rb" 
RSpec.describe AirportFuelInventorySystem do
	let(:airport_fuel_inventory){AirportFuelInventorySystem.instance}
	let(:fuel_quantity){200000}
	let(:airport_id){3}
	let(:aircrapt){Aircraft.new('6E-102')}
	before do
		Singleton.__init__(AirportFuelInventorySystem)
		airport_fuel_inventory.initiate_or_reinitiate
	end

	it "show full fuel summary at all airports" do
		expect(airport_fuel_inventory.show_full_fuel_summary_at_all_airports).to end_with(FULL_FUEL_SUMMARY_AT_ALL_AIRPORTS_OUTPUT)
	end

	it "shows fuel summary at all airports" do
		expect(airport_fuel_inventory.show_fuel_summary_at_all_airports).to end_with(FUEL_SUMMARY_AT_ALL_AIRPORTS_OUTPUT)
	end

	context "Update fuel inventory of a selected airport" do
		it "adds `250000` ltrs to fuel inventory whose airport id is `3`" do
			expect(airport_fuel_inventory.update_fuel_inventory_of_a_selected_airport(airport_id, fuel_quantity)).to end_with("Success: Fuel inventory updated\n")
		end

		it "shows error when add fuel quantity beyond fuel capacity of the airport" do
			expect(airport_fuel_inventory.update_fuel_inventory_of_a_selected_airport(airport_id, fuel_quantity * 4)).to end_with("Error: Goes beyond fuel capacity of the airport\n")
		end
	end


	context "Fill aircraft" do
		it "fills aircraft if not availability at airport" do
			expect(airport_fuel_inventory.fill_aircraft(airport_id, aircrapt, fuel_quantity)).to end_with("Success: Request for the has been fulfilled\n")
		end

		it "shows error when request for the fuel is beyond availability at airport" do
			expect(airport_fuel_inventory.fill_aircraft(airport_id, aircrapt, fuel_quantity * 4)).to end_with("Failure: Request for the fuel is beyond availability at airport\n")
		end
	end
	
end