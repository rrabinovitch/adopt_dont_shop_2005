require 'rails_helper'

RSpec.describe "when I visit a pet show page" do
  it "I can see the pet with the specified id and its details" do
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

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_xpath("//img[@src='#{pet_1.image}']")
    expect(page).to have_content(pet_1.adoption_status)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.description)
  end
end
