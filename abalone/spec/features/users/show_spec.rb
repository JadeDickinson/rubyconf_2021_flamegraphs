require 'rails_helper'

describe "When I visit the user Show page" do
  it "as an admin, I see information of a specific user" do
    user = create(:user, :admin)
    sign_in user

    visit user_path(user)

    expect(page).to have_content(user.email)
    expect(page).to have_content(user.organization.name)
  end

  it "as a user, I see information of a specific user" do
    user = create(:user)
    sign_in user

    visit user_path(user)

    expect(page).not_to have_content(user.email)
    expect(page).to have_content(user.organization.name)
  end

  it "as a user who's not logged in, I see no user specific information" do
    user = create(:user)

    visit user_path(user)

    expect(page).not_to have_content(user.email)
    expect(page).not_to have_content("Your organization: #{user.organization.name}")
  end
end
