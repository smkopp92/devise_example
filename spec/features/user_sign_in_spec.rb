require 'rails_helper'

feature 'user signs in', %Q{
  As a user
  I want to sign in
  So that I can track my breakable toy progress
} do

  # Acceptance Criteria:
  # * if I specify a valid, previously register email and password,
  #   I am authenticated and I gain access to the system
  # * If I specify an invalid email and password, I remain unauthenticated
  # * If I am already signed in, I can't sign in again
  let(:user) { User.create(
    first_name: 'Sebastian',
    last_name: 'Kopp',
    email: 'Imnottelling@you.ever',
    password: 'supersecret',
    password_confirmation: 'supersecret'
  )}
  scenario 'an existing user specifies a valid email and password' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')
  end

  scenario 'a nonexistant email and password is supplied' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: 'ayyyy@lm.ao'
    fill_in 'Password', with: 'cutefuzzypuppykitten'
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an existing email with the wrong password is denied access' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "WRONG"
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated user cannot re-sign in' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit new_user_session_path

    expect(page).to have_content('You are already signed in.')
  end
end
