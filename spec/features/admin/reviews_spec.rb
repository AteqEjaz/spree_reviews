require 'spec_helper'

feature "Review Admin" do
  stub_authorization!

  given!(:review) { create(:review) }

  background do
    2.times { create(:review) }
    visit spree.admin_reviews_path
  end

  scenario "list out the reviews" do
    expect(page).to have_text(review.title)
  end

  scenario "can approve the reviews" do
    review.approved.should be_false
    page.find("tr#review_#{review.id}").find("a.approve").click
    expect {
      review.reload.approved
    }.to be_true
  end

  scenario "can edit the reviews" do
    page.find("tr#review_#{review.id}").find("a.edit").click
    expect(page).to have_text("Editing")
    expect(page).to have_text(review.title)
  end
end
