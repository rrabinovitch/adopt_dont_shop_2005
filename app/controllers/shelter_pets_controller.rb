class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_pets = Pet.where("shelter_id = #{@shelter.id}")
  end
end
