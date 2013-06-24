require 'spec_helper'

describe "Review Admin", js: true do
  stub_authorization!

  let!(:review) { create(:review) }

  before do
    2.times { create(:review) }
    visit spree.admin_reviews_path
  end

  it "list out the reviews" do
    page.should have_content(review.title)
  end

  it "can approve the reviews" do
    review.approved.should be_false
    page.find("tr#review_#{review.id}").find("a.approve").trigger(:click)
    review.reload.approved.should be_true
  end

  it "can edit the reviews" do
    page.find("tr#review_#{review.id}").find("a.edit").trigger(:click)
    page.should have_content("Editing")
    page.should have_content(review.title)
  end
end
