require 'rails_helper'

RSpec.describe "shelter show page", type: :feature do
  it "can see shelter with specified id and its details" do
    shelter = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                              zip: 80216)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content("Address: #{shelter.address}")
    expect(page).to have_content("City: #{shelter.city}")
    expect(page).to have_content("State: #{shelter.state}")
    expect(page).to have_content("Zip: #{shelter.zip}")
  end
end
