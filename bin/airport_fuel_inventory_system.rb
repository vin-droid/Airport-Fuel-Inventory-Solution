# !usr/bin/env ruby
require 'singleton'
require_relative 'constants'
require_relative 'fuel_inventory'
require_relative 'airport'

class AirportFuelInventorySystem
	include Singleton
	include Constants
	attr_accessor :airports

	def initiate_or_reinitiate
		@airports = []
		Constants::DEFAULT_AIRPORTS_VALUES.each.with_index(1) do |hash, index|
			id, name, city = hash.fetch_values(:id,:name, :city)
			initial_fuel   = hash[:inventry][:initial_fuel]
			fuel_inventory  = FuelInventory.new().receive_initial_fuel(initial_fuel)
			@airports     << Airport.new(index, name, city, fuel_inventory)
		end
	end

	def show_full_fuel_summary_at_all_airports
		initiate_or_reinitiate
		output = "Airport ID   Airport Name                                       Fuel Capacity(ltrs)   Fuel Available(ltrs)\n"
		airports.each do |airport|
			output  += "#{airport.id}            #{airport.full_name.ljust(50)} #{airport.fuel_inventory.fuel_capacity}                #{airport.fuel_inventory.available_fuel}\n"
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
		airport.fuel_inventory.receive_fuel(fuel_quantity.to_i)
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
			airport.fuel_inventory.fuel_transactions.each do |fuel_transaction|
				output += "#{fuel_transaction.created_at.strftime('%a, %d %b %Y %H:%M:%S')}  #{fuel_transaction.type.ljust(3)}      #{fuel_transaction.fuel_quantity.to_s.ljust(6)}   #{fuel_transaction.aircraft_id}\n"
			end
			output += "\nFuel Available: #{airport.fuel_inventory.available_fuel}\n"
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