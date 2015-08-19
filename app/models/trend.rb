class Trend < ActiveRecord::Base
  has_many :posts

  def count
      self.posts.size
  end

  def list_x(n)
      self.posts.take(n)
  end
end
