class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_pets = Pet.where("shelter_id = #{@shelter.id}")
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter_id = params[:shelter_id]
    pet = Pet.create(pet_params)
    pet.adoption_status = "Adoptable"
    pet.shelter_id = shelter_id
    redirect_to "/shelters/#{shelter_id}/pets"
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :age, :sex, :adoption_status, :shelter_id)
  end
end
