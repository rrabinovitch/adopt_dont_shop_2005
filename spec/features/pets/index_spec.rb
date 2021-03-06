require 'rails_helper'

RSpec.describe "when I visit the pets index page", type: :feature do
  it "I can see all pets" do
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

    visit '/pets'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_xpath("//img[@src='#{pet_1.image}']")
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(Shelter.find(pet_1.shelter_id).name)
    # expect(page).to have_content(shelter_1.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_xpath("//img[@src='#{pet_2.image}']")
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content(Shelter.find(pet_2.shelter_id).name)
  end

  it "I can select a specific pet to edit its info" do
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

    visit '/pets'

    expect(page).to_not have_content("Maxiiii")

    find("##{pet_1.name.gsub(" ", "")}Edit").click

    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in :name, with: "Maxiiii"

    click_on 'Update'

    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_content("Maxiiii")
  end

  it "I can select a specific pet to delete" do
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

    visit '/pets'

    expect(page).to have_content("Max")

    find("##{pet_1.name.gsub(" ", "")}Delete").click

    expect(current_path).to eq('/pets')

    expect(page).to_not have_content("Max")
  end

  it "I can click on a pet to view its show page" do
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

    visit '/pets'

    click_on "#{pet_1.name}"

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end



# shelter_1 = Shelter.create(name: "Pig Paradise",
#                           address: "123 Turing Ave",
#                           city: "Denver",
#                           state: "Colorado",
#                           zip: "80216")
# shelter_2 = Shelter.create(name: "The Oinkery",
#                           address: "543 Main St",
#                           city: "Aurora",
#                           state: "Colorado",
#                           zip: "80255")
# pet_1 = Pet.create(name: "Max",
#                   image: "https://cdn.pixabay.com/photo/2016/01/22/12/23/pig-1155658_1280.jpg",
#                   age: 2,
#                   sex: "Female",
#                   description: "Find your next gal pal in Max the teacup pig.",
#                   adoption_status: "Adoptable",
#                   shelter_id: shelter_1.id)
#
# pet_2 = Pet.create(name: "Deb",
#                   image: "https://petpigs.com/wp-content/uploads/2011/04/cute-pig-NAPPA.jpg",
#                   age: 26,
#                   sex: "Female",
#                   description: "She's a gift.",
#                   adoption_status: "Adoptable",
#                   shelter_id: shelter_1.id)
#
# pet_3 = Pet.create(name: "Stan",
#                   image: "https://modernfarmer.com/wp-content/uploads/2014/03/smart_pig.jpg",
#                   age: 15,
#                   sex: "Male",
#                   description: "He got a perfect SAT score.",
#                   adoption_status: "Adoptable",
#                   shelter_id: shelter_2.id)
