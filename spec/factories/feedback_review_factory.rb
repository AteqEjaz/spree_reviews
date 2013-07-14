FactoryGirl.define do
  factory :feedback_review, class: Spree::FeedbackReview do
    comment { Faker::Lorem.paragraphs(3).join("\n") }
    rating 0

    association(:user, factory: :user)
    association(:review, factory: :review)
  end
end
