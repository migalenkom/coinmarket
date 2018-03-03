require_relative 'ext/numeric.rb'
require_relative 'app/data_loader.rb'
require_relative 'app/page_builder.rb'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

run lambda { |env|
  request = Rack::Request.new(env)
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    [PageBuilder.new(DataLoader.new.fetch_records).render]
  ]
}
