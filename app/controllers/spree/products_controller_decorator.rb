Spree::ProductsController.class_eval do
  helper Spree::ReviewsHelper
  after_filter :log_impressionist

  def log_impressionist
    impressionist(@product)
  end
end
