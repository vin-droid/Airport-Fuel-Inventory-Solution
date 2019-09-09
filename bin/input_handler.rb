require_relative 'airport_fuel_inventory_system'

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

def execute_line(line)
	line_data   = line.split(' ')
	method_name = line_data.shift
	args        = line_data

	begin
		if args.empty?
			exit(true) if method_name.eql?("exit")
	 		AirportFuelInventorySystem.instance.send(method_name) 
		else
	 		AirportFuelInventorySystem.instance.send(method_name, *args) 
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

if ARGV.length == 0
	print("Choose Your Option:\n")

	while !(['exit', '9'].include? (input = STDIN.gets.chomp()))
		begin
			raise StandardError, "Error: Invalid Option" unless input.is_integer?
			execute_input(input) if (0..4) === input.to_i
		rescue StandardError => e
			print "#{e.message}\n"
		end
		print("Choose Your Option:\n")
	end
end
