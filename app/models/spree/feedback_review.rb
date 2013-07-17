class Spree::FeedbackReview < ActiveRecord::Base
  belongs_to :review, class_name: 'Spree::Review'
  belongs_to :user, class_name: Spree.user_class.to_s

  validates :review_id, presence: true
  validates_numericality_of :rating, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: Spree.t(:you_must_enter_value_for_rating)

  attr_accessible :rating, :comment
  default_scope { order('spree_feedback_reviews.created_at DESC') }

  scope :localized, lambda { |lc| where('spree_reviews.locale = ?', lc) }
end
