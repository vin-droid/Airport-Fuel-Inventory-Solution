FuelTransaction = Struct.new(:id, :created_at, :type, :aircraft_id, :fuel_quantity)

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