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
    # expect(page).to have_content(Shelter.where("id = #{pet_1.shelter_id}")[0].name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_xpath("//img[@src='#{pet_2.image}']")
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content(Shelter.find(pet_2.shelter_id).name)
    # expect(page).to have_content(Shelter.where("id = #{pet_2.shelter_id}")[0].name)
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
#                   image: "https://petpigs.com/photo-gallery/cute-pig-nappa/",
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
