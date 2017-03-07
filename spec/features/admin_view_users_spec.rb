require 'rails_helper'

feature 'admin user index' do
  let!(:user) { User.create(
    first_name: 'Sebastian',
    last_name: 'Kopp',
    email: 'Imnottelling@you.ever',
    password: 'supersecret',
    password_confirmation: 'supersecret'
  )}
  let(:admin) { User.create(
    first_name: 'Admin',
    last_name: 'Kopp',
    email: 'Imtheadmin@please.believeme',
    password: 'supersecret',
    password_confirmation: 'supersecret',
    admin: true
  )}
  scenario 'admin visits users index page through link' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_link('All Users')

    click_link 'All Users'

    expect(page).to have_content user.first_name
  end

  scenario 'admin visits users index page directly' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    visit admin_users_path

    expect(page).to have_content user.first_name
  end

  scenario 'users cannot visit users index page' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to_not have_link('All Users')

    visit admin_users_path

    expect(page).to_not have_content user.first_name
  end
end
