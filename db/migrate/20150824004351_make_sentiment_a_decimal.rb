class MakeSentimentADecimal < ActiveRecord::Migration
  def change
      change_column :posts, :sentiment, :decimal, :precision => 6, :scale => 5
  end
end
