class Numeric
  def to_currency( pre_symbol='$', thousands=',', decimal='.', post_symbol=nil )
    "#{pre_symbol}#{
      ( "%.2f" % self ).gsub(
        /(\d)(?=(?:\d{3})+(?:$|\.))/,
        "\\1#{thousands}"
      )
    }#{post_symbol}"
  end
end
