module Spree
  module Reviews
    Config = Spree::ReviewsConfiguration.new
    Config.include_unapproved_reviews = true
    Config.show_email = true
    Config.require_login = true
  end
end
