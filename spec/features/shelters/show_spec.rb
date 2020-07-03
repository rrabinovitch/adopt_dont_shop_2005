require 'rails_helper'

RSpec.describe "when I visit shelter show page", type: :feature do
  it "I can see shelter with the specified id and its details" do
    shelter = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80216")

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content("Address: #{shelter.address}")
    expect(page).to have_content("City: #{shelter.city}")
    expect(page).to have_content("State: #{shelter.state}")
    expect(page).to have_content("Zip: #{shelter.zip}")
  end

  it "I can edit the shelter's info" do
    shelter = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80216")

    visit "/shelters/#{shelter.id}"

    expect(page).to_not have_content("Pig Paradise LLC")

    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{shelter.id}/edit")

    fill_in :name, with: "Pig Paradise LLC"

    click_on 'Update'

    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("Pig Paradise LLC")
  end

  it "I can delete the shelter" do
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

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Pig Paradise")

    click_on 'Delete Shelter'

    expect(current_path).to eq("/shelters")

    expect(page).to_not have_content("Pig Paradise")
  end
end
