require_relative("../db/sql_runner.rb")

class Screening

  attr_reader(:id)
  attr_accessor(:film_id, :ticket_id)

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @film_id = options["film_id"].to_i()
    @ticket_id = options["ticket_id"].to_i()
  end


  def save()
    sql = "
      INSERT INTO screenings(film_id, ticket_id)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@film_id, @ticket_id]
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
      SET film_id = $1, ticket_id = $2
      WHERE id = $3;
    "
    values = [@film_id, @ticket_id, @id]
    SqlRunner.run(sql, values)
  end


  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1;"
    result = SqlRunner.run(sql, [id])
    return Screening.new(result[0])
  end





end
