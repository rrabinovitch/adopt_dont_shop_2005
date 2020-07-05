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

  it "I can edit the pet's info" do
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

    expect(page).to_not have_content("Maxiiii")

    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in :name, with: "Maxiiii"

    click_on 'Update'

    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_content("Maxiiii")
  end

  it "I can delete the pet" do
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

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content("Max")

    click_on 'Delete Pet'

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content("Max")
  end
end
