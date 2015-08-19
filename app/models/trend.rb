class Trend < ActiveRecord::Base
  has_many :posts

  def count
      self.posts.size
  end

  def list_x(n)
      self.posts.where(trend_id: self.id).take(n)
  end
end
