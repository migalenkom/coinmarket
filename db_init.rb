require 'sequel'
DB = Sequel.connect("mysql2://#{ARGV[0]}:#{ARGV[1]}@localhost:3306/")
DB.run("create database IF NOT EXISTS coinmarket")
DB.run("use coinmarket")

unless DB.table_exists?(:currencies)
  DB.create_table :currencies, :if_exists=>true do
    primary_key :id, :auto_increment => true
    Integer :rank
    String :name
    String :symbol
    Float :market_cap_usd
    Float :price_usd
    Float :price_btc
    Float :total_supply
    Float :max_supply
    Integer :last_update
  end
end
