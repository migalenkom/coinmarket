# run every 10 minutes */10 * * * *
require './app/data_record.rb'

class DataGrabber < DataRecord

  def grab(limit)
    url = URI("https://api.coinmarketcap.com/v1/ticker/?limit=#{limit}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    pupulate_data(JSON.parse(response.read_body))
 end

 def slice(hash, *keys)
  Hash[ [keys, hash.values_at(*keys)].transpose]
 end

 def pupulate_data(data)
   currencies = @db[:currencies]
  @db.transaction do
    currencies.multi_insert(prepare_values(data))
   end
 end

 def prepare_values(data)
   data.map do |row|
     slice(row, "rank", "name", "symbol", "market_cap_usd",
                "price_usd", "price_btc", "total_supply",
                "max_supply").merge("last_update" => Time.now.to_i)
   end
 end
end
DataGrabber.new.grab(ARGV[0])
