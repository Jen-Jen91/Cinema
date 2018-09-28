require("pry")
require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/ticket.rb")





customer1 = Customer.new({"name" => "Harry Potter", "funds" => 30})

customer2 = Customer.new({"name" => "Ron Weasley", "funds" => 20})

customer3 = Customer.new({"name" => "Hermione Granger", "funds" => 25})


film1 = Film.new({"title" => "The Dark Knight", "price" => 15})

film2 = Film.new({"title" => "Mad Max: Fury Road", "price" => 20})

film3 = Film.new({"title" => "When Harry Met Sally", "price" => 10})


ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket2 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket3 = Ticket.new({"customer_id" => customer2.id, "film_id" => film1.id})
ticket4 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})
ticket5 = Ticket.new({"customer_id" => customer3.id, "film_id" => film1.id})
ticket6 = Ticket.new({"customer_id" => customer3.id, "film_id" => film3.id})


















binding.pry
nil
