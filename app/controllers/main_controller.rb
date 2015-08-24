class MainController < ApplicationController
  def index
      all_trends = Trend.order("id DESC").all
      @trends = Array.new
      all_trends.each do |t|
          @trends << t unless t.count == 0
      end 
  end

  def view_trend
      @trend = Trend.find(params[:id])
      @title = @trend.name
      @posts = @trend.posts.order("score ASC").all
      @search = ! params[:submit].nil?
  end

  def submit
      @insert = Trend.create(name: params[:name])
      Resque.enqueue(SearchTrend, @insert.id)
      @link = url_for( :controller => 'main', :action => 'view_trend', :id => @insert.id, :submit => true )
      redirect_to @link
  end
end
