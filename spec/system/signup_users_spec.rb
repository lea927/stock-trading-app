require 'rails_helper'

RSpec.describe 'Signing up users', driver: :selenium_chrome, js: true do
  
  it 'successfully signs up a user as a broker' do
    visit new_user_registration_path
    choose(option: 2)
    sleep 1
    fill_in 'First Name', with: 'Bob'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'bobsmith@email.com'
    fill_in 'Password', with: 'bob1295'
    fill_in 'Password confirmation', with: 'bob1295'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'successfully signs up a user as a buyer' do
    visit new_user_registration_path
    choose(option: 3)
    sleep 1
    fill_in 'First Name', with: 'Bobby'
    fill_in 'Last Name', with: 'Smiths'
    fill_in 'Email', with: 'bobbysmiths@email.com'
    fill_in 'Password', with: 'bobby1295'
    fill_in 'Password confirmation', with: 'bobby1295'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
