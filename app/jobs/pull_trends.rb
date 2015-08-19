class PullTrends
  @queue = :trends

  def self.perform
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "hGErwZDzY9uqBx8GVB3bQi1KZ"
      config.consumer_secret     = "eLtWfiraa0bWTuu8kejZMPQ28YwUBlsZSaTzTtPQutx32kmS1o"
      config.access_token        = "3052946283-0zJ5o4szHgoSNvPl6LMvzjLhSKshibe61PwH4pR"
      config.access_token_secret = "2XUZ30cUcwwnBFCLUr4Gt0ibbgWwzU5tReIyMtAzGBm7Q"
    end
    trends = client.trends(2367105).attrs[:trends]
    trends.each do |trend|
      puts "Found trend: "+trend[:name]
      unless Trend.find_by(name: trend[:name], query: trend[:query])
        tre = Trend.create!(name: trend[:name], query: trend[:query])
        Resque.enqueue(SearchTrend, tre.id)
      end
    end
  end
end
