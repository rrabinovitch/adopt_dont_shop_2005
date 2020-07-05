require 'rails_helper'

RSpec.describe "when I visit the shelters index page", type: :feature do
  it "I can see all shelters" do
    shelter_1 = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80216")
    shelter_2 = Shelter.create(name: "The Oinkery",
                              address: "543 Main St",
                              city: "Aurora",
                              state: "Colorado",
                              zip: "80255")

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
    expect(page).to have_content("Pig Paradise")
  end

  it "I can select a specific shelter to edit its info" do
    shelter_1 = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80216")
    shelter_2 = Shelter.create(name: "The Oinkery",
                              address: "543 Main St",
                              city: "Aurora",
                              state: "Colorado",
                              zip: "80255")

    visit '/shelters'

    expect(page).to_not have_content("Pig Paradise LLC")

    find("##{shelter_1.name.gsub(" ", "")}Edit").click

    fill_in :name, with: "Pig Paradise LLC"

    click_on 'Update'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Pig Paradise LLC")
  end
end
