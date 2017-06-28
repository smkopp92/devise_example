require 'rails_helper'

feature 'user sees followees' do
  let!(:followee) { FactoryGirl.create(:user) }
  let!(:follower) { FactoryGirl.create(:user) }
  let!(:follow) { Follow.create(follower: follower, followee: followee) }

  scenario 'user visits followees link and sees a list of followees' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: follower.email
    fill_in 'Password', with: follower.password
    click_button 'Sign In'

    expect(page).to have_link('Followees')

    click_link 'Followees'

    expect(page).to have_content followee.first_name
  end

  scenario 'unauthenticated user cannot visit followees page' do
    visit root_path

    expect(page).to_not have_link('Followees')
  end

  scenario 'user cannot see someone elses followees' do
    visit root_path

    click_link 'Sign In'

    fill_in 'Email', with: followee.email
    fill_in 'Password', with: followee.password
    click_button 'Sign In'

    visit user_followees_path(follower)

    expect(page.current_path).to eq root_path
  end
end
