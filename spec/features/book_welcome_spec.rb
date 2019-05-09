require 'rails_helper'

RSpec.describe "it shows visitor welcome page" do
  it "should be a welcome page" do
  visit root_path

  expect(page).to have_content("Book Club")
  expect(page).to have_link("Books")
end 
end
