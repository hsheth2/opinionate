class SearchTrend
  @queue = :trends

  def self.perform(trend_id)
    trend = Trend.find(trend_id)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "hGErwZDzY9uqBx8GVB3bQi1KZ"
      config.consumer_secret     = "eLtWfiraa0bWTuu8kejZMPQ28YwUBlsZSaTzTtPQutx32kmS1o"
      config.access_token        = "3052946283-0zJ5o4szHgoSNvPl6LMvzjLhSKshibe61PwH4pR"
      config.access_token_secret = "2XUZ30cUcwwnBFCLUr4Gt0ibbgWwzU5tReIyMtAzGBm7Q"
    end
    tweets = client.search(trend.name, count: 100, lang: "en", result_type: "popular")
    puts "Searched trend: "+trend.name
    tweets.each do |tweet|
      unless Post.find_by(url: tweet.url) || tweet.full_text.blank?
        begin
          Post.create(source: "Twitter", url: tweet.url,content: tweet.full_text, trend: trend, score: 2 * tweet.favorite_count + 6 * tweet.retweet_count, poster: tweet.user.screen_name)
        rescue
        end
      end
    end
    puts "Twitter pulled"
    #API_KEY = "AIzaSyBHN9R5r4pg0z826PWgJvEn3RVoqHpzfZ4"

    #vids = YoutubeSearch.search(trend.name, 'orderby' => 'viewCount', 'time' => 'this_week').take(3)
    vids = YoutubeSearch.search(trend.name).take(3)
    vids.each do |vid|
      unless Post.find_by(service_id: vid['video_id'])
        begin
          Post.create(service_id: vid['video_id'], source: 'YouTube', url: vid['id'], content: vid['content'], trend: trend, score: 0, poster: vid['title'])
        rescue
        end
      end
    end
    puts "Youtube pulled"

    r = Redd.it(:userless, "wNFVVtScaTwOlA", "PCzcBMwMkqT-ICNc7XZBL9gNybQ")
    results = r.search(trend.name, sort: :top, limit: 10)
    results.each do |result|
      unless Post.find_by(service_id: result.title)
        begin
          Post.create(service_id: result.title, source: 'Reddit', url: "http://www.reddit.com/"+result.permalink, content: result.title, trend: trend, score: result.score * 7, poster: result.author)
        rescue
        end
      end
    end
    puts "Reddit pulled"
  end
end
