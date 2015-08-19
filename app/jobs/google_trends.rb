require 'open-uri'
class GoogleTrends
  @queue = :trends

  def self.perform
    url = 'http://www.google.com/trends/hottrends/atom/hourly'
    open(url) do |http|
      trends = Nokogiri::XML(Nokogiri::XML(http.read).css('content').text).css('li').map(&:text)
      trends.each do |trend|
        unless Trend.find_by(name: trend)
          tre = Trend.create!(name: trend)
          Resque.enqueue(SearchTrend, tre.id)
        end
      end
    end
  end
end
