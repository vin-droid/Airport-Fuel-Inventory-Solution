require_relative 'airport_fuel_inventory'

class String
  def is_integer?
    self.to_i.to_s == self
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
