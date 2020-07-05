require 'rails_helper'

RSpec.describe "when I visit a shelter show page" do
  it "I can see the shelter with the specified id and its details" do
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

  it "I can navigate to the shelter's pets page" do
    shelter_1 = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80216")
    pet_1 = Pet.create(name: "Max",
                      image: "https://cdn.pixabay.com/photo/2016/01/22/12/23/pig-1155658_1280.jpg",
                      age: 2,
                      sex: "Female",
                      description: "Find your next gal pal in Max the teacup pig.",
                      adoption_status: "Adoptable",
                      shelter_id: shelter_1.id)
    pet_2 = Pet.create(name: "Deb",
                      image: "https://petpigs.com/wp-content/uploads/2011/04/cute-pig-NAPPA.jpg",
                      age: 26,
                      sex: "Female",
                      description: "She's a gift.",
                      adoption_status: "Adoptable",
                      shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}"

    click_on "View #{shelter_1.name}'s Pets"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end
end
