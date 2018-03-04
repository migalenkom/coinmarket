require 'json'
require 'uri'
require 'net/http'
require 'sequel'
require 'logger'

class DataRecord

  def initialize(user = 'root', password = '')
    @user = user
    @password = password
    connection
  end

  def connection
    @db ||= Sequel.connect("mysql2://#{@user}:#{@password}@localhost:3306/coinmarket",
                            max_connections: 15, logger: Logger.new("/tmp/db.log"))
  end
end
