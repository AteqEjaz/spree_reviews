require 'spec_helper'

describe Spree::ReviewSweeper do
  pending "caching" do
    let(:review) { create(:review) }
    let(:product){ create(:product) }
    let(:review_params) do
      { product_id: product.permalink,
        review:   { rating: "3 stars",
                    name:   "Abhishek",
                    title:  "Great Product",
                    review: "some big review text" }}
    end

    let(:create_cache_path) { 'views/test.host' + spree.admin_create_review_path(review) }

    around do |example|
      caching, ActionController::Base.perform_caching = ActionController::Base.perform_caching, true
      store, ActionController::Base.cache_store = ActionController::Base.cache_store, :memory_store
      silence_warnings { Object.const_set "RAILS_CACHE", ActionController::Base.cache_store }

      example.run

      silence_warnings { Object.const_set "RAILS_CACHE", store }
      ActionController::Base.cache_store = store
      ActionController::Base.perform_caching = caching
    end

    it "action cache #create" do
      Rails.cache.clear
      Spree::ReviewsController.caches_action :create # must be recapitulated to get around load time weirdfullness
      spree_get :create, review_params
      ActionController::Base.cache_store.exist?(create_cache_path).should be_true
    end

    it "clear the cache on #create" do
      ActionController::Base.cache_store.write(create_cache_path, "CACHED ACTION")
      spree_put :create, review_param
      ActionController::Base.cache_store.exist?(spree.sign_up_cache_path).should be_false
    end
  end
end
