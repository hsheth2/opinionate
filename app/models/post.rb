require 'indico'
Indico.api_key = '244f0b9989886cd90b0de09df368dce9'

class Post < ActiveRecord::Base
  belongs_to :trend

  def determine_sentiment
    #print "Getting sentiment... "
    self.sentiment = Indico.sentiment_hq(self.content)
    #puts "Sentiment found to be #{self.sentiment}."
  end

  def scrub_self
    self.content = self.content.scrub
  end

  before_validation :determine_sentiment
  before_validation :scrub_self
end
