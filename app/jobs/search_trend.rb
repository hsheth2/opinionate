class SearchTrend
  @queue = :trends

  def self.perform(trend_id)
    #$stdout.reopen("search_trend#{trend_id}.log", "w")
    #$stdout.sync = true
    #$stdout.reopen($stdout)
    #File.open("search_trend_#{trend_id}.log", "w") do |out|

    trend = Trend.find(trend_id)

    # Pull Twitter
    begin
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = "hGErwZDzY9uqBx8GVB3bQi1KZ"
          config.consumer_secret     = "eLtWfiraa0bWTuu8kejZMPQ28YwUBlsZSaTzTtPQutx32kmS1o"
          config.access_token        = "3052946283-0zJ5o4szHgoSNvPl6LMvzjLhSKshibe61PwH4pR"
          config.access_token_secret = "2XUZ30cUcwwnBFCLUr4Gt0ibbgWwzU5tReIyMtAzGBm7Q"
        end
        tweets = client.search(trend.name, count: 100, lang: "en", result_type: "popular")
        #out.puts "Searched trend: "+trend.name
        tweets.each do |tweet|
          unless Post.find_by(url: tweet.url) || tweet.full_text.blank?
            begin
              #out.puts "Processing tweet: "+tweet.url
              Post.create(source: "Twitter", url: tweet.url,content: tweet.full_text, trend: trend, score: 2 * tweet.favorite_count + 6 * tweet.retweet_count, poster: tweet.user.screen_name)
              #out.puts "Success"
            rescue => error
              #out.puts "Failed"
              #out.puts error.backtrace
            end
          end
        end
        #out.puts "Twitter pulled"
    rescue => error
        #out.puts "Twitter failed"
        #out.puts error.backtrace
    end
    #API_KEY = "AIzaSyBHN9R5r4pg0z826PWgJvEn3RVoqHpzfZ4"

    # Pull Youtube
    begin
        #vids = YoutubeSearch.search(trend.name, 'orderby' => 'viewCount', 'time' => 'this_week').take(3)
        vids = YoutubeSearch.search(trend.name).take(3)
        #out.puts "YoutubeSearch success"
        vids.each do |vid|
          unless Post.find_by(service_id: vid['video_id'])
            begin
              #out.puts "Processing YouTube video: "+vid['id']
              Post.create(service_id: vid['video_id'], source: 'YouTube', url: vid['id'], content: vid['content'], trend: trend, score: 0, poster: vid['title'])
              #out.puts "Success"
            rescue => error
              #out.puts "Failed"
              #puts error.backtrace
            end
          end
        end
        #out.puts "Youtube pulled"
    rescue => error
        #out.puts "Youtube failed"
        #puts error.backtrace
    end

    # Pull Reddit
    begin
        r = Redd.it(:userless, "wNFVVtScaTwOlA", "PCzcBMwMkqT-ICNc7XZBL9gNybQ")
        results = r.search(trend.name, sort: :top, limit: 10)
        results.each do |result|
          unless Post.find_by(service_id: result.title)
            begin
              #out.puts "Processing Reddit post: "+result.permalink
              Post.create(service_id: result.title, source: 'Reddit', url: "http://www.reddit.com/"+result.permalink, content: result.title, trend: trend, score: result.score * 7, poster: result.author)
              #out.puts "Success"
            rescue => error
              #out.puts "Failed"
              #out.puts error.backtrace
            end
          end
        end
        #out.puts "Reddit pulled"
    rescue => error
        #out.puts "Reddit failed"
        #out.puts error.backtrace
    end
    #end
  end
end
