# !usr/bin/env ruby
require 'singleton'
require_relative 'constants'

FuelTransaction = Struct.new(:id, :created_at, :type, :aircraft_id, :fuel_quantity)
Aircraft        = Struct.new(:aircraft_id)


class AirportFuelInventory
	include Singleton
	include Constants
	attr_accessor :airports

	def initiate_or_reinitiate
		@airports = []
		Constants::DEFAULT_AIRPORTS_VALUES.each.with_index(1) do |hash, index|
			id, name, city = hash.fetch_values(:id,:name, :city)
			initial_fuel   = hash[:inventry][:initial_fuel]
			fuel_inventry  = FuelInventory.new().receive_initial_fuel(initial_fuel)
			@airports     << Airport.new(index, name, city, fuel_inventry)
		end
	end

	def show_full_fuel_summary_at_all_airports
		initiate_or_reinitiate
		output = "Airport ID   Airport Name                                       Fuel Capacity(ltrs)   Fuel Available(ltrs)\n"
		airports.each do |airport|
			output  += "#{airport.id}            #{airport.full_name.ljust(50)} #{airport.fuel_inventry.fuel_capacity}                #{airport.fuel_inventry.available_fuel}\n"
		end
		output
	end

	def show_fuel_summary_at_all_airports
		output = "Airport                                              Fuel Available\n"
		airports.each do |airport|
			output +="#{airport.full_name.ljust(50)}   #{airport.available_fuel}\n"
		end
		output
	end

	def update_fuel_inventory_of_a_selected_airport(airport_id, fuel_quantity)
		airport = find_airport_by_id(airport_id.to_i)
		airport.fuel_inventry.receive_fuel(fuel_quantity.to_i)
	end

	def fill_aircraft(airport_id, aircraft_id, fuel_quantity)
		airport = find_airport_by_id(airport_id)
		airport.fill_aircraft(aircraft_id, fuel_quantity.to_i)
	end

	def show_fuel_transaction_for_all_airport
		output = ''
		airports.each do |airport|
			output += "Airport: #{airport.full_name}\n"
			output +=  "Date/time                  Type     Fuel     Aircraft\n"
			airport.fuel_inventry.fuel_transactions.each do |fuel_transaction|
				output += "#{fuel_transaction.created_at.strftime('%a, %d %b %Y %H:%M:%S')}  #{fuel_transaction.type.ljust(3)}      #{fuel_transaction.fuel_quantity.to_s.ljust(6)}   #{fuel_transaction.aircraft_id}\n"
			end
			output += "\nFuel Available: #{airport.fuel_inventry.available_fuel}\n"
			output += "---\n"
		end
		output
	end

	def find_airport_by_id(airport_id)
		airport = @airports.find{ |airport| airport.id.eql? airport_id.to_i }
		raise StandardError, "Error: Invalid airport id" if airport.nil?
		airport
	end
end

class Airport
	attr_accessor :id, :name, :city, :fuel_inventry
	def initialize(id, name, city, fuel_inventry)
		@id            = id
		@name          = name
		@city          = city
		@fuel_inventry = fuel_inventry
	end

	def full_name
		%W(#{name} #{city}).join(', ')
	end

	def fuel_supply_to_inventory(fuel_quantity)
		fuel_inventry.receive_fuel(fuel_quantity)	
	end

	def fill_aircraft(aircraft_id, fuel_quantity)
		aircraft = Aircraft.new(aircraft_id)
		fuel_inventry.fill_aircraft(aircraft, fuel_quantity)
	end

	def available_fuel
		fuel_inventry.available_fuel
	end
end

class FuelInventory
	attr_accessor :fuel_capacity, :available_fuel, :fuel_transactions
	FUEL_CAPACITY = 500000
	
	def initialize(available_fuel = 0)
		@fuel_capacity     = FUEL_CAPACITY
		@available_fuel    = available_fuel
		@fuel_transactions = []
	end

	def validate_fuel_quantity(fuel_quantity)
		raise StandardError, "Error: Goes beyond fuel capacity of the airport" if ((fuel_quantity + available_fuel) > fuel_capacity)
	end

	def update_available_fuel_if_supplied(fuel_quantity)
		@available_fuel -= fuel_quantity.to_i
	end

	def receive_initial_fuel(fuel_quantity)
		@available_fuel += fuel_quantity.to_i
		fuel_transaction_params = {
			id: fuel_transactions.length + 1,
			created_at: Time.now,
			type: 'In',
			fuel_quantity: fuel_quantity
		}
		mark_transaction(fuel_transaction_params)
	end

	def receive_fuel(fuel_quantity)
		validate_fuel_quantity(fuel_quantity)
		@available_fuel += fuel_quantity.to_i
		fuel_transaction_params = {
			id: fuel_transactions.length + 1,
			created_at: Time.now,
			type: 'In',
			fuel_quantity: fuel_quantity
		}
		mark_transaction(fuel_transaction_params)
		output = "Success: Fuel inventory updated\n"
	rescue StandardError => e
		output = "#{e.message}\n"
	end

	def mark_transaction(fuel_transaction_params)
		fuel_transaction = FuelTransaction.new(*fuel_transaction_params.values_at(*FuelTransaction.members))
		@fuel_transactions << fuel_transaction
		self
	end

	def fill_aircraft(aircraft, fuel_quantity)
		raise StandardError, "Failure: Request for the fuel is beyond availability at airport" if (available_fuel - fuel_quantity) < 0
		fuel_transaction_params = {
			id: fuel_transactions.length + 1,
			created_at: Time.now,
			type: 'Out',
			fuel_quantity: fuel_quantity,
			aircraft_id: aircraft.aircraft_id
		}
		mark_transaction(fuel_transaction_params)
		update_available_fuel_if_supplied(fuel_quantity)
		output = "Success: Request for the has been fulfilled\n"
	rescue StandardError => e
		output = "#{e.message}\n"
	end
end

def execute_line(line)
	line_data   = line.split(' ')
	method_name = line_data.shift
	args        = line_data

	begin
		if args.empty?
			exit(true) if method_name.eql?("exit")
	 		AirportFuelInventory.instance.send(method_name) 
		else
	 		AirportFuelInventory.instance.send(method_name, *args) 
		end
	rescue StandardError => e
		print "#{e.message}\n"
	end
end

def execute_input(input)

	case input.to_i
	when 0
		execute_line("initiate_or_reinitiate")
		print execute_line("show_full_fuel_summary_at_all_airports");
	when 1
		print execute_line("show_fuel_summary_at_all_airports")
	when 2
		print("Enter Airport ID:\n")
		airport_id    = STDIN.gets.chomp()
		print("Enter Fuel (ltrs):\n")
		fuel_quantity = STDIN.gets.chomp()
		print execute_line("update_fuel_inventory_of_a_selected_airport #{airport_id} #{fuel_quantity}")
	when 3
		print("Enter Airport ID:\n")
		airport_id    = STDIN.gets.chomp()
		print("Enter Aircraft Code:\n")
		aircraft_id   = STDIN.gets.chomp()
		print("Enter Fuel (ltrs):\n")
		fuel_quantity = STDIN.gets.chomp()
		print execute_line("fill_aircraft #{airport_id} #{aircraft_id} #{fuel_quantity}")
	when 4
		print execute_line("show_fuel_transaction_for_all_airport")
	else
		raise StandardError, "Error: Enter valid option" 
	end
end

 