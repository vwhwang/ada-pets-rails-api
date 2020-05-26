class PetsController < ApplicationController
  def index
    pets = Pet.all
    render json: pets.as_json(only: [:id,:name,:age,:species,:owner]), status: :ok
  end
end
