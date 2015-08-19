class MainController < ApplicationController
  def index
      @trends = Trend.order("id DESC").all
  end
  def view_trend
      @trend = Trend.find(params[:id])
      @title = @trend.name
      @posts = @trend.posts.order("score DESC").all
  end
end
