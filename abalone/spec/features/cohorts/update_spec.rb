require 'rails_helper'

describe "When I visit the cohort Edit page" do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "And fill out the form and click the submit button, cohort should be updated" do
    cohort = create(:cohort)

    visit edit_cohort_path(cohort)

    within('form') do
      fill_in 'cohort_name', with: "Gary's new cohort"
      click_on 'Submit'
    end

    expect(page).to have_content 'Cohort was successfully updated.'
    expect(page).to have_content "Gary's new cohort"
  end
end
