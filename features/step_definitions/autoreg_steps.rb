require 'csv'
require 'faker'
require 'faker/internet'
require 'rubygems'
require 'capybara/cucumber'

Given(/^"([^"]*)" fake accounts$/) do |arg1|
  @attempts = arg1.to_i
end

When(/^hacker makes registration$/) do
  Capybara.current_driver = :selenium 

  CSV.open("profiles.csv", "wb") do |csv|
    @attempts.times do
      email = Faker::Internet::safe_email
      password = Faker::Internet::password
      user_name = Faker::Internet::user_name

      visit('http://vks.belpak.by/component/user/?task=register')

      within('.form-validate') do
        fill_in('name', :with => user_name)
        fill_in('username', :with => user_name)
        fill_in('email', :with => email)
        fill_in('password', :with => password)
        fill_in('password2', :with => password)
        click_on('Зарегистрируйтесь')
      end

      csv << [email, password]
    end
  end
end

Then(/^fake emails and passwords for "([^"]*)" accounts placed in profiles\.csv$/) do |arg1|
  count = 0
  CSV.foreach("profiles.csv") { |row| count += 1 }
  count == arg1
end
