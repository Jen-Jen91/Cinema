require_relative("../db/sql_runner.rb")

class Film

  attr_reader(:id)
  attr_accessor(:title, :price)

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @title = options["title"]
    @price = options["price"].to_i()
  end


  def save()
    sql = "
      INSERT INTO films(title, price)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end


  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end


  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end


  def self.all()
    sql = "SELECT * FROM films;"
    results = SqlRunner.run(sql)
    return results.map {|film| Film.new(film)}
  end


  def update()
    sql = "
      UPDATE films
      SET title = $1, price = $2
      WHERE id = $3;
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    result = SqlRunner.run(sql, [id])
    return Film.new(result[0])
  end


  def customers()
    sql = "
      SELECT customers.* FROM customers
      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      WHERE tickets.film_id = $1;
    "
    results = SqlRunner.run(sql, [@id])
    return results.map{|customer| Customer.new(customer)}
  end


  def how_many_customers()
    customers.length()
  end


  def popular_time()
    sql = "
      SELECT screenings.screening_time
      FROM screenings
      WHERE film_id = $1;
    "
    results = SqlRunner.run(sql, [@id])
    screenings = results.map{|screening| Screening.new(screening)}
    times = screenings.map{|s_time| s_time.screening_time}
    return times.max_by{|time| times.count(time)}
  end


end
