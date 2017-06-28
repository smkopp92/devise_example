require 'rails_helper'

feature 'user sees followers' do
  let!(:follower) { FactoryGirl.create(:user) }
  let!(:followee) { FactoryGirl.create(:user) }
  let!(:follow) { Follow.create(follower: follower, followee: followee) }

  scenario 'user visits followers link and sees a list of followers' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: followee.email
    fill_in 'Password', with: followee.password
    click_button 'Sign In'

    expect(page).to have_link('Followers')

    click_link 'Followers'

    expect(page).to have_content follower.first_name
  end

  scenario 'unauthenticated user cannot visit followers page' do
    visit root_path

    expect(page).to_not have_link('Followers')
  end

  scenario 'user cannot see someone elses followers' do
    visit root_path

    click_link 'Sign In'

    fill_in 'Email', with: follower.email
    fill_in 'Password', with: follower.password
    click_button 'Sign In'

    visit user_followers_path(followee)

    expect(page.current_path).to eq root_path
  end
end
