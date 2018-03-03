require 'erb'
class PageBuilder

    def initialize arr
      @currencies = arr
      @template = File.read('./public/index.html.erb')
    end

    def render
      ERB.new(@template).result( binding )
    end
end
