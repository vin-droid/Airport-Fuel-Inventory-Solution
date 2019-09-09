module Constants
	DEFAULT_AIRPORTS_VALUES	= [{
									id: 1,
									name: "Indira Gandhi International Airport",
									city: "Delhi",
									inventry: {
										initial_fuel: 25066
									}
								},{
									id: 2,
									name: "Rajiv Gandhi International Airport",
									city: "Hyderabad",
									inventry: {
										initial_fuel: 350732
									}
								},{
									id: 3,
									name: "Chhatrapati Shivaji International Airport",
									city: "Mumbai",
									inventry: {
										initial_fuel: 288467
									}
								},{
									id: 4,
									name: "Chennai International Airport",
									city: "Chennai",
									inventry: {
										initial_fuel: 497460
									}
								},{
									id: 5,
									name: "Kempegowda International Airport",
									city: "Bangalore",
									inventry: {
										initial_fuel: 123456
									}
								}]
end

FULL_FUEL_SUMMARY_AT_ALL_AIRPORTS_OUTPUT = <<-EOTXT
Airport ID   Airport Name                                       Fuel Capacity(ltrs)   Fuel Available(ltrs)
1            Indira Gandhi International Airport, Delhi         500000                25066
2            Rajiv Gandhi International Airport, Hyderabad      500000                350732
3            Chhatrapati Shivaji International Airport, Mumbai  500000                288467
4            Chennai International Airport, Chennai             500000                497460
5            Kempegowda International Airport, Bangalore        500000                123456
EOTXT

FUEL_SUMMARY_AT_ALL_AIRPORTS_OUTPUT = <<-EOTXT
Airport                                              Fuel Available
Indira Gandhi International Airport, Delhi           25066
Rajiv Gandhi International Airport, Hyderabad        350732
Chhatrapati Shivaji International Airport, Mumbai    288467
Chennai International Airport, Chennai               497460
Kempegowda International Airport, Bangalore          123456
EOTXT