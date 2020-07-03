require 'rails_helper'

RSpec.describe "when I visit the shelters index page", type: :feature do
  it "I can see all shelters" do
    shelter_1 = Shelter.create(name: "Pig Paradise")
    shelter_2 = Shelter.create(name: "The Oinkery")

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end

  it "I can follow a link to create a new shelter" do
    visit '/shelters'

    expect(page).to_not have_content("Pig Paradise")

    click_link 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in :name, with: "Pig Paradise"
    fill_in :address, with: "123 Turing Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: "80216"

    click_on 'Create Shelter'

    expect(current_path).to eq('/shelters')
  end
end
