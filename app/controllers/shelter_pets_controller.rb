class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_pets = Pet.where("shelter_id = #{@shelter.id}")
  end

  def show
    @shelter = Shelter.find(params[:shelter_id])
    @pet = Pet.find(params[:pet_id])
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

  def edit
    @pet = Pet.find(params[:pet_id])
    @shelter = Shelter.find(params[:shelter_id])
  end

  def update
    @shelter = Shelter.find(params[:shelter_id])
    @pet = Pet.find(params[:pet_id])
    @pet.update(pet_params)
    redirect_to "/shelters/#{@shelter.id}/pets/#{@pet.id}"
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :age, :sex, :adoption_status, :shelter_id)
  end
end
