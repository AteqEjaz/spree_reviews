# Add access to reviews/ratings to the product model
Spree::Product.class_eval do
  is_impressionable
  has_many :reviews, class_name: 'Spree::Review'

  attr_accessible :avg_rating, :reviews_count

  def stars
    avg_rating.round
  end
end
