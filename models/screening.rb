require_relative("../db/sql_runner.rb")

class Screening

  attr_reader(:id)
  attr_accessor(:film_id, :screening_time, :max_tickets)

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @film_id = options["film_id"].to_i()
    @screening_time = options["screening_time"]
    @max_tickets = options["max_tickets"].to_i()
  end


  def save()
    sql = "
      INSERT INTO screenings(film_id, screening_time, max_tickets)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@film_id, @screening_time, @max_tickets]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end


  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end


  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end


  def self.all()
    sql = "SELECT * FROM screenings;"
    results = SqlRunner.run(sql)
    return results.map {|screening| Screening.new(screening)}
  end


  def update()
    sql = "
      UPDATE screenings
      SET film_id = $1, screening_time = $2, max_tickets = $3
      WHERE id = $4;
    "
    values = [@film_id, @screening_time, @max_tickets, @id]
    SqlRunner.run(sql, values)
  end


  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1;"
    result = SqlRunner.run(sql, [id])
    return Screening.new(result[0])
  end


  def available_tickets()
    sql = "SELECT * FROM tickets WHERE tickets.id = $1"
    results = SqlRunner.run(sql, [@id])
    tickets = results.map {|ticket| Ticket.new(ticket)}
    return @max_tickets - tickets.length()
  end


  def film()
    sql = "SELECT * FROM films
    WHERE films.id = $1"
    values = [@film_id]
    results = SqlRunner.run(sql, values)
    film = results.map {|film| Film.new(film)}
    return film
  end


  # def sell_ticket()
  #   result = available_tickets
  #   result -= 1
  #   update()
  # end


end
