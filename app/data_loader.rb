require_relative 'data_record.rb'
require 'ostruct'

class DataLoader < DataRecord

  def fetch_records
    query = <<-SQL
      SELECT t1.*, avg_price, last_price-price_usd as delta FROM currencies t1
      JOIN (SELECT symbol, MAX(id) as id, avg(price_usd) as avg_price,
      price_usd as last_price
      FROM currencies
      WHERE last_update BETWEEN #{Time.now.to_i-3600*24} AND #{Time.now.to_i}
      GROUP BY symbol) t2
      ON t1.id = t2.id AND t1.symbol = t2.symbol
      order by rank
    SQL
    @db[query].all.map{|e| OpenStruct.new e}
  end
end
