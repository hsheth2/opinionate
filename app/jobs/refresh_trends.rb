class RefreshTrends
  @queue = :trends

  def self.perform
    Trend.where(processed: false).each do |trend|
      trend.update(processed: true)
      Resque.enqueue(SearchTrend, trend.id)
    end
  end
end
