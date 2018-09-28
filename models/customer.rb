require_relative("../db/sql_runner.rb")

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i()
  end


  def save()
    sql = "
      INSERT INTO customers(name, funds)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end


  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end


  def self.all()
    sql = "SELECT * FROM customers;"
    results = SqlRunner.run(sql)
    return results.map {|customer| Customer.new(customer)}
  end


  def update()
    sql = "
      UPDATE customers
      SET name = $1, funds = $2
      WHERE id = $3;
    "
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    result = SqlRunner.run(sql, [id])
    return Customer.new(result[0])
  end


  def films()
    sql = "
      SELECT films.* FROM films
      INNER JOIN tickets
      ON films.id = tickets.film_id
      WHERE tickets.customer_id = $1;
    "
    results = SqlRunner.run(sql, [@id])
    return results.map{|film| Film.new(film)}
  end


  def buy_ticket()
    sql = "
      SELECT films.price FROM films
      INNER JOIN tickets
      ON films.id = tickets.film_id
      WHERE tickets.customer_id = $1;
    "
    results = SqlRunner.run(sql, [@id])
    price = results[0]["price"].to_i()
    return @funds - price
  end


  def tickets()
    sql = "
      SELECT * FROM tickets
      WHERE tickets.customer_id = $1;
    "
    results = SqlRunner.run(sql, [@id]).to_a()
    return results.length()
  end








end
