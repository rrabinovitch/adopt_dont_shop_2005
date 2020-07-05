require 'rails_helper'

RSpec.describe "when I visit a shelter's pets index page" do
  it "I can see all pets with that shelter's id" do
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

    pet_3 = Pet.create(name: "Stan",
                      image: "https://modernfarmer.com/wp-content/uploads/2014/03/smart_pig.jpg",
                      age: 15,
                      sex: "Male",
                      description: "He got a perfect SAT score.",
                      adoption_status: "Adoptable",
                      shelter_id: shelter_2.id)

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_xpath("//img[@src='#{pet_1.image}']")
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_xpath("//img[@src='#{pet_2.image}']")
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(pet_2.sex)

    expect(page).to_not have_content(pet_3.name)
    expect(page).to_not have_xpath("//img[@src='#{pet_3.image}']")
    expect(page).to_not have_content(pet_3.age)
    expect(page).to_not have_content(pet_3.sex)
  end

  it "I can follow a link to create a new pet for that shelter" do
    shelter_1 = Shelter.create(name: "Pig Paradise",
                              address: "123 Turing Ave",
                              city: "Denver",
                              state: "Colorado",
                            zip: "80216")

    visit "/shelters/#{shelter_1.id}/pets"

    click_link 'Create Pet'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

    fill_in :name, with: "Max"
    fill_in :image, with: "https://cdn.pixabay.com/photo/2016/01/22/12/23/pig-1155658_1280.jpg"
    fill_in :age, with: 2
    # select "Female", from "Sex"
    fill_in :sex, with: "Female"
    fill_in :description, with: "Find your next gal pal in Max the teacup pig."

    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    expect(page).to have_content("Max")
    # expect(page).to have_xpath("//img[@src=https://cdn.pixabay.com/photo/2016/01/22/12/23/pig-1155658_1280.jpg]")
    expect(page).to have_content("Age: 2")
    expect(page).to have_content("Sex: Female")
  end

  it "I can select a specific pet from that shelter to edit its info" do
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

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to_not have_content("Maxiiii")

    find("##{pet_1.name.gsub(" ", "")}Edit").click

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/#{pet_1.id}/edit")

    fill_in :name, with: "Maxiiii"

    click_on 'Update'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/#{pet_1.id}")

    expect(page).to have_content("Maxiiii")
  end

  it "I can select a specific pet from that shelter to delete" do
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

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_content("Max")

    find("##{pet_1.name.gsub(" ", "")}Delete").click

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

    expect(page).to_not have_content("Max")
  end
end
