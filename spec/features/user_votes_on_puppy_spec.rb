require 'rails_helper'

feature 'user votes', js: true do
  let!(:user) { User.create(
    first_name: 'Sebastian',
    last_name: 'Kopp',
    email: 'Imnottelling@you.never',
    password: 'supersecret',
    password_confirmation: 'supersecret'
  )}

  let!(:puppy) { Puppy.create(
    name: "Doggo",
    img_url: "http://www.lol.jpg"
  )}

  scenario 'users cannot visit users index page' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("Score: 0")

    click_button("Upvote")

    expect(page).to have_content("Score: 1")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
