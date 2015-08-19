class MainController < ApplicationController
  def index
      @trends = Trend.order("id DESC").all
  end
  def view_trend
  end
end
