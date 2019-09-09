Aircraft = Struct.new(:aircraft_id)

class Airport
	attr_accessor :id, :name, :city, :fuel_inventory
	def initialize(id, name, city, fuel_inventory)
		@id            = id
		@name          = name
		@city          = city
		@fuel_inventory = fuel_inventory
	end

	def full_name
		%W(#{name} #{city}).join(', ')
	end

	def fuel_supply_to_inventory(fuel_quantity)
		fuel_inventory.receive_fuel(fuel_quantity)	
	end

	def fill_aircraft(aircraft_id, fuel_quantity)
		aircraft = Aircraft.new(aircraft_id)
		fuel_inventory.fill_aircraft(aircraft, fuel_quantity)
	end

	def available_fuel
		fuel_inventory.available_fuel
	end
end