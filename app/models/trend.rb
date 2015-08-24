class Trend < ActiveRecord::Base
    has_many :posts

    def count
      self.posts.size
    end

    def list_x(n)
      self.posts.order("score ASC").take(n)
    end

    def average_sentiment
      posts.average(:sentiment)
    end
end
