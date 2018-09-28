require("pry")
require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/ticket.rb")
require_relative("./models/screening.rb")

Screening.delete_all()
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({"name" => "Harry Potter", "funds" => 30})
customer1.save()
customer2 = Customer.new({"name" => "Ron Weasley", "funds" => 20})
customer2.save()
customer3 = Customer.new({"name" => "Hermione Granger", "funds" => 25})
customer3.save()

film1 = Film.new({
  "title" => "The Dark Knight",
  "price" => 15,
  "screening_time" => "18:30"})
film1.save()
film2 = Film.new({
  "title" => "Mad Max: Fury Road",
  "price" => 20,
  "screening_time" => "21:00"})
film2.save()
film3 = Film.new({
  "title" => "When Harry Met Sally",
  "price" => 10,
  "screening_time" => "16:30"})
film3.save()

ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket2 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket3 = Ticket.new({"customer_id" => customer2.id, "film_id" => film1.id})
ticket4 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})
ticket5 = Ticket.new({"customer_id" => customer3.id, "film_id" => film1.id})
ticket6 = Ticket.new({"customer_id" => customer3.id, "film_id" => film3.id})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()


screening1 = Screening.new({"film_id" => film1.id, "ticket_id" => ticket1.id})
screening2 = Screening.new({"film_id" => film2.id, "ticket_id" => ticket2.id})
screening3 = Screening.new({"film_id" => film1.id, "ticket_id" => ticket3.id})
screening4 = Screening.new({"film_id" => film2.id, "ticket_id" => ticket4.id})
screening5 = Screening.new({"film_id" => film1.id, "ticket_id" => ticket5.id})
screening6 = Screening.new({"film_id" => film3.id, "ticket_id" => ticket6.id})

screening1.save()
screening2.save()
screening3.save()
screening4.save()
screening5.save()
screening6.save()













binding.pry
nil
