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


end
