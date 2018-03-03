every '*/10 * * * *' do
  command "ruby #{Dir.pwd}/app/data_grabber.rb 20 >> /#{Dir.pwd}/log/cron.log 2>&1"
end
