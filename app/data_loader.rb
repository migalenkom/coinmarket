require_relative 'data_record.rb'
require 'pry'
require 'ostruct'


class DataLoader < DataRecord

  def fetch_records
    currencies = @db[:currencies]
    currencies.order(:id).last(20).map{|e| OpenStruct.new(e)}
  end
end
# DataLoader.new.fetch_records
